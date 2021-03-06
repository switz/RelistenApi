using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Relisten.Api.Models;
using Dapper;
using Relisten.Vendor;
using Relisten.Data;
using System.Text.RegularExpressions;
using Microsoft.Extensions.Logging;
using System.Diagnostics;
using System.Globalization;
using Relisten.Vendor.Phishin;
using Hangfire.Server;
using Hangfire.Console;

namespace Relisten.Import
{
    public class PhishinImporter : ImporterBase
    {
        public const string DataSourceName = "phish.in";

        protected SourceService _sourceService { get; set; }
        protected SourceSetService _sourceSetService { get; set; }
        protected SourceReviewService _sourceReviewService { get; set; }
        protected SourceTrackService _sourceTrackService { get; set; }
        protected VenueService _venueService { get; set; }
        protected TourService _tourService { get; set; }
        protected EraService _eraService { get; set; }
        protected SetlistSongService _setlistSongService { get; set; }
        protected SetlistShowService _setlistShowService { get; set; }
        protected ILogger<PhishinImporter> _log { get; set; }

        public PhishinImporter(
            DbService db,
            VenueService venueService,
            TourService tourService,
            SourceService sourceService,
            SourceSetService sourceSetService,
            SourceReviewService sourceReviewService,
            SourceTrackService sourceTrackService,
            SetlistSongService setlistSongService,
            SetlistShowService setlistShowService,
            EraService eraService,
            ILogger<PhishinImporter> log
        ) : base(db)
        {
            this._setlistSongService = setlistSongService;
            this._setlistShowService = setlistShowService;
            this._sourceService = sourceService;
            this._venueService = venueService;
            this._tourService = tourService;
            this._log = log;
            _sourceReviewService = sourceReviewService;
            _sourceTrackService = sourceTrackService;
            _sourceSetService = sourceSetService;
            _eraService = eraService;
        }

		public override string ImporterName => "phish.in";

        public override ImportableData ImportableDataForArtist(Artist artist)
        {
            return ImportableData.Sources
             | ImportableData.Venues
             | ImportableData.Tours
             | ImportableData.Eras
             | ImportableData.SetlistShowsAndSongs
             ;
        }

        public override async Task<ImportStats> ImportDataForArtist(Artist artist, ArtistUpstreamSource src, PerformContext ctx)
        {
            await PreloadData(artist);

            var stats = new ImportStats();

			ctx?.WriteLine("Processing Eras");
            stats += await ProcessEras(artist, ctx);

			ctx?.WriteLine("Processing Tours");
            stats += await ProcessTours(artist, ctx);

			ctx?.WriteLine("Processing Songs");
            stats += await ProcessSongs(artist, ctx);
   
			ctx?.WriteLine("Processing Venues");
   		    stats += await ProcessVenues(artist, ctx);

			ctx?.WriteLine("Processing Shows");
			stats += await ProcessShows(artist, ctx);

			ctx?.WriteLine("Rebuilding");
            await RebuildShows(artist);
            await RebuildYears(artist);

            return stats;
            //return await ProcessIdentifiers(artist, await this.http.GetAsync(SearchUrlForArtist(artist)));
        }

        private IDictionary<string, Source> existingSources = new Dictionary<string, Source>();
        private IDictionary<string, Era> existingEras = new Dictionary<string, Era>();
        private IDictionary<string, Venue> existingVenues = new Dictionary<string, Venue>();
        private IDictionary<string, Tour> existingTours = new Dictionary<string, Tour>();
        private IDictionary<string, SetlistShow> existingSetlistShows = new Dictionary<string, SetlistShow>();
        private IDictionary<string, SetlistSong> existingSetlistSongs = new Dictionary<string, SetlistSong>();

        private IDictionary<string, Era> yearToEraMapping = new Dictionary<string, Era>();

        async Task PreloadData(Artist artist)
        {
            existingSources = (await _sourceService.AllForArtist(artist)).
                GroupBy(venue => venue.upstream_identifier).
                ToDictionary(grp => grp.Key, grp => grp.First());

            existingEras = (await _eraService.AllForArtist(artist)).
                GroupBy(era => era.name).
                ToDictionary(grp => grp.Key, grp => grp.First());

            existingVenues = (await _venueService.AllForArtist(artist)).
                GroupBy(venue => venue.upstream_identifier).
                ToDictionary(grp => grp.Key, grp => grp.First());

            existingTours = (await _tourService.AllForArtist(artist)).
                GroupBy(tour => tour.upstream_identifier).
                ToDictionary(grp => grp.Key, grp => grp.First());

            existingSetlistShows = (await _setlistShowService.AllForArtist(artist)).
                GroupBy(show => show.upstream_identifier).
                ToDictionary(grp => grp.Key, grp => grp.First());

            existingSetlistSongs = (await _setlistSongService.AllForArtist(artist)).
                GroupBy(song => song.upstream_identifier).
                ToDictionary(grp => grp.Key, grp => grp.First());
        }

        private string PhishinApiUrl(string api, string sort_attr = null)
        {
            return $"http://phish.in/api/v1/{api}.json?per_page=99999" + (sort_attr != null ? "&sort_attr=" + sort_attr : "");
        }

		private async Task<T> PhishinApiRequest<T>(string apiRoute, PerformContext ctx, string sort_attr = null)
        {
            var url = PhishinApiUrl(apiRoute, sort_attr);
			ctx?.WriteLine($"Requesting {url}");
            var resp = await http.GetAsync(url);
            return JsonConvert.DeserializeObject<PhishinRootObject<T>>(await resp.Content.ReadAsStringAsync()).data;
        }

		public async Task<ImportStats> ProcessTours(Artist artist, PerformContext ctx)
        {
            var stats = new ImportStats();

            foreach (var tour in await PhishinApiRequest<IEnumerable<PhishinSmallTour>>("tours", ctx))
            {
                var dbTour = existingTours.GetValue(tour.id.ToString());

                if (dbTour == null)
                {
                    dbTour = await _tourService.Save(new Tour
                    {
                        updated_at = tour.updated_at,
                        artist_id = artist.id,
                        start_date = DateTime.Parse(tour.starts_on),
                        end_date = DateTime.Parse(tour.ends_on),
                        name = tour.name,
                        slug = Slugify(tour.name),
                        upstream_identifier = tour.id.ToString()
                    });

                    existingTours[dbTour.upstream_identifier] = dbTour;

                    stats.Created++;
                }
                else if(tour.updated_at > dbTour.updated_at)
                {
                    dbTour.start_date = DateTime.Parse(tour.starts_on);
                    dbTour.end_date = DateTime.Parse(tour.ends_on);
                    dbTour.name = tour.name;

                    dbTour = await _tourService.Save(dbTour);

                    existingTours[dbTour.upstream_identifier] = dbTour;

                    stats.Updated++;
                }
            }

            return stats;
        }

        public async Task<ImportStats> ProcessEras(Artist artist, PerformContext ctx)
        {
            var stats = new ImportStats();

            var order = 0;

            foreach (var era in await PhishinApiRequest<IDictionary<string, IList<string>>>("eras", ctx))
            {
                var dbEra = existingEras.GetValue(era.Key);

                if (dbEra == null)
                {
                    dbEra = await _eraService.Save(new Era()
                    {
                        artist_id = artist.id,
                        name = era.Key,
                        order = order,
                        updated_at = DateTime.Now
                    });

                    existingEras[dbEra.name] = dbEra;

                    stats.Created++;
                }

                foreach (var year in era.Value)
                {
                    yearToEraMapping[year] = dbEra;
                }

                order++;
            }

            return stats;
        }

        public async Task<ImportStats> ProcessSongs(Artist artist, PerformContext ctx)
        {
            var stats = new ImportStats();

            var songsToSave = new List<SetlistSong>();

            foreach (var song in await PhishinApiRequest<IEnumerable<PhishinSmallSong>>("songs", ctx))
            {
                var dbSong = existingSetlistSongs.GetValue(song.id.ToString());

                // skip aliases for now
                if (dbSong == null && song.alias_for.HasValue == false)
                {
                    songsToSave.Add(new SetlistSong()
                    {
                        updated_at = song.updated_at,
                        artist_id = artist.id,
                        name = song.title,
                        slug = Slugify(song.title),
                        upstream_identifier = song.id.ToString()
                    });
                }
            }

            var newSongs = await _setlistSongService.InsertAll(artist, songsToSave);

            foreach (var s in newSongs)
            {
                existingSetlistSongs[s.upstream_identifier] = s;
            }

            stats.Created += newSongs.Count();

            return stats;
        }

        public async Task<ImportStats> ProcessVenues(Artist artist, PerformContext ctx)
        {
            var stats = new ImportStats();

            foreach (var venue in await PhishinApiRequest<IEnumerable<PhishinSmallVenue>>("venues", ctx))
            {
                var dbVenue = existingVenues.GetValue(venue.id.ToString());

                if (dbVenue == null)
                {
                    dbVenue = await _venueService.Save(new Venue()
                    {
                        updated_at = venue.updated_at,
                        artist_id = artist.id,
                        name = venue.name,
                        location = venue.location,
                        slug = Slugify(venue.name),
                        latitude = venue.latitude,
                        longitude = venue.longitude,
                        past_names = venue.past_names,
                        upstream_identifier = venue.id.ToString()
                    });

                    existingVenues[dbVenue.upstream_identifier] = dbVenue;

                    stats.Created++;
                }
                else if(venue.updated_at > dbVenue.updated_at)
                {
                    dbVenue.name = venue.name;
                    dbVenue.location = venue.location;
                    dbVenue.longitude = venue.longitude;
                    dbVenue.latitude = venue.latitude;
                    dbVenue.past_names = venue.past_names;
                    dbVenue.updated_at = venue.updated_at;

                    dbVenue = await _venueService.Save(dbVenue);

                    existingVenues[dbVenue.upstream_identifier] = dbVenue;

                    stats.Updated++;
                }
            }

            return stats;
        }

        private int SetIndexForIdentifier(string ident)
        {
            if (ident == "S") { return 0; }
            else if (ident == "1") { return 1; }
            else if (ident == "2") { return 2; }
            else if (ident == "3") { return 3; }
            else if (ident == "4") { return 4; }
            else if (ident == "E") { return 5; }
            else if (ident == "E2") { return 6; }
            else if (ident == "E3") { return 7; }
            else { return 8; }
        }

        private async Task ProcessSetlistShow(ImportStats stats, PhishinShow show, Artist artist, Source dbSource, IDictionary<string, SourceSet> sets)
        {
            var dbShow = existingSetlistShows.GetValue(show.date);

            var addSongs = false;

            if (dbShow == null)
            {
                dbShow = await _setlistShowService.Save(new SetlistShow()
                {
                    artist_id = artist.id,
                    upstream_identifier = show.date,
                    date = DateTime.Parse(show.date),
                    venue_id = existingVenues[show.venue.id.ToString()].id,
                    tour_id = existingTours[show.tour_id.ToString()].id,
                    era_id = yearToEraMapping.GetValue(show.date.Substring(0, 4), yearToEraMapping["1983-1987"]).id,
                    updated_at = dbSource.updated_at
                });

                stats.Created++;

                addSongs = true;
            }
            else if (show.updated_at > dbShow.updated_at)
            {
                dbShow.date = DateTime.Parse(show.date);
                dbShow.venue_id = existingVenues[show.venue.id.ToString()].id;
                dbShow.tour_id = existingTours[show.tour_id.ToString()].id;
                dbShow.era_id = yearToEraMapping.GetValue(show.date.Substring(0, 4), yearToEraMapping["1983-1987"]).id;
                dbShow.updated_at = dbSource.updated_at;

                dbShow = await _setlistShowService.Save(dbShow);

                stats.Updated++;
                stats.Removed += await _setlistShowService.RemoveSongPlays(dbShow);

                addSongs = true;
            }

            if (addSongs)
            {
                var dbSongs = show.tracks.
                    SelectMany(phishinTrack => phishinTrack.song_ids.Select(song_id => existingSetlistSongs.GetValue(song_id.ToString()))).
                    Where(t => t != null).
                    GroupBy(t => t.upstream_identifier).
                    Select(g => g.First()).
                    ToList()
                    ;

                stats.Created += await _setlistShowService.AddSongPlays(dbShow, dbSongs);
            }
        }

        private async Task<Source> ProcessShow(ImportStats stats, Artist artist, Source dbSource, PerformContext ctx)
        {
            var fullShow = await PhishinApiRequest<PhishinShow>("shows/" + dbSource.upstream_identifier, ctx);

            dbSource.has_jamcharts = fullShow.tags.Contains("Jamcharts");
            dbSource = await _sourceService.Save(dbSource);

            var sets = new Dictionary<string, SourceSet>();

            foreach (var track in fullShow.tracks)
            {
                var set = sets.GetValue(track.set);

                if (set == null)
                {
                    set = await _sourceSetService.Insert(new SourceSet()
                    {
                        source_id = dbSource.id,
                        index = SetIndexForIdentifier(track.set),
                        name = track.set_name,
                        is_encore = track.set[0] == 'E',
                        updated_at = dbSource.updated_at
                    });

                    // this needs to be set after loading from the db
                    set.tracks = new List<SourceTrack>();

                    stats.Created++;

                    sets[track.set] = set;
                }

                set.tracks.Add(new SourceTrack()
                {
                    source_set_id = set.id,
					source_id = dbSource.id,
                    title = track.title,
                    duration = track.duration,
                    track_position = track.position,
                    slug = Slugify(track.title),
                    mp3_url = track.mp3,
                    updated_at = dbSource.updated_at
                });
            }

            stats.Created += (await _sourceTrackService.InsertAll(sets.SelectMany(kvp => kvp.Value.tracks))).Count();

            await ProcessSetlistShow(stats, fullShow, artist, dbSource, sets);

            return dbSource;
        }

        public async Task<ImportStats> ProcessShows(Artist artist, PerformContext ctx)
        {
            var stats = new ImportStats();

			var shows = (await PhishinApiRequest<IEnumerable<PhishinSmallShow>>("shows", ctx, "date")).ToList();

			var prog = ctx?.WriteProgressBar();

			await shows.AsyncForEachWithProgress(prog, async show =>
			{
				var dbSource = existingSources.GetValue(show.id.ToString());

				if (dbSource == null)
				{
					dbSource = await ProcessShow(stats, artist, new Source()
					{
						updated_at = show.updated_at,
						artist_id = artist.id,
						venue_id = existingVenues[show.venue_id.ToString()].id,
						display_date = show.date,
						upstream_identifier = show.id.ToString(),
						is_soundboard = show.sbd,
						is_remaster = show.remastered,
						description = "",
						taper_notes = show.taper_notes
					}, ctx);

					existingSources[dbSource.upstream_identifier] = dbSource;

					stats.Created++;
				}
				else if (show.updated_at > dbSource.updated_at)
				{
					dbSource.updated_at = show.updated_at;
					dbSource.venue_id = existingVenues[show.venue_id.ToString()].id;
					dbSource.display_date = show.date;
					dbSource.upstream_identifier = show.id.ToString();
					dbSource.is_soundboard = show.sbd;
					dbSource.is_remaster = show.remastered;
					dbSource.description = "";
					dbSource.taper_notes = show.taper_notes;

					stats.Removed += await _sourceService.DropAllSetsAndTracksForSource(dbSource);

					dbSource = await ProcessShow(stats, artist, dbSource, ctx);

					existingSources[dbSource.upstream_identifier] = dbSource;

					stats.Updated++;
				}
			});

            return stats;
        }
    }
}