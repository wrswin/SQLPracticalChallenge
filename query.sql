-- Wayde Reitsma - 102506005

/*

Tour (TourName, Description)
Primary Key (TourName)

Client (ClientID, Surname, GivenName, Gender)
Primary Key (ClientID)

Event (TourName, EventYear, EventMonth, EventDay, Fee)
Primary Key (TourName, EventYear, EventMonth, EventDay)
Foreign Key (TourName) Reference Tour

Booking (TourName, EventYear, EventMonth, EventDay, ClientID, DateBooked, Payment)
Primary Key (TourName, EventYear, EventMonth, EventDay, ClientID)
Foreign Key (Tourname, EventYear, EventMonth, EventDay) References Event
Foreign Key (ClientID) References Client

*/