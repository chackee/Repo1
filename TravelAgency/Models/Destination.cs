using System.ComponentModel.DataAnnotations;
using TravelAgency.Data.Enums;

namespace TravelAgency.Models
{
    public class Destination
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Description is required")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Continent is required")]
        public Continent Continent { get; set; }

        //Relationships
        public List<Trip> Trips { get; set; }
    }
}
