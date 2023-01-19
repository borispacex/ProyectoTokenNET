using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using ProyectoToken.Custom;
using ProyectoToken.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace ProyectoToken.Services
{
    public class AutorizacionService : IAutorizacionService
    {
        private readonly DbpruebaContext _context;
        private readonly IConfiguration _configuration;

        public AutorizacionService(DbpruebaContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        public async Task<AutorizacionResponse> DevolverToken(AutorizacionRequest autorizacion)
        {
            var usuario_encontrado = _context.Usuarios.FirstOrDefault(x => x.NombreUsuario == autorizacion.NombreUsuario &&
                x.Clave == autorizacion.Clave);
            
            if (usuario_encontrado == null)
            {
                return await Task.FromResult<AutorizacionResponse>(null);
            }
            string tokenCreado = GenerarToken(usuario_encontrado.IdUsuario.ToString());
            string refreshTokenCreado = GenerarRefreshToken();

            return await GuardarHistorialRefreshToken(usuario_encontrado.IdUsuario, tokenCreado, refreshTokenCreado);
            //return new AutorizacionResponse() { Token = tokenCreado, Resultado = true, Msg = "OK" };
        }

        public async Task<AutorizacionResponse> DevolverRefreshToken(RefreshTokenRequest refreshTokenRequest, int idUsuario)
        {
            var refreshTokenEncontrado = _context.HistorialRefreshTokens.FirstOrDefault(x => x.Token == refreshTokenRequest.TokenExpirado
                && x.RefreshToken == refreshTokenRequest.RefreshToken && x.IdUsuario == idUsuario);
            
            if (refreshTokenEncontrado == null)
            {
                return new AutorizacionResponse { Resultado = false, Msg = "No existe refreshToken",  };
            }
            
            var tokenCreado = GenerarToken(idUsuario.ToString());
            var refreshTokenCreado = GenerarRefreshToken();

            return await GuardarHistorialRefreshToken(idUsuario, tokenCreado, refreshTokenCreado);
        }

        private string GenerarRefreshToken()
        {
            var byteArray = new byte[64];
            var refreshToken = "";

            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(byteArray);
                refreshToken = Convert.ToBase64String(byteArray);
            }
            return refreshToken;
        }

        private async Task<AutorizacionResponse> GuardarHistorialRefreshToken(int idUsuario, string token, string refreshToken   )
        {
            var historialRefreshToken = new HistorialRefreshToken
            {
                IdUsuario = idUsuario,
                Token = token,
                RefreshToken = refreshToken,
                FechaCreacion = DateTime.UtcNow,
                FechaExpiracion = DateTime.UtcNow.AddMinutes(2)
            };
            await _context.HistorialRefreshTokens.AddAsync(historialRefreshToken);
            await _context.SaveChangesAsync();
            return new AutorizacionResponse { Token = token, RefreshToken = refreshToken, Resultado = true, Msg = "OK" };
        }

        private string GenerarToken(string idUsuario)
        {
            var key = _configuration.GetValue<string>("JwtSettings:Key");
            var keyBytes = Encoding.ASCII.GetBytes(key);

            var claims = new ClaimsIdentity();
            claims.AddClaim(new Claim(ClaimTypes.NameIdentifier, idUsuario));

            var credencialesToken = new SigningCredentials(
                new SymmetricSecurityKey(keyBytes),
                SecurityAlgorithms.HmacSha256Signature
            );
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = claims,
                Expires = DateTime.UtcNow.AddMinutes(1),
                SigningCredentials = credencialesToken
            };
            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenConfig = tokenHandler.CreateToken(tokenDescriptor);

            string tokenCreado = tokenHandler.WriteToken(tokenConfig);

            return tokenCreado;
        }
    }
}
