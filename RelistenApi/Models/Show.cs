using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Reflection;
using System.Text;
using Newtonsoft.Json;

namespace Relisten.Api.Models
{
    public class Show : BaseRelistenModel
    {
        [Required]
        public int artist_id { get; set; }

        public int? venue_id { get; set; }
        public Venue venue { get; set; }

        public int? tour_id { get; set; }
        public Tour tour { get; set; }

        public int? year_id { get; set; }
        public Year year { get; set; }

        public int? era_id { get; set; }
        public Era era { get; set; }

        /// <summary>ONLY DATE</summary>
        [Required]
        public DateTime date { get; set; }

        [Required]
        public float avg_rating { get; set; }
        public float? avg_duration { get; set; }

        [Required]
        public string display_date { get; set; }

        [Required]
        public int? sources_count { get; set; }
    }

    public class ShowWithArtist : Show
    {
        [Required]
        public Artist artist { get; set; }
    }

    public class ShowWithSources : Show
    {
        [Required]
        public IEnumerable<SourceFull> sources { get; set; }
    }
}