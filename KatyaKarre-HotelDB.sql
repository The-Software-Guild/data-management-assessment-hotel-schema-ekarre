-- delete database of this name if exists
DROP DATABASE IF EXISTS KatyaKarreHotelDB;
-- create new database
CREATE DATABASE KatyaKarreHotelDB;
-- declare which database you want to use
USE KatyaKarreHotelDB;
-- create tables, starting with those that don't have foreign keys
CREATE TABLE guestData (
	guestID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    stateAbbr CHAR(2) NOT NULL,
    zipcode CHAR(5) NOT NULL,
    phoneNum VARCHAR(15) NOT NULL,
    CONSTRAINT PK_guestData PRIMARY KEY (guestID)
);
CREATE TABLE roomData (
	roomID SMALLINT NOT NULL,
    roomType VARCHAR(10),
    amenities VARCHAR(50) NOT NULL,
    ADA VARCHAR(5) NOT NULL,
    occupancyMin TINYINT,
    occupancyMax TINYINT,
    basePrice DOUBLE NOT NULL,
    extraPerson VARCHAR(5),
    CONSTRAINT PK_roomData PRIMARY KEY (roomID)
);
CREATE TABLE reservationData (
	reservationID INT NOT NULL AUTO_INCREMENT,
    roomID SMALLINT NOT NULL,
    guestID INT NOT NULL,
    numOfAdults TINYINT,
    numOfChildren TINYINT,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    totalCost DOUBLE NOT NULL,
    CONSTRAINT PK_reservationData PRIMARY KEY (reservationID),
    CONSTRAINT FOREIGN KEY FK_roomData_reservationData (roomID)
		REFERENCES roomData (roomID),
	CONSTRAINT FOREIGN KEY FK_guestData_reservationData (guestID)
		REFERENCES guestData (guestID)
);
-- this is the bridge table so we declare the PK constraint (can be combined) and then both FK (separately)
CREATE TABLE resRoom (
	roomID SMALLINT NOT NULL,
    reservationID INT NOT NULL,
    CONSTRAINT PK_resRoom PRIMARY KEY (roomID, reservationID),
    CONSTRAINT FOREIGN KEY FK_resRoom_roomData (roomID)
		REFERENCES roomData (roomID),
	CONSTRAINT FOREIGN KEY FK_resRoom_reservationData (reservationID)
		REFERENCES reservationData (reservationID)
);