using TravelAgency.Models;

namespace TravelAgency.Data
{
    public class AppDbInitializer
    {
        public static void Seed(IApplicationBuilder applicationBuilder)
        {
            using (var serviceScope = applicationBuilder.ApplicationServices.CreateScope())
            {
                var context = serviceScope.ServiceProvider.GetService<AppDbContext>();

                context.Database.EnsureCreated();

                //Guide
                if (!context.Guides.Any())
                {
                    context.Guides.AddRange(new List<Guide>()
                    {
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                            FullName = "Adri Meyer",
                            Description = "Test description - this is clear description of this Guide."
                        },
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                            FullName = "Josh Ung",
                            Description = "Test description - this is clear description of this Guide."
                        },
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                            FullName = "Jerry Fulzik",
                            Description = "Test description - this is clear description of this Guide."
                        },
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                            FullName = "Lucy Cerry",
                            Description = "Test description - this is clear description of this Guide."
                        },
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                            FullName = "Alfo Buddy",
                            Description = "Test description - this is clear description of this Guide."
                        },
                        new Guide()
                        {
                            ProfilePictureURL = "https://images.unsplash.com/photo-1619420674819-da50b9f76950?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTE3fHxwcm9maWxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                            FullName = "Adele Bolsik",
                            Description = "Test description - this is clear description of this Guide."
                        }
                    });
                    context.SaveChanges();
                }
                //Destination
                if (!context.Destinations.Any())
                {
                    context.Destinations.AddRange(new List<Destination>()
                    {
                        new Destination()
                        {
                            Name = "Austria",
                            Description = "This is test description of Austria.",
                            Continent = Enums.Continent.Europe
                        },
                        new Destination()
                        {
                            Name = "Armenia",
                            Description = "This is test description of Armenia.",
                            Continent = Enums.Continent.Asia
                        },
                        new Destination()
                        {
                            Name = "Madagaskar",
                            Description = "This is test description of Madagaskar.",
                            Continent = Enums.Continent.Africa
                        },
                        new Destination()
                        {
                            Name = "Canada",
                            Description = "This is test description of Canada.",
                            Continent = Enums.Continent.NorthAmerica
                        },
                        new Destination()
                        {
                            Name = "New Zealand",
                            Description = "This is test description of New Zeland.",
                            Continent = Enums.Continent.Australia
                        }
                    });
                    context.SaveChanges();
                }

                //Trip
                if (!context.Trips.Any())
                {
                    context.Trips.AddRange(new List<Trip>()
                    {
                        new Trip()
                        {
                            Name = "Weekend Salza",
                            PictureURL = "https://images.unsplash.com/photo-1620829526529-cd0636b749cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGtheWFraW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                            LengthOfTrip = 0,
                            Price = 3900,
                            TripCategory = Enums.TripCategory.Water,
                            Hardness = 5,
                            TypeOfFood = Enums.TypeOfFood.NoFood,
                            TypeOfStay = Enums.TypeOfStay.Tent,
                            TypeOfTravel = Enums.TypeOfTravel.TravelIncluded,
                            StartDate = DateTime.Now.AddDays(-4),
                            EndDate = DateTime.Now.AddDays(-1),
                            Description = "Test description - this is clear description of this Trip.",
                            Description2 = "Test description2 - this is clear description2 of this Trip.",
                            DestinationId = 1
                        },
                        new Trip()
                        {
                            Name = "Armenia Tour",
                            PictureURL = "https://images.unsplash.com/photo-1647193090095-c0283d9e1385?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YXJtZW5pYSUyMHRvdXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                            LengthOfTrip = 0,
                            Price = 15000,
                            TripCategory = Enums.TripCategory.Tour,
                            Hardness = 3,
                            TypeOfFood = Enums.TypeOfFood.PartialFood,
                            TypeOfStay = Enums.TypeOfStay.Accomodation,
                            TypeOfTravel = Enums.TypeOfTravel.TravelIncluded,
                            StartDate = DateTime.Now,
                            EndDate = DateTime.Now.AddDays(3),
                            Description = "Test description - this is clear description of this Trip.",
                            Description2 = "Test description2 - this is clear description2 of this Trip.",
                            DestinationId = 2
                        },
                        new Trip()
                        {
                            Name = "Madagaskar Expedition",
                            PictureURL = "https://images.unsplash.com/photo-1518709594023-6eab9bab7b23?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHplYnJhfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                            LengthOfTrip = 0,
                            Price = 45000,
                            TripCategory = Enums.TripCategory.Others,
                            Hardness = 4,
                            TypeOfFood = Enums.TypeOfFood.FullFood,
                            TypeOfStay = Enums.TypeOfStay.Accomodation,
                            TypeOfTravel = Enums.TypeOfTravel.NoTravel,
                            StartDate = DateTime.Now.AddDays(30),
                            EndDate = DateTime.Now.AddDays(50),
                            Description = "Test description - this is clear description of this Trip.",
                            Description2 = "Test description2 - this is clear description2 of this Trip.",
                            DestinationId = 3
                        },
                        new Trip()
                        {
                            Name = "Yukon and Alaska",
                            PictureURL = "https://images.unsplash.com/photo-1574788901656-6a9ee34a3fa7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YWxhc2thfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                            LengthOfTrip = 0,
                            Price = 70000,
                            TripCategory = Enums.TripCategory.Tour,
                            Hardness = 5,
                            TypeOfFood = Enums.TypeOfFood.FullFood,
                            TypeOfStay = Enums.TypeOfStay.Accomodation,
                            TypeOfTravel = Enums.TypeOfTravel.TravelIncluded,
                            StartDate = DateTime.Now.AddDays(30),
                            EndDate = DateTime.Now.AddDays(45),
                            Description = "Test description - this is clear description of this Trip.",
                            Description2 = "Test description2 - this is clear description2 of this Trip.",
                            DestinationId = 4
                        },
                        new Trip()
                        {
                            Name = "New Zealand Expedition",
                            PictureURL = "https://images.unsplash.com/photo-1597655601841-214a4cfe8b2c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bmV3JTIwemVhbGFuZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                            LengthOfTrip = 0,
                            Price = 65400,
                            TripCategory = Enums.TripCategory.Tour,
                            Hardness = 5,
                            TypeOfFood = Enums.TypeOfFood.NoFood,
                            TypeOfStay = Enums.TypeOfStay.Outside,
                            TypeOfTravel = Enums.TypeOfTravel.TravelIncluded,
                            StartDate = DateTime.Now.AddDays(15),
                            EndDate = DateTime.Now.AddDays(32),
                            Description = "Test description - this is clear description of this Trip.",
                            Description2 = "Test description2 - this is clear description2 of this Trip.",
                            DestinationId = 5
                        }
                    });
                    context.SaveChanges();
                }

                //Trips & Guides
                if (!context.Trips_Guides.Any())
                {
                    context.Trips_Guides.AddRange(new List<Trip_Guide>()
                    {
                        new Trip_Guide()
                        {
                            TripId = 1,
                            GuideId = 1
                        },
                        new Trip_Guide()
                        {
                            TripId = 1,
                            GuideId = 4
                        },
                        new Trip_Guide()
                        {
                            TripId = 2,
                            GuideId = 3
                        },
                        new Trip_Guide()
                        {
                            TripId = 3,
                            GuideId = 4
                        },
                        new Trip_Guide()
                        {
                            TripId = 3,
                            GuideId = 5
                        },
                        new Trip_Guide()
                        {
                            TripId = 4,
                            GuideId = 6
                        },
                        new Trip_Guide()
                        {
                            TripId = 4,
                            GuideId = 1
                        },
                        new Trip_Guide()
                        {
                            TripId = 5,
                            GuideId = 2
                        }
                    });
                    context.SaveChanges();
                }
            }
        }
    }
}
