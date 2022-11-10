-- to load data into tables use the Import Wizard
-- right click on the table you want and choose "Table Data Import Wizard" and follow the steps

-- delete Jeremiah Pendergrass and his reservations from the database
-- first delete reservationID from resRoom bridge table
DELETE FROM resRoom WHERE reservationID = 8;
-- second delete guestID from reservationData table
DELETE FROM reservationData WHERE guestID = 8;
-- last delete guestID from guestData table
DELETE FROM guestData WHERE guestID = 8;