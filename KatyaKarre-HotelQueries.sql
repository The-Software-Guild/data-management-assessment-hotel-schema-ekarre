USE KatyaKarreHotelDB;
/* 1. Return a list of reservations that end in July 2023.
	Include guest's name, room number(s), and reservation dates */
SELECT
-- to combine first and last name into one column name
	CONCAT(guestData.firstName, ' ', guestData.lastName) AS guestName,
-- to give the column a "new" name, just put what you want afterwards (roomNumber)
    reservationData.roomID AS roomNumber,
    reservationData.startDate,
    reservationData.endDate
FROM reservationData
RIGHT OUTER JOIN guestData ON reservationData.guestID = guestData.guestID
-- to specify just the month and year to get all reservations for that month, separate them by YEAR and MONTH instead of "DATE = "
WHERE YEAR(reservationData.endDate) = "2023" AND MONTH(reservationData.endDate) = "07";
/* Query 1 Results
guestName, roomNumber, startDate, endDate
'Katya Karre', '205', '2023-06-28', '2023-07-02'
'Bettyann Seery', '303', '2023-07-28', '2023-07-29'
'Walter Holaway', '204', '2023-07-13', '2023-07-14'
'Wilfred Vise', '401', '2023-07-18', '2023-07-21'
*/

/* 2. Return a list of all reservations for rooms with a jacuzzi.
	Include guest's name, room number(s), and reservation dates */
SELECT
	CONCAT(guestData.firstName, ' ', guestData.lastName) AS guestName,
    reservationData.roomID AS roomName,
    reservationData.startDate,
    reservationData.endDate,
    roomData.amenities
FROM reservationData
RIGHT OUTER JOIN guestData ON reservationData.guestID = guestData.guestID
RIGHT OUTER JOIN roomData ON reservationData.roomID = roomData.roomID
-- to display the results that include the word "jacuzzi"
WHERE roomData.amenities LIKE '%jacuzzi%'
-- order by to make it look nicer because some people may have more than one reservation
ORDER BY guestData.lastName;
/* Query 2 Results
guestName, roomName, startDate, endDate, amenities
'Duane Cullison', '305', '2023-02-22', '2023-02-24', 'Microwave, Refrigerator, Jacuzzi'
'Walter Holaway', '301', '2023-04-09', '2023-04-13', 'Microwave, Jacuzzi'
'Katya Karre', '205', '2023-06-28', '2023-07-02', 'Microwave, Refrigerator, Jacuzzi'
'Katya Karre', '307', '2023-03-17', '2023-03-20', 'Microwave, Refrigerator, Jacuzzi'
'Bettyann Seery', '203', '2023-02-05', '2023-02-10', 'Microwave, Jacuzzi'
'Bettyann Seery', '303', '2023-07-28', '2023-07-29', 'Microwave, Jacuzzi'
'Bettyann Seery', '305', '2023-08-30', '2023-09-01', 'Microwave, Refrigerator, Jacuzzi'
'Mack Simmer', '301', '2023-11-22', '2023-11-25', 'Microwave, Jacuzzi'
'Wilfred Vise', '207', '2023-04-23', '2023-04-24', 'Microwave, Refrigerator, Jacuzzi'
*/

/* 3. Return all the rooms reserved for a specific guest.
	Include guest's name, room number(s), starting date, and how many people were included */
SELECT
	CONCAT(guestData.firstName, ' ', guestData.lastName) AS guestName,
    reservationData.roomID AS roomNumber,
    reservationData.startDate,
-- to display number of guests, add the number of adults and number of children together
    (numOfAdults + numOfChildren) AS numberOfGuests
FROM reservationData
RIGHT OUTER JOIN guestData ON reservationData.guestID = guestData.guestID
WHERE guestData.lastName = "Karre";
/* Query 3 Results
guestName, roomNumber, startDate, numberOfGuests
'Katya Karre', '307', '2023-03-17', '2'
'Katya Karre', '205', '2023-06-28', '2'
*/

/* 4. Return a list of rooms, reservationID, and per-room cost for each reservation.
	Include ALL rooms, even if there is no reservation associated with the room */
SELECT
	roomData.roomID AS roomNumber,
    IFNULL(reservationData.reservationID,"No reservation for this room") AS reservationID,
    IFNULL(reservationData.totalCost, "No reservation for this room") AS totalCost
FROM reservationData
RIGHT OUTER JOIN roomData ON reservationData.roomID = roomData.roomID;
-- don't need a WHERE clause because we want all rooms displayed
/* Query 4 Results
roomNumber, reservationID, totalCost
'201', '4', '199.99'
'202', '7', '349.98'
'203', '2', '999.95'
'203', '21', '399.98'
'204', '16', '184.99'
'205', '15', '699.96'
'206', '12', '599.96'
'206', '23', '449.97'
'207', '10', '174.99'
'208', '13', '599.96'
'208', '20', '149.99'
'301', '9', '799.96'
'301', '24', '599.97'
'302', '6', '924.95'
'302', '25', '699.96'
'303', '18', '199.99'
'304', '14', '184.99'
'305', '3', '349.98'
'305', '19', '349.98'
'306', 'No reservation for this room', 'No reservation for this room'
'307', '5', '524.97'
'308', '1', '299.98'
'401', '11', '1199.97'
'401', '17', '1259.97'
'401', '22', '1199.97'
'402', 'No reservation for this room', 'No reservation for this room'
*/

/* 5. Return all rooms with a capacity of three or more and that are reserved on any date in April 2023 
	Any date includes start or end date. */
SELECT
	reservationData.roomID AS roomNumber,
    (numOfAdults + numOfChildren) AS roomCapacity,
    reservationData.startDate,
    reservationData.endDate
FROM reservationData
-- make a long WHERE clause to include all qualifications for this search
WHERE (numOfAdults + numOfChildren) >= "3" AND YEAR(startDate) = "2023" AND MONTH(startDate) = "04";
/* Query 5 Results 
there were no rooms that matched these qualifications */

/* 6. Return a list of all guest names and the number of reservations per guest.
	Sort starting with the guest with the most reservations and then by guest's last name */
SELECT
	CONCAT(guestData.firstName, ' ', guestData.lastName) AS guestName,
-- count the number of reservations based on guestID, how many times does a certain guestID repeat in reservation table
    COUNT(reservationData.guestID) AS numberOfReservations
FROM reservationData
RIGHT OUTER JOIN guestData ON reservationData.guestID = guestData.guestID
GROUP BY guestData.guestID, firstName, lastName
-- order from most to least reservations, then by last name in descending order
ORDER BY COUNT(reservationData.reservationID) DESC, lastName DESC;
/* Query 6 Results
guestName, numberOfReservations
'Mack Simmer', '4'
'Bettyann Seery', '3'
'Karie Yang', '2'
'Wilfred Vise', '2'
'Joleen Tison', '2'
'Maritza Tilton', '2'
'Aurore Lipton', '2'
'Katya Karre', '2'
'Walter Holaway', '2'
'Duane Cullison', '2'
'Zachery Luechtefeld', '1'
*/

/* 7. Display name, address, and phone number of a guest based on their phone number. */
SELECT
	CONCAT(firstName, ' ', lastName) AS guestName,
    address,
    phoneNum AS phoneNumber
FROM guestData
WHERE phoneNum = "(123) 456-7890";
/* Query 7 Results
guestName, address, phoneNumber
'Katya Karre', '123 Street Avenue', '(123) 456-7890'
*/