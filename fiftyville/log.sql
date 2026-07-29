-- Keep a log of any SQL queries you execute as you solve the mystery.
-- to view all my table 
.tables

SELECT * FROM crime_scene_reports;

SELECT description FROM crime_scene_reports WHERE year = 2024 AND month = 7 AND day = 28 AND street = 'Humphrey Street';

SELECT * FROM bakery_security_logs;

SELECT license_plate, hour, minute, activity 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25;

SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25;
  

  -- view the structure of people table

  SELECT * FROM people;

  --link the people with the suspected lisence plate number
SELECT * FROM people WHERE license_plate IN (SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25);

  --query to get on lt phone number from people

SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25);

-- join the phone calls to the associated people
SELECT * FROM  phone_calls WHERE caller OR receiver IN  (SELECT phone_number FROM people WHERE license_plate IN (SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25));


  --select the calls on that day 
  SELECT 
    pc.id,
    pc.caller,
    p_caller.name AS caller_name,
    pc.receiver,
    p_receiver.name AS receiver_name,
    pc.year, pc.month, pc.day,
    pc.duration
FROM phone_calls pc
-- First join finds the name of the caller
JOIN people p_caller ON pc.caller = p_caller.phone_number
-- Second join finds the name of the receiver
JOIN people p_receiver ON pc.receiver = p_receiver.phone_number
-- Third join filters by the bakery suspects
JOIN bakery_security_logs bsl ON p_caller.license_plate = bsl.license_plate
WHERE pc.year = 2024 
  AND pc.month = 7 
  AND pc.day = 28
  AND bsl.year = 2024 
  AND bsl.month = 7 
  AND bsl.day = 28 
  AND bsl.hour = 10 
  AND bsl.minute BETWEEN 15 AND 25;


--- get the suspect from the list 
SELECT 
    pc.id,
    pc.caller,
    p_caller.name AS caller_name,
    pc.receiver,
    p_receiver.name AS receiver_name,
    pc.duration,
    CASE 
        WHEN bsl.license_plate = p_caller.license_plate THEN p_caller.name
        WHEN bsl.license_plate = p_receiver.license_plate THEN p_receiver.name
    END AS bakery_suspect
FROM phone_calls pc
JOIN people p_caller ON pc.caller = p_caller.phone_number
JOIN people p_receiver ON pc.receiver = p_receiver.phone_number
JOIN bakery_security_logs bsl ON bsl.license_plate IN (p_caller.license_plate, p_receiver.license_plate)
WHERE pc.year = 2024 
  AND pc.month = 7 
  AND pc.day = 28
  AND bsl.year = 2024 
  AND bsl.month = 7 
  AND bsl.day = 28 
  AND bsl.hour = 10 
  AND bsl.minute BETWEEN 15 AND 25;

  --LETS GET FLIGHT LEAVING FIFTY VILLE

  SELECT * FROM flights WHERE origin_airport_id = 8 AND year = 2024 AND month = 7 AND day = 28 AND HOUR >= 10;


  --GET ONLY THERE PASSPORT NUMBER
SELECT passport_number FROM people WHERE license_plate IN (SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute BETWEEN 15 AND 25);


SELECT flight_id FROM  passengers WHERE passport_number IN  (SELECT passport_number FROM people WHERE license_plate IN (SELECT license_plate 
FROM bakery_security_logs 
WHERE year = 2024 
  AND month = 7 
  AND day = 28 
  AND hour = 10 
  AND minute > 15));