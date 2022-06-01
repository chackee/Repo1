using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TravelAgency.Data;

namespace TravelAgency.Controllers
{
    public class DestinationsController : Controller
    {
        private readonly AppDbContext _context;

        public DestinationsController(AppDbContext context)
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
