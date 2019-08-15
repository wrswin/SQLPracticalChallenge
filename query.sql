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

INSERT INTO Tour (TourName, Description) VALUES
    ('North', 'A tour of a northern part of somewhere'),
    ('South', 'Cancelled due to badgers')
;

INSERT INTO Client (ClientId, Surname, GivenName, Gender) VALUES
    (1, 'Edgar', 'Alyx', NULL),
    (102506005, 'Wayde', 'Reitsma', 'M')
;

INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES
    ('North', 'Mar', 23, 2077, 2000),
    ('North', 'Aug', 04, 2042, 1000.01)
;

INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES
    (1, 'North', 'Aug', 04, 2042, 1001, '2025-10-01'),
    (102506005, 'North', 'Mar', 23, 2077, 2000, '2030-04-12')
;

SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
    FROM Booking as B
    INNER JOIN Event E
    ON (E.TourName = B.TourName AND E.EventMonth = B.EventMonth AND E.EventDay = B.EventDay AND E.EventYear = B.EventYear)
    INNER JOIN Tour T
    ON (T.TourName = B.TourName)
    INNER JOIN Client C
    ON (C.ClientId = B.ClientId)
;

SELECT B.EventMonth, B.TourName, COUNT(B.ClientId)
    FROM Booking as B
    GROUP BY B.EventMonth, B.TourName
    ORDER BY B.EventMonth ASC, B.TourName ASC
;

SELECT *
    FROM Booking B
    WHERE B.Payment > (
        SELECT AVG(B.Payment)
            FROM Booking B
    )
;