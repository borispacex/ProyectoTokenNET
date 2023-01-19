using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ProyectoToken.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PaisesController : ControllerBase
    {
        [HttpGet("Lista")]
        public async Task<IActionResult> Lista()
        {
            var listaPaises = await Task.FromResult(new List<string> { "Francia", "Argentina", "Croacia", "Marruecos" });
            return Ok(listaPaises);
        }
    }
}
