using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelAgency.Data;

namespace TravelAgency.Controllers
{
    public class GuidesController : Controller
    {
        private readonly AppDbContext _context;

        public GuidesController(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var allGuides = await _context.Guides.ToListAsync();
            return View();
        }
    }
}
