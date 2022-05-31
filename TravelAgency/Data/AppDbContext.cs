using Microsoft.EntityFrameworkCore;

namespace TravelAgency.Data
{
    public class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) 
            : base(options)
        {

        }
    }
}
