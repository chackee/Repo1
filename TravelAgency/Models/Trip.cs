using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using TravelAgency.Data.Enums;

namespace TravelAgency.Models
{
    public class Trip
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string PictureURL { get; set; }
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
        public List<Trip_Guide> Trips_Guides { get; set; }

        //Destination
        public int DestinationId { get; set; }
        [ForeignKey("DestinationId")]
        public Destination Destinations { get; set; }


    }
}
