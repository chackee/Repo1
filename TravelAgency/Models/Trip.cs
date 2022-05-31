using System.ComponentModel.DataAnnotations;
using TravelAgency.Data.Enums;

namespace TravelAgency.Models
{
    public class Trip
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string PictureURL { get; set; }
        public List<string> Gallery { get; set; }
        public int LengthOfTrip { get; set; }
        public double Price { get; set; }
        public TripCategory TripCategory { get; set; }
        public int Hardness { get; set; }
        public TypeOfFood TypeOfFood { get; set; }
        public TypeOfTravel TypeOfTravel { get; set; }
        public TypeOfStay TypeOfStay { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Description { get; set; }
        public string Description2 { get; set; }

        //Relationships
        public List<Guide> Guides { get; set; }
        public List<Destination> Destinations { get; set; }


    }
}
