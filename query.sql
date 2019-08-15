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

DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Tour;

CREATE TABLE Tour (
    TourName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),

    PRIMARY KEY (TourName)
);

CREATE TABLE Client (
    ClientId INT NOT NULL,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),

    PRIMARY KEY (ClientId)
);

CREATE TABLE Event (
    TourName NVARCHAR(200) NOT NULL,
    EventMonth NVARCHAR(3) NOT NULL,
    EventDay INT NOT NULL,
    EventYear INT NOT NULL,
    EventFee MONEY NOT NULL,

    PRIMARY KEY (TourName, EventMonth, EventDay, EventYear),

    FOREIGN KEY (TourName) REFERENCES Tour,

    CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CHECK (EventDay >= 1 AND EventDay <= 31),
    CHECK (LEN(CAST(EventYear AS NVARCHAR(10))) = 4),
    CHECK (EventFee > 0)
);

CREATE TABLE Booking (
    ClientId INT NOT NULL,
    TourName NVARCHAR(200) NOT NULL,
    EventMonth NVARCHAR(3) NOT NULL,
    EventDay INT NOT NULL,
    EventYear INT NOT NULL,
    Payment MONEY,
    DateBooked DATE NOT NULL,

    PRIMARY KEY (ClientId, TourName, EventMonth, EventDay, EventYear),

    FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES Event,

    CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CHECK (EventDay >= 1 AND EventDay <= 31),
    CHECK (LEN(CAST(EventYear AS NVARCHAR(10))) = 4),
    CHECK (Payment > 0)
);