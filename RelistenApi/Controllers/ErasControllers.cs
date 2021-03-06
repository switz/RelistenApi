using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Relisten.Api;
using Dapper;
using Relisten.Api.Models;
using Relisten.Data;
using Relisten.Api.Models.Api;

namespace Relisten.Controllers
{
    [Route("api/v2/artists")]
    [Produces("application/json")]
    public class ErasController : RelistenBaseController
    {
        protected EraService _eraService;

        public ErasController(
            RedisService redis,
            DbService db,
			ArtistService artistService,
            EraService eraService
		) : base(redis, db, artistService) {
            _eraService = eraService;
        }

        [HttpGet("{artistIdOrSlug}/eras")]
        [ProducesResponseType(typeof(ResponseEnvelope<IEnumerable<Era>>), 200)]
        [ProducesResponseType(typeof(ResponseEnvelope<bool>), 404)]
        public async Task<IActionResult> eras(string artistIdOrSlug)
        {
            return await ApiRequest(artistIdOrSlug, (art) => {
                return _eraService.AllForArtist(art);
            });
        }

    }
}
