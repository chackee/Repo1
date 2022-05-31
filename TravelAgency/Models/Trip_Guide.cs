namespace TravelAgency.Models
{
    public class Trip_Guide
    {
        public int TripId { get; set; }
        public Trip Trip { get; set; }
        public int GuideId { get; set; }
        public Guide Guide { get; set; }
    }
}
