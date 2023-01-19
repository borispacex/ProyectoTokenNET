using Microsoft.AspNetCore.Mvc;
using ProyectoToken.Custom;
using ProyectoToken.Services;
using System.IdentityModel.Tokens.Jwt;

namespace ProyectoToken.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IAutorizacionService _autorizacionService;

        public UsuarioController(IAutorizacionService autorizacionService)
        {
            _autorizacionService = autorizacionService;
        }

        [HttpPost("Autenticar")]
        public async Task<IActionResult> Autenticar([FromBody] AutorizacionRequest autorizacion)
        {
            var resultado_autorizacion = await _autorizacionService.DevolverToken(autorizacion);
            if (resultado_autorizacion == null)
            {
                return Unauthorized();
            }
            return Ok(resultado_autorizacion);
        }

        [HttpPost("ObtenerRefreshToken")]
        public async Task<IActionResult> ObtenerRefreshToken([FromBody] RefreshTokenRequest request)
        {
            var tokenHadler = new JwtSecurityTokenHandler();
            var tokenExpiradoSupuestamente = tokenHadler.ReadJwtToken(request.TokenExpirado);

            if (tokenExpiradoSupuestamente.ValidTo > DateTime.UtcNow)
            {
                return BadRequest(new AutorizacionResponse { Resultado = false, Msg = "Token no ha expirado" });
            }
            string idUsuario = tokenExpiradoSupuestamente.Claims.First(x => x.Type == JwtRegisteredClaimNames.NameId).Value.ToString();
            var autorizacionResponse = await _autorizacionService.DevolverRefreshToken(request, int.Parse(idUsuario));

            if (autorizacionResponse.Resultado)
            {
                return Ok(autorizacionResponse);
            } else
            {
                return BadRequest(autorizacionResponse);
            }
        }
    }
}
