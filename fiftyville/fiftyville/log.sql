-- Keep a log of any SQL queries you execute as you solve the mystery.
-- I FIRST WENT AND TOOK A LOOK AT THE CRIME SCENE 

SELECT * FROM crime_scene_reports;

--NARROWING DOWN THE SEARCH TO JUST DATE AND DAY

SELECT * FROM crime_scene_reports
WHERE year = 2024 
AND month = 7
AND street = 'Humphrey Street'
AND day = 28;

--I WANNA VIEW THE TESTIMONIES TO THE PEOPLE THAT WERE INTERVIEWED

SELECT * FROM interviews
WHERE year = 2024 
AND month = 7
AND day = 28;


--FROM RUTH TESTIMONY, I WILL WANT TO ACCESS THE BACKERY SECURITY LOGS

SELECT * FROM bakery_security_logs
WHERE year = 2024 
AND month = 7
AND day = 28
AND hour = 10
AND minute BETWEEN 15 AND 25;

--RESULT 
id   year  month  day  hour  minute  activity  license_plate
---  ----  -----  ---  ----  ------  --------  -------------
260  2024      7   28    10      16  exit      5P2BI95
261  2024      7   28    10      18  exit      94KL13X
262  2024      7   28    10      18  exit      6P58WS2
263  2024      7   28    10      19  exit      4328GD8
264  2024      7   28    10      20  exit      G412CB7
265  2024      7   28    10      21  exit      L93JTIZ
266  2024      7   28    10      23  exit      322W7JE
267  2024      7   28    10      23  exit      0NTHK55
-----------GOTTEN LISCENCE PLATE INFO

--FROM EUGENE TESTIMONY, i wanna take a look at the atm side
SELECT * FROM atm_transactions
WHERE year = 2024
AND month = 7
AND day = 28
AND atm_location = 'Leggett Street'
AND transaction_type = 'withdraw';

id   account_number  year  month  day   atm_location   transaction_type  amount
---  --------------  ----  -----  ---  --------------  ----------------  ------
246        28500762  2024      7   28  Leggett Street  withdraw              48
264        28296815  2024      7   28  Leggett Street  withdraw              20
266        76054385  2024      7   28  Leggett Street  withdraw              60
267        49610011  2024      7   28  Leggett Street  withdraw              50
269        16153065  2024      7   28  Leggett Street  withdraw              80
288        25506511  2024      7   28  Leggett Street  withdraw              20
313        81061156  2024      7   28  Leggett Street  withdraw              30
336        26013199  2024      7   28  Leggett Street  withdraw              35
 ------ GOTTEN ACCOUNT NUMBER DETAILS AND AMOUNT FROM THESE-------------


--FROM RAYMOND TESTIMONY, CALLS WERE MADE--
SELECT * FROM phone_calls
WHERE year = 2024
AND month = 7
AND day = 28
AND duration < 60;

id       caller         receiver     year  month  day  duration
---  --------------  --------------  ----  -----  ---  --------
221  (130) 555-0289  (996) 555-8899  2024      7   28        51
224  (499) 555-9472  (892) 555-8872  2024      7   28        36
233  (367) 555-5533  (375) 555-8161  2024      7   28        45
251  (499) 555-9472  (717) 555-1342  2024      7   28        50
254  (286) 555-6063  (676) 555-6554  2024      7   28        43
255  (770) 555-1861  (725) 555-3243  2024      7   28        49
261  (031) 555-6622  (910) 555-3251  2024      7   28        38
279  (826) 555-1652  (066) 555-9701  2024      7   28        55
281  (338) 555-6650  (704) 555-2131  2024      7   28        54

--NOW I WANT TO GET THE PEOPLE BY THEIR LISENCE PLATE NUM AND PHONE NUM--
SELECT * FROM people 
WHERE license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE year = 2024 
    AND month = 7
    AND day = 28
    AND hour = 10
    AND minute BETWEEN 15 AND 25
);
  id     name     phone_number   passport_number  license_plate
------  -------  --------------  ---------------  -------------
221103  Vanessa  (725) 555-4692       2963008352  5P2BI95
243696  Barry    (301) 555-4174       7526138472  6P58WS2
396669  Iman     (829) 555-5269       7049073643  L93JTIZ
398010  Sofia    (130) 555-0289       1695452385  G412CB7
467400  Luca     (389) 555-5198       8496433585  4328GD8
514354  Diana    (770) 555-1861       3592750733  322W7JE
560886  Kelsey   (499) 555-9472       8294398571  0NTHK55
686048  Bruce    (367) 555-5533       5773159633  94KL13X

--HERE I WAS ABLE TO GET THE passport_number of the suspects

--NOW QUERY TO GET PEOPLE BY THE PHONE NUMBER AS THE WERE THE CALLER--

SELECT * FROM people
WHERE phone_number IN (SELECT caller FROM phone_calls
WHERE year = 2024
AND month = 7
AND day = 28
AND duration < 60);

 id     name     phone_number   passport_number  license_plate
------  -------  --------------  ---------------  -------------
395717  Kenny    (826) 555-1652       9878712108  30G67EN
398010  Sofia    (130) 555-0289       1695452385  G412CB7
438727  Benista  (338) 555-6650       9586786673  8X428L0
449774  Taylor   (286) 555-6063       1988161715  1106N58
514354  Diana    (770) 555-1861       3592750733  322W7JE
560886  Kelsey   (499) 555-9472       8294398571  0NTHK55
686048  Bruce    (367) 555-5533       5773159633  94KL13X
907148  Carina   (031) 555-6622       9628244268  Q12B3Z3

--NOW I CAN NARROW MY SUSPECTS LIST, 
--BECAUSE I WAS ABLE TO GET THE NAMES OF EVERY ONE THAT LEFT THE BAKERY
--AND AMONGST THEM, GET THOSE THAT ACTUALLY MADE A CALL 
--WITHIN THAT 10 MINS PERIOD WHICH ARE MY MAIN SUSPECTS

SO FROM COMPARING AND CONTRASTING, I HAVE NARROWED MY SUSPECTS TO
SOFIA, DIANA, KELSEY, BRUCE

SELECT * FROM people
WHERE name IN ('Sofia', 'Diana', 'Kelsey', 'Bruce');

 id     name    phone_number   passport_number  license_plate
------  ------  --------------  ---------------  -------------
398010  Sofia   (130) 555-0289       1695452385  G412CB7
514354  Diana   (770) 555-1861       3592750733  322W7JE
560886  Kelsey  (499) 555-9472       8294398571  0NTHK55
686048  Bruce   (367) 555-5533       5773159633  94KL13X

--NOW RECALL EUGENE TESTIMONY GAVE US THE ACCOUNT NUMBER 
--OF EVERY ONE THAT DID A TRANSACTION AT THAT MOMENT 
--OF THE CRIME SCENE NOW WE HAVE 4 SUSPECTS AND WE ARE SURE THAT
--OUR GUY DID A TRANSACTION AT THAT TIME. SO I WILL GET THERE ACCOUNT
--NUMBER WITH THEIR IDS

SELECT * FROM bank_accounts
WHERE person_id IN (SELECT id FROM people
WHERE name IN ('Sofia', 'Diana', 'Kelsey', 'Bruce'));

account_number  person_id  creation_year
--------------  ---------  -------------
      49610011     686048           2010
      26013199     514354           2012

--SO NOW OUT OF OUR 4 SUSPECTS NA ONLY 2 GET ACCOUNT NUMBER 😂😂(BRUCE, DIANA)
--THIS BRUCE GUY EHH

--SO NOW MY NEXT ACTION IS TO CHECK AMONGST THIS TWO,
--WHICH OF THEM ACTUALLY DID A WITHDRAWAL AT THAT EXACT DAY AND 
--AT THAT EXACT ATM LOCATION.

SELECT * FROM atm_transactions
WHERE account_number IN (SELECT account_number FROM bank_accounts
WHERE person_id IN (SELECT id FROM people
WHERE name IN ('Sofia', 'Diana', 'Kelsey', 'Bruce')));

id   account_number  year  month  day   atm_location   transaction_type  amount
---  --------------  ----  -----  ---  --------------  ----------------  ------
 17        26013199  2024      7   26  Leggett Street  deposit               55
 39        49610011  2024      7   26  Leggett Street  withdraw              10
267        49610011  2024      7   28  Leggett Street  withdraw              50
336        26013199  2024      7   28  Leggett Street  withdraw              35

--SO FROM MY RESULT, THE TWO REMAINING SUSPECTS DID A TRANSACTION 
--AT THAT PARTICULAR PLACE AND AT THAT TIME INTERVAL.

--SO I AM REACHING A DEAD END HERE.
--MY NEXT STEP IS KNOWING WHICH OF THEM ACTUALLY TOOK THE FLIGHT OUT OF THE CITY

SELECT * FROM airports;

--I GOT THE AIRPORT ID OF Fiftyville Regional Airport, WHICH IS 8
--THEN I MAP WITH FLIGHTS ALSO RECALL FROM RAYMOND TESTIMONY, HE SAID THAT
--"they were planning to take the earliest flight out of Fiftyville tomorrow"



SELECT * FROM flights
WHERE origin_airport_id = 8
AND year = 2024
AND month = 7
AND day = 29;

id  origin_airport_id  destination_airpo...  year  month  day  hour  minute
--  -----------------  --------------------  ----  -----  ---  ----  ------
18                  8                     6  2024      7   29    16       0
23                  8                    11  2024      7   29    12      15
36                  8                     4  2024      7   29     8      20
43                  8                     1  2024      7   29     9      30
53                  8                     9  2024      7   29    15      20

--NOW I WAS ABLE TO GET THE FLIGHT IDS 
--AND I WANT TO GET THE PASSENGERS THAT WITH THE FOLLOWING THE 
-- EARLIEST FLIGHT ID (FROM RAYMOND TESTIMONY), WHICH IS ON HOUR 8

SELECT * FROM passengers
WHERE flight_id IN (SELECT id FROM flights
WHERE origin_airport_id = 8
AND year = 2024
AND month = 7
AND day = 29
AND hour = 8);

flight_id  passport_number  seat
---------  ---------------  ----
       36       7214083635  2A
       36       1695452385  3B
       36       5773159633  4A
       36       1540955065  5C
       36       8294398571  6C
       36       1988161715  6D
       36       9878712108  7A
       36       8496433585  7B

--ABOVE I WAS ABLE TO GET ALL THE PASSENGERS THAT TOOK THE EARLIEST FLIGHT THE NEXT DAY
--NOW I WILL MAP OUT THE passport_number OF MY TWO MAIN SUSPECTS WITH IT

SELECT * FROM passengers
WHERE passport_number IN (3592750733, 5773159633);

flight_id  passport_number  seat
---------  ---------------  ----
       18       3592750733  4C
       24       3592750733  2C
       36       5773159633  4A
       54       3592750733  6C


--OUT OF MY TWO MAIN SUSPECTS, ONLY ONE OF THE WAS ON THE FIRST FLIGHT
--THAT LEFT THE NEXT DAY (WHICH IS flight_id "36")
--WHICH WAS NO OTHER THAN MR "BRUCE WAYNE"



--SO NOW, I WANT TO FIND WHO EVER BRUCE CALLED WITHIN THAT 10 MINS OF THE ROBBERY
--BECAUSE ACCORDING TO RAYMOND, HE WAS THE ONE THAT WAS TO HELP BRUCE

SELECT * FROM people
WHERE phone_number = '(375) 555-8161';

 id    name    phone_number   passport_number  license_plate
------  -----  --------------  ---------------  -------------
864400  Robin  (375) 555-8161                   4V16VO0

--SO MR ROBINHOOD WAS THE INDIVIDUAL BRUCE CALLED AND THE ACCOMPLICE.

--NOW TO FIND THE CITY BRUCE ESCAPED TO, I WILL USE THE 
--destination_airport id OF THE FLIGHT MR BRUCE TOOK,

SELECT * FROM flights
WHERE origin_airport_id = 8
AND year = 2024
AND month = 7
AND day = 29
AND hour = 8;

id  origin_airport_id  destination_airpo...  year  month  day  hour  minute
--  -----------------  --------------------  ----  -----  ---  ----  ------
36                  8                     4  2024      7   29     8      20

--SO NOW I WILL MAP THE DESTINATION ID TO THE AIRPORTS TABLE

SELECT * FROM airports
WHERE id = 4;

id  abbreviation      full_name          city
--  ------------  -----------------  -------------
 4  LGA           LaGuardia Airport  New York City

--SO THE THIEF BEING BRUCE ESCAPED TO New York City






--SOFIA 1695452385
--DIANA 3592750733
--KELSEY 8294398571
--BRUCE 5773159633
