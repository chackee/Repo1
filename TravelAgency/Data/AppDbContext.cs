using Microsoft.EntityFrameworkCore;
using TravelAgency.Models;

namespace TravelAgency.Data
{
    public class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) 
            : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Trip_Guide>().HasKey(tg => new
            {
                tg.TripId,
                tg.GuideId
            });

            modelBuilder.Entity<Trip_Guide>().HasOne(t => t.Trip).WithMany(tg => tg.Trips_Guides).HasForeignKey(t => t.TripId);
            modelBuilder.Entity<Trip_Guide>().HasOne(t => t.Guide).WithMany(tg => tg.Trips_Guides).HasForeignKey(t => t.GuideId);

            base.OnModelCreating(modelBuilder);
        }

        public DbSet<Guide> Guides { get; set; }
        public DbSet<Trip> Trips { get; set; }
        public DbSet<Destination> Destinations { get; set; }
        public DbSet<Trip_Guide> Trips_Guides { get; set; }
    }
}
