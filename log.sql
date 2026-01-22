-- Keep a log of any SQL queries you execute as you solve the mystery.

/* Find CS50 duck Crime Scene report */

SELECT day, month, year, description FROM crime_scene_reports
WHERE day = 28
AND month = 07
AND year = 2023;

/* CS50 duck crime scene report
28   7      2023
Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
Interviews were conducted today with three witnesses
who were present at the time – each of their interview transcripts
mentions the bakery.*/


/* Find three witness transcripts - same date */

SELECT day, month, year, name, transcript FROM interviews
WHERE day = 28
AND month = 07
AND year = 2023;

/* Transcripts
Ruth    | Sometime within ten minutes of the theft,
I saw the thief get into a car in the bakery parking lot and drive away.
If you have security footage from the bakery parking lot, you might want to
look for cars that left the parking lot in that time frame.
///////
Eugene  | I don't know the thief's name, but it was someone I recognized.
Earlier this morning, before I arrived at Emma's bakery, I was walking
by the ATM on Leggett Street and saw the thief there withdrawing some money.
///////
Raymond | As the thief was leaving the bakery, they called someone who talked
to them for less than a minute. In the call, I heard the thief say that they
were planning to take the earliest flight out of Fiftyville tomorrow.
The thief then asked the person on the other end of the phone to purchase the
flight ticket.
//////
*/

/* Find cars that left bakery from 10:00am - 10:25am

Find who withdrew money within that time period above

Find who did they call, thats who booked the flight, confirm booking

*/

SELECT day, month, year, hour, minute, license_plate, activity FROM bakery_security_logs
WHERE day = 28
AND month = 07
AND year = 2023
AND hour = 10
AND minute BETWEEN 00 AND 25;

SELECT bakery_security_logs.activity, bakery_security_logs.license_plate, people.name FROM people
JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
WHERE bakery_security_logs.year = 2023
AND bakery_security_logs.month = 7
AND bakery_security_logs.day = 28
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute >= 15
AND bakery_security_logs.minute <=25;


/* Cars that left Bakery from 10 am = 10:25 am
| 28  | 7     | 2023 | 10   | 16     | 5P2BI95       | exit     |
| 28  | 7     | 2023 | 10   | 18     | 94KL13X       | exit     |
| 28  | 7     | 2023 | 10   | 18     | 6P58WS2       | exit     |
| 28  | 7     | 2023 | 10   | 19     | 4328GD8       | exit     |
| 28  | 7     | 2023 | 10   | 20     | G412CB7       | exit     |
| 28  | 7     | 2023 | 10   | 21     | L93JTIZ       | exit     |
| 28  | 7     | 2023 | 10   | 23     | 322W7JE       | exit     |
| 28  | 7     | 2023 | 10   | 23     | 0NTHK55       | exit     |
+----------+---------------+---------+
| exit     | 5P2BI95       | Vanessa |
| exit     | 94KL13X       | Bruce   |
| exit     | 6P58WS2       | Barry   |
| exit     | 4328GD8       | Luca    |
| exit     | G412CB7       | Sofia   |
| exit     | L93JTIZ       | Iman    |
| exit     | 322W7JE       | Diana   |
| exit     | 0NTHK55       | Kelsey  |
+----------+---------------+---------+
*/

SELECT id, day, month, year, atm_location, account_number, transaction_type  FROM atm_transactions
WHERE day = 28
AND month = 07
AND year = 2023
AND atm_location = 'Humphrey Lane'
AND transaction_type = 'withdraw';

SELECT people.name, atm_transactions.transaction_type FROM people
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE atm_transactions.year = 2023
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_location = "Leggett Street"
AND atm_transactions.transaction_type = "withdraw";

/* Account numbers withdrawn in that time
| 245 | 28  | 7     | 2023 | Humphrey Lane | 90209473       | withdraw         |
| 247 | 28  | 7     | 2023 | Humphrey Lane | 41935128       | withdraw         |
| 255 | 28  | 7     | 2023 | Humphrey Lane | 66344537       | withdraw         |
| 258 | 28  | 7     | 2023 | Humphrey Lane | 92647903       | withdraw         |
| 262 | 28  | 7     | 2023 | Humphrey Lane | 40665580       | withdraw         |
| 265 | 28  | 7     | 2023 | Humphrey Lane | 96336648       | withdraw         |
| 273 | 28  | 7     | 2023 | Humphrey Lane | 69638157       | withdraw         |
| 276 | 28  | 7     | 2023 | Humphrey Lane | 13156006       | withdraw         |
| 277 | 28  | 7     | 2023 | Humphrey Lane | 89843009       | withdraw         |
| 280 | 28  | 7     | 2023 | Humphrey Lane | 92647903       | withdraw         |
| 281 | 28  | 7     | 2023 | Humphrey Lane | 57022441       | withdraw         |
| 290 | 28  | 7     | 2023 | Humphrey Lane | 79165736       | withdraw         |
| 291 | 28  | 7     | 2023 | Humphrey Lane | 76849114       | withdraw         |
| 300 | 28  | 7     | 2023 | Humphrey Lane | 66344537       | withdraw         |
| 302 | 28  | 7     | 2023 | Humphrey Lane | 50380485       | withdraw         |
| 309 | 28  | 7     | 2023 | Humphrey Lane | 46222318       | withdraw         |
| 310 | 28  | 7     | 2023 | Humphrey Lane | 58673910       | withdraw         |
| 312 | 28  | 7     | 2023 | Humphrey Lane | 93903397       | withdraw         |
| 315 | 28  | 7     | 2023 | Humphrey Lane | 79127781       | withdraw         |
| 316 | 28  | 7     | 2023 | Humphrey Lane | 95773068       | withdraw         |
| 322 | 28  | 7     | 2023 | Humphrey Lane | 26797365       | withdraw         |
| 329 | 28  | 7     | 2023 | Humphrey Lane | 34939061       | withdraw         |
| 333 | 28  | 7     | 2023 | Humphrey Lane | 65190958       | withdraw         |
| 334 | 28  | 7     | 2023 | Humphrey Lane | 99031604       | withdraw         |
| 337 | 28  | 7     | 2023 | Humphrey Lane | 58552019       | withdraw         |
| 342 | 28  | 7     | 2023 | Humphrey Lane | 55322348       | withdraw         |
+-----+-----+-------+------+---------------+----------------+------------------+
REMOVED NAMES THAT DONT MATCH LICENSE PLATES ~ remaining below
+---------+------------------+
| Bruce   | withdraw         |
| Diana   | withdraw         |
| Iman    | withdraw         |
| Luca    | withdraw         |
+---------+------------------+
*/

SELECT caller, receiver, FROM phone_calls
WHERE year = 2023
AND month = 7
AND day = 28
AND duration < 60;
/*
+----------------+----------------+
|     caller     |    receiver    |
+----------------+----------------+
| (130) 555-0289 | (996) 555-8899 |
| (499) 555-9472 | (892) 555-8872 |
| (367) 555-5533 | (375) 555-8161 |
| (499) 555-9472 | (717) 555-1342 |
| (286) 555-6063 | (676) 555-6554 |
| (770) 555-1861 | (725) 555-3243 |
| (031) 555-6622 | (910) 555-3251 |
| (826) 555-1652 | (066) 555-9701 |
| (338) 555-6650 | (704) 555-2131 |
+----------------+----------------+
*/
/*ADD CALLER AND RECEIVER NAMES TO IDENTIFY CALLERS*/
ALTER TABLE phone_calls
ADD caller_name text;

ALTER TABLE phone_calls
ADD receiver_name text;
/* UPDATE PHONE CALLER NAMES WITH NAMES FROM PEOPLE*/
UPDATE phone_calls
SET caller_name = people.name
FROM people
WHERE phone_calls.caller = people.phone_number;
/* UPDATE PHONE RECEIVER NME WITH NMES FROM PEOPLE*/
UPDATE phone_calls
SET receiver_name = people.name
FROM people
WHERE phone_calls.receiver = people.phone_number;

/* REQUERY WITH UPDTED TABLES*/
SELECT caller, caller_name, receiver, receiver_name FROM phone_calls
WHERE year = 2023
AND month = 7
AND day = 28
AND duration < 60;
/* QUERY WITH UPDATED TABLES W/NAMES*//*3
+----------------+-------------+----------------+---------------+
|     caller     | caller_name |    receiver    | receiver_name |
+----------------+-------------+----------------+---------------+
| (130) 555-0289 | Sofia       | (996) 555-8899 | Jack          |
| (499) 555-9472 | Kelsey      | (892) 555-8872 | Larry         |
| (367) 555-5533 | Bruce       | (375) 555-8161 | Robin         |
| (499) 555-9472 | Kelsey      | (717) 555-1342 | Melissa       |
| (286) 555-6063 | Taylor      | (676) 555-6554 | James         |
| (770) 555-1861 | Diana       | (725) 555-3243 | Philip        |
| (031) 555-6622 | Carina      | (910) 555-3251 | Jacqueline    |
| (826) 555-1652 | Kenny       | (066) 555-9701 | Doris         |
| (338) 555-6650 | Benista     | (704) 555-2131 | Anna          |
+----------------+-------------+----------------+---------------+
NAME FOR REFERENCE ~ Bruce, Diana ~ REMAINING ONES WHO CALLED
*/

/* IDENTIFY EARLIEST FLIGHT BOOKED ON 29th ~ booking first flight out after 28th*/
SELECT id , hour, minute, origin_airport_id, destination_airport_id FROM flights
WHERE year = 2023
AND month = 7
AND day = 29
ORDER BY hour ASC
LIMIT 1;
/*
+----+------+--------+-------------------+------------------------+
| id | hour | minute | origin_airport_id | destination_airport_id |
+----+------+--------+-------------------+------------------------+
| 36 | 8    | 20     | 8                 | 4                      |
+----+------+--------+-------------------+------------------------+
*/
/* FIND NAMES OF AIRPORTS ~ SWAP ID FOR FULL NAMES IN AIRPORTS */
SELECT id, city
FROM airports
WHERE id = 4
OR id = 8
ORDER BY id DESC;
/*RESULTS*/
/*
+----+---------------+
| id |     city      |
+----+---------------+
| 8  | Fiftyville    |
| 4  | New York City |
+----+---------------+
*/
/*ORIGIN AIRPORT ~ FIFTYVILLE */

/*DESTINATION AIRPORT ~ NEW YORK CITY*/

/* IDENTIFY ALL PASSENGER HEADED TO NYC */
SELECT flights.destination_airport_id, name, phone_number, license_plate FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE flights.id = 36
ORDER BY flights.hour ASC;
/*
+------------------------+--------+----------------+---------------+
| destination_airport_id |  name  |  phone_number  | license_plate |
+------------------------+--------+----------------+---------------+
| 4                      | Doris  | (066) 555-9701 | M51FA04       |
| 4                      | Sofia  | (130) 555-0289 | G412CB7       |
| 4                      | Bruce  | (367) 555-5533 | 94KL13X       |
| 4                      | Edward | (328) 555-1152 | 130LD9Z       |
| 4                      | Kelsey | (499) 555-9472 | 0NTHK55       |
| 4                      | Taylor | (286) 555-6063 | 1106N58       |
| 4                      | Kenny  | (826) 555-1652 | 30G67EN       |
| 4                      | Luca   | (389) 555-5198 | 4328GD8       |
+------------------------+--------+----------------+---------------+
*/
/* LAST NAME TO MATCH ALL QUERIES ~ BRUCE */
/* ACCOMPLICE ROBIN */
/* DESTINATION NYC */ 
