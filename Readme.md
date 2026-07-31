# Fiftyville

The CS50 Duck has been stolen! The town of Fiftyville has called upon you to solve the mystery of the stolen duck. Authorities believe that the thief stole the duck and then, shortly afterwards, took a flight out of town with the help of an accomplice. Your goal is to identify:

- Who the thief is, "BRUCE"
- What city the thief escaped to, and   "New York City"
- Who the thief's accomplice is who helped them escape "ROBIN"

All you know is that the theft took place on July 28, 2024 and that it took place on Humphrey Street.

How will you go about solving this mystery? The Fiftyville authorities have taken some of the town's records from around the time of the theft and prepared a SQLite database for you, `fiftyville.db`, which contains tables of data from around the town. You can query that table using SQL `SELECT` queries to access the data of interest to you. Using just the information in the database, your task is to solve the mystery.

## Getting Started

1. Unzip the database:
   ```
   unzip fiftyville.zip
   ```
2. Open the database with SQLite:
   ```
   sqlite3 -column -header fiftyville.db
   ```
3. View available tables:
   ```
   .tables
   ```
Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
Interviews were conducted today with three witnesses who were present at the
time – each of their interview transcripts mentions the bakery.

ruth testimony
Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

eugene
I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on LeggettStreet and saw the thief there withdrawing some money.

raymond
As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ...