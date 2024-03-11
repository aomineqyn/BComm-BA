CREATE SCHEMA ASSIGNMENT2_V2;
USE ASSIGNMENT2_V2;

-- SECTION A 
-- TASK 1: 
-- CREATE THE TABLES

-- CREATE TABLE LOCATION
CREATE TABLE LOCATION
		(LocationCode VARCHAR(3),
        LocationName VARCHAR(50),
        PRIMARY KEY(LocationCode)
        );
        
-- CREATE TABLE ROUTE
CREATE TABLE ROUTE
		(RouteID VARCHAR(3),
        RouteDesc VARCHAR(50),
        SourceLocationCode VARCHAR(3),
        DesLocationCode VARCHAR(3),
        PRIMARY KEY(RouteID),
		FOREIGN KEY(SourceLocationCode) REFERENCES LOCATION(LocationCode),
		FOREIGN KEY(DesLocationCode) REFERENCES LOCATION(LocationCode)
        );

-- CREATE TABLE MULTIPLESTOPOVERS
CREATE TABLE MULTIPLESTOPOVERS
		(RouteID VARCHAR(3),
        LocationCode VARCHAR(3),
        PRIMARY KEY(RouteID, LocationCode),
		FOREIGN KEY(RouteID) REFERENCES ROUTE(RouteID),
		FOREIGN KEY(LocationCode) REFERENCES LOCATION(LocationCode)
        );

-- CREATE TABLE CRUISE
CREATE TABLE CRUISE
		(CruiseID VARCHAR(3),
        CruiseName VARCHAR(50),
        NumOfDays INTEGER,
        RouteID VARCHAR(3),
        PRIMARY KEY(CruiseID),
		FOREIGN KEY(RouteID) REFERENCES ROUTE(RouteID)
		);

-- CREATE TABLE SCHEDULE
CREATE TABLE SCHEDULE
		(ScheduleID VARCHAR(4),
        StartDate DATE,
        MaxCapacity INTEGER,
        CruiseID VARCHAR(3),
        PRIMARY KEY(ScheduleID),
		FOREIGN KEY(CruiseID) REFERENCES CRUISE(CruiseID)
		);
        
-- CREATE TABLE TOUR
CREATE TABLE TOUR
		(CruiseID VARCHAR(3),
        TourCode VARCHAR(3),
        TourName VARCHAR(50),
        TourCost DECIMAL(7,2),
        TourType VARCHAR(20),
        PRIMARY KEY(CruiseID, TourCode),
		FOREIGN KEY(CruiseID) REFERENCES CRUISE(CruiseID)
		);

-- CREATE TABLE STAFF
CREATE TABLE STAFF
		(StaffID VARCHAR(3),
        StaffName VARCHAR(50),
        ManagerID VARCHAR(3),
        Position VARCHAR(50),
        StaffPay DECIMAL(5,2),
        PRIMARY KEY(StaffID)
        );

ALTER TABLE STAFF
ADD FOREIGN key(ManagerID) REFERENCES staff(StaffID);

-- CREATE TABLE ROSTER
CREATE TABLE ROSTER
		(ScheduleID VARCHAR(4),
        StaffID VARCHAR(3),
        StartDateTime DATETIME,
        EndDateTime	DATETIME,
        PRIMARY KEY(ScheduleID, StaffID),
		FOREIGN KEY(ScheduleID) REFERENCES SCHEDULE(ScheduleID),
		FOREIGN KEY(StaffID) REFERENCES STAFF(StaffID)
        );

-- CREATE TABLE QUALIFICATIONS
CREATE TABLE QUALIFICATIONS
		(StaffID VARCHAR(3),
        SkillName VARCHAR(20),
        PRIMARY KEY(StaffID, SkillName),
		FOREIGN KEY(StaffID) REFERENCES STAFF(StaffID)
		);

-- CREATE TABLE MODEL
CREATE TABLE MODEL
		(ModelID VARCHAR(3),
        ModelName VARCHAR(9),
        ModelCapacity INTEGER,
        PRIMARY KEY(ModelID)
        );
        
-- CREATE TABLE VESSEL
CREATE TABLE VESSEL
		(VesselID VARCHAR(3),
        VesselName VARCHAR(50),
        VPurchaseYear YEAR,
        ModelID VARCHAR(3),
        PRIMARY KEY(VesselID),
		FOREIGN KEY(ModelID) REFERENCES MODEL(ModelID)
		);
        
-- CREATE TABLE BOOKING
CREATE TABLE BOOKING
		(VesselID VARCHAR(3),
        CruiseID VARCHAR (3),
        FromDate DATE,
		ToDate DATE,
		PRIMARY KEY(VesselID, CruiseID),
		FOREIGN KEY(VesselID) REFERENCES VESSEL(VesselID),
		FOREIGN KEY(CruiseID) REFERENCES CRUISE(CruiseID)
        );
        
-- CREATE TABLE SERVICEDOCK
CREATE TABLE SERVICEDOCK
		(ServiceDockID VARCHAR(4),
        ServiceDockName VARCHAR(50),
        PRIMARY KEY(ServiceDockID)
        );

-- CREATE TABLE SERVICE
CREATE TABLE SERVICE
        (VesselID VARCHAR(3),
        ServiceDockID VARCHAR(4),
        ServiceDate DATE,
        PRIMARY KEY(VesselID, ServiceDockID),
		FOREIGN KEY(VesselID) REFERENCES VESSEL(VesselID),
		FOREIGN KEY(ServiceDockID) REFERENCES SERVICEDOCK(ServiceDockID)
        );
        
-- INSERT AT LEAST 5 RECORDS INTO EACH TABLE. 
INSERT INTO LOCATION VALUES ('L01', 'Macquarie');
INSERT INTO LOCATION VALUES ('L02', 'Epping');
INSERT INTO LOCATION VALUES ('L03', 'Fairfield');
INSERT INTO LOCATION VALUES ('L04', 'Cabramatta');
INSERT INTO LOCATION VALUES ('L05', 'Eastwood');
INSERT INTO LOCATION VALUES ('L06', 'Sydney');

INSERT INTO ROUTE VALUES ('R01', 'Comment', 'L01', 'L02');
INSERT INTO ROUTE VALUES ('R02', 'Comment', 'L06', 'L03');
INSERT INTO ROUTE VALUES ('R03', 'Comment', 'L03', 'L04');
INSERT INTO ROUTE VALUES ('R04', 'Comment', 'L06', 'L05');
INSERT INTO ROUTE VALUES ('R05', 'Comment', 'L05', 'L06');
INSERT INTO ROUTE VALUES ('R06', 'Comment', 'L06', 'L01');

INSERT INTO MULTIPLESTOPOVERS VALUES ('R01', 'L05');
INSERT INTO MULTIPLESTOPOVERS VALUES ('R02', 'L04');
INSERT INTO MULTIPLESTOPOVERS VALUES ('R03', 'L06');
INSERT INTO MULTIPLESTOPOVERS VALUES ('R04', 'L03');
INSERT INTO MULTIPLESTOPOVERS VALUES ('R05', 'L01');
INSERT INTO MULTIPLESTOPOVERS VALUES ('R06', 'L02');

INSERT INTO CRUISE VALUES ('C01', 'HiraethCruise', '10', 'R01');
INSERT INTO CRUISE VALUES ('C02', 'NostalgiaCruise', '20', 'R02');
INSERT INTO CRUISE VALUES ('C03', 'PassionCruise', '25', 'R03');
INSERT INTO CRUISE VALUES ('C04', 'DreamCruise', '7', 'R04');
INSERT INTO CRUISE VALUES ('C05', 'AdventureCruise', '30', 'R05');
INSERT INTO CRUISE VALUES ('C06', 'NightmareCruise', '25', 'R06');

INSERT INTO SCHEDULE VALUES ('SC01', '2022-09-13', '100', 'C02');
INSERT INTO SCHEDULE VALUES ('SC02', '2022-08-14', '120', 'C02');
INSERT INTO SCHEDULE VALUES ('SC03', '2022-07-15', '180', 'C06');
INSERT INTO SCHEDULE VALUES ('SC04', '2022-06-16', '150', 'C04');
INSERT INTO SCHEDULE VALUES ('SC05', '2022-05-17', '75', 'C05');
INSERT INTO SCHEDULE VALUES ('SC06', '2020-05-17', '75', 'C06');
INSERT INTO SCHEDULE VALUES ('SC07', '2021-01-17', '75', 'C05');

INSERT INTO TOUR VALUES ('C01', 'T01', 'HiraethBusiness', '300.00', 'Deluxe');
INSERT INTO TOUR VALUES ('C02', 'T02', 'NostalgiaBusiness', '250.00', 'Basic');
INSERT INTO TOUR VALUES ('C03', 'T03', 'PassionBusiness', '199.99', 'Basic');
INSERT INTO TOUR VALUES ('C04', 'T04', 'DreamBusiness', '399.99', 'Business');
INSERT INTO TOUR VALUES ('C05', 'T05', 'AdventureBusiness', '500.00', 'Business');

INSERT INTO STAFF VALUES ('S01', 'Lachlan Macquarie', 'S02', 'Pilot', '80.00');
INSERT INTO STAFF VALUES ('S02', 'Central Courtyard', 'S03', 'Assistant', '90.00');
INSERT INTO STAFF VALUES ('S03', 'Lotus Esther', null, 'Manager', '100.00');
INSERT INTO STAFF VALUES ('S04', 'Mia Childcare', 'S03', 'Driver', '40.00');
INSERT INTO STAFF VALUES ('S05', 'Wally Walk', 'S02', 'Waiter', '20.00');

INSERT INTO ROSTER VALUES ('SC01', 'S01', '2022-09-19 18:30:00', '2022-09-22 10:00:00');
INSERT INTO ROSTER VALUES ('SC02', 'S02', '2022-10-20 12:00:00', '2022-10-23 11:00:00');
INSERT INTO ROSTER VALUES ('SC03', 'S03', '2022-11-21 13:30:00', '2022-11-24 07:30:00');
INSERT INTO ROSTER VALUES ('SC04', 'S04', '2022-12-22 14:00:00', '2022-12-25 09:00:00');
INSERT INTO ROSTER VALUES ('SC05', 'S05', '2022-08-23 16:30:00', '2022-08-26 06:00:00');

INSERT INTO QUALIFICATIONS VALUES ('S01', 'Swimming');
INSERT INTO QUALIFICATIONS VALUES ('S01', 'Communication');
INSERT INTO QUALIFICATIONS VALUES ('S02', 'Administration');
INSERT INTO QUALIFICATIONS VALUES ('S03', 'Management');
INSERT INTO QUALIFICATIONS VALUES ('S03', 'Problem Solving');
INSERT INTO QUALIFICATIONS VALUES ('S04', 'Driving');
INSERT INTO QUALIFICATIONS VALUES ('S05', 'Customer Service');

INSERT INTO MODEL VALUES ('M01', 'MODEL-101', '120');
INSERT INTO MODEL VALUES ('M02', 'MODEL-102', '140');
INSERT INTO MODEL VALUES ('M03', 'MODEL-103', '200');
INSERT INTO MODEL VALUES ('M04', 'MODEL-200', '170');
INSERT INTO MODEL VALUES ('M05', 'MODEL-200', '100');

INSERT INTO VESSEL VALUES ('V01', 'Vessel Diamond', '2010', 'M01');
INSERT INTO VESSEL VALUES ('V02', 'Vessel Gold', '2011', 'M02');
INSERT INTO VESSEL VALUES ('V03', 'Vessel Silver', '2019', 'M03');
INSERT INTO VESSEL VALUES ('V04', 'Vessel Carbon', '2020', 'M04');
INSERT INTO VESSEL VALUES ('V05', 'Vessel Pressure', '2021', 'M05');

INSERT INTO BOOKING VALUES ('V01', 'C01', '2020-08-12', '2020-09-12');
INSERT INTO BOOKING VALUES ('V02', 'C02', '2020-07-13', '2020-08-13');
INSERT INTO BOOKING VALUES ('V03', 'C03', '2019-06-14', '2019-07-14');
INSERT INTO BOOKING VALUES ('V04', 'C04', '2020-05-15', '2020-06-15');
INSERT INTO BOOKING VALUES ('V05', 'C05', '2021-04-16', '2021-05-16');
INSERT INTO BOOKING VALUES ('V01', 'C02', '2021-08-12', '2021-09-12');
INSERT INTO BOOKING VALUES ('V03', 'C04', '2019-05-15', '2019-06-15');
INSERT INTO BOOKING VALUES ('V03', 'C05', '2020-04-16', '2020-05-16');

INSERT INTO SERVICEDOCK VALUES ('SD01', 'Dock Macquarie');
INSERT INTO SERVICEDOCK VALUES ('SD02', 'Dock Courtyard');
INSERT INTO SERVICEDOCK VALUES ('SD03', 'Dock Theater');
INSERT INTO SERVICEDOCK VALUES ('SD04', 'Dock Childcare');
INSERT INTO SERVICEDOCK VALUES ('SD05', 'Dock Walk');

INSERT INTO SERVICE VALUES ('V01', 'SD01', '2020-10-10');
INSERT INTO SERVICE VALUES ('V02', 'SD02', '2020-09-11');
INSERT INTO SERVICE VALUES ('V03', 'SD03', '2019-08-12');
INSERT INTO SERVICE VALUES ('V04', 'SD01', '2020-07-13');
INSERT INTO SERVICE VALUES ('V05', 'SD02', '2021-06-14');

-- TASK 2: 
-- PRINT THE DETAILS OF THE TOUR.
-- COST: PREFIXED WITH A '$' SIGN.
-- SORT THE RECORDS: HIGHEST COST AT THE TOP.
SELECT TourName, TourType, CONCAT('$', TourCost) "Cost of the tour per day"
FROM TOUR
ORDER BY TourCost DESC;

-- TASK 3:
-- PRINT THE BOOKING DETAILS
SELECT VesselID, FromDate, ToDate, DATEDIFF(ToDate, FromDate) "Number of booking days"
FROM BOOKING;

-- TASK 4:
-- PRINT THE VESSEL DETAILS IF THE MODEL'S NAME IS "MODEL-200" & THE PURCHASE YEAR WAS AFTER 2015. 
-- USE EQUI-JOIN.
SELECT VesselID, VesselName, VPurchaseYear, V.ModelID
FROM VESSEL V, MODEL M
WHERE V.ModelID = M.ModelID
AND ModelName LIKE 'Model-200'
AND VPurchaseYear > 2015;

-- TASK 5: 
-- PRINT THE VESSEL NAME IF THEY HAVE BEEN BOOKED >= 10 DAYS. 
-- VPURCHASEYEAR (2015-2020).
-- ENSURE NO DUPLICATE RESULTS.
-- USE JOIN USING
SELECT DISTINCT VesselName
FROM VESSEL V 
JOIN BOOKING B
USING (VesselID)
WHERE (ToDate - FromDate) >= 10
AND VPurchaseYear BETWEEN 2015 AND 2020;

-- TASK 6:
-- USING A SUBQUERY PRINT THE MODEL NAME & THEIR CAPACITY IF THE YEAR(CURDATE()) - VPURCHASEYEAR < 5
SELECT ModelName, ModelCapacity
FROM MODEL M
WHERE ModelID IN
				(SELECT ModelID
                FROM VESSEL
                WHERE (YEAR(CURDATE()) - VPurchaseYear) < 5
                );
                
-- TASK 7:
-- PRINT STAFF NAME & POSITION IF (YEAR(CURDATE()) - YEAR(ENDDATETIME) < 5)
-- INCLUDE THE NAME OF ALL STAFF NAME AND THEIR RETROSPECTIVE MANAGERS' NAME.
SELECT S.StaffName, S.Position, M.StaffName "Manager's name"
FROM STAFF S
JOIN ROSTER R
ON S.StaffID = R.StaffID
LEFT JOIN STAFF M
ON S.ManagerID = M.StaffID
WHERE (YEAR(CURDATE()) - YEAR(EndDateTime)) < 5;

-- TASK 8: 
-- PRINT NUMBER OF CRUISES ALLOCATED TO A VESSEL.
-- PRINT THE VESSEL NAME AND RENAME BOTH COLUMNS.
-- ORDER BY NUMBER OF CRUISES WITH THE HIGHEST NUMBER AT THE TOP. 
SELECT VesselName 'Name of Vessel', COUNT(CruiseID) 'Number of Cruises'
FROM BOOKING B
LEFT JOIN CRUISE C
USING (CruiseID)
LEFT JOIN VESSEL V
USING (VesselID)
GROUP BY VesselName
ORDER BY COUNT(CruiseID) DESC;

-- TASK 9:
-- PRINT THE DETAILS OF ALL CRUISES WHICH HAVE NEVER BEEN SCHEDULED
SELECT C.CruiseID, CruiseName, NumOfDays, RouteID
FROM CRUISE C
LEFT JOIN SCHEDULE S
USING (CruiseID)
WHERE C.CruiseID NOT IN 
					(SELECT CruiseID
                    FROM SCHEDULE);
                    
-- TASK 10:
-- PRINT CRUISENAME AND THE TOURNAME & CALCULATE THE TOTAL AMOUNT OF THE CRUISE.
-- DATA SAVED IN THE TABLE ARE EXCLUSIVE OF TAXES.
-- QUERY SHOULD INCLUDE 10% TAX.
-- ONLY INCLUDE IF THE TOTAL COST OF THE TOUR (INCLUDING THE TAX) OF THE CRUISE > $3,000.
SELECT TourName, CruiseName, COUNT(T.CruiseID) "Total amount of the cruise"
FROM CRUISE C
JOIN TOUR T
USING (CruiseID)
WHERE TourCost*NumOfDays*(1+0.1) > 3000
GROUP BY TourName;

-- TASK 11:
-- SHOW THE STAFFNAME, ALONG WITH THE NUMBER OF SKILLS, IF THE NUMBER OF SKILLS IS MORE THAN ONE. 
SELECT StaffName, COUNT(SkillName) "Number of Skills"
FROM STAFF S
JOIN QUALIFICATIONS Q
USING (StaffID)
GROUP BY StaffName
HAVING COUNT(SkillName) > 1;

-- TASK 12:
-- PRINT THE STAFFNAME, MAX NUM OF DAYS THE STAFF WORK, TOURCOST,
-- UPDATED TOUR COST (INCREASED BY 2.7%), THAT HAVE USED A BUSINESS TOUR TYPE.
-- RENAME THE COLUMN NAMES.
-- ENSURE ALL NUMERICAL COLUMNS HAVE 2 DECIMAL PLACES ONLY. 
-- USE JOIN.
SELECT StaffName, MAX(DATEDIFF(EndDateTime, StartDateTime)) "Maximum number of days the staff work", TourCost, ROUND(TourCost*(1+0.027), 2) "Updated Tour Cost"
FROM STAFF S
JOIN ROSTER R
ON S.StaffID = R.StaffID
JOIN SCHEDULE SC 
ON R.ScheduleID = SC.ScheduleID
JOIN TOUR T
ON SC.CruiseID = T.CruiseID
WHERE TourType = 'Business'
GROUP BY StaffName;

-- Task 13: Print details of details of any tour that tourcost > $250.
-- Month(StartDate (Schedule)) = 1 of any year OR
-- StartDate (Schedule) in 2020 or 2022.
-- Sort by the tourcost in desc order.
SELECT *
FROM TOUR
WHERE TourCost > 250
AND CruiseID IN 
			(SELECT CruiseID
            FROM SCHEDULE
            WHERE MONTH(StartDate) = 1
            OR YEAR(StartDate) = 2020
            OR YEAR(StartDate) = 2022)
ORDER BY TourCost DESC;

-- SECTION B
-- Task 14: Print the names of service dock that have had a cruise
-- with more than one source location.
SELECT ServiceDockName
FROM SERVICEDOCK SD
JOIN SERVICE S
USING (ServiceDockID)
JOIN BOOKING B
USING (VesselID)
JOIN CRUISE C
USING (CruiseID)
JOIN ROUTE R
USING (RouteID)
GROUP BY ServiceDockName
HAVING COUNT(SourceLocationCode) > 1;

-- Task 15: Print the cruise details (CruiseID, CruiseName)
-- Total number of days per cruise. (Group By: CruiseID)
-- Only include if the total num of days > 10 days and has a basic tour.
SELECT CruiseID, CruiseName, SUM(NumOfDays) "Total number of days per cruise"
FROM CRUISE C
JOIN TOUR T
USING (CruiseID)
WHERE TourType = 'Basic'
GROUP BY CruiseID
HAVING SUM(NumOfDays) > 10;

-- SECTION C
-- Task 16: Display the average cost of earnings rostered in the fourth quarter of 2022. 
-- Round this to the nearest whole dollar.
-- Assume that the earning is received at the end of the rostered date.
-- NOTES: 
-- EndDateTime in the 4th quarter of 2022.
-- StaffPay: price for the tour per HOUR.
SELECT ROUND(AVG(StaffPay*HOUR((TIMEDIFF(StartDateTime, EndDateTime))))) "Average cost of earnings"
FROM STAFF S
JOIN ROSTER R
ON S.StaffID = R.StaffID
WHERE MONTH(EndDateTime) BETWEEN 10 AND 12
AND YEAR(EndDateTime) = 2022;

-- Task 17: Print the names of the staff members who have been rostered on a cruise that start in the afternoon 
-- (between 12pm - 3pm) and end before midday (between 6am - 12pm)
-- along with the name of the manager and the CruiseName. 
SELECT S.StaffName "Staff''s name", M.StaffName "Manager''s name", CruiseName
FROM STAFF S
LEFT JOIN STAFF M
ON S.ManagerID = M.StaffID
JOIN ROSTER R
ON S.StaffID = R.StaffID
JOIN SCHEDULE SC
USING (ScheduleID)
JOIN CRUISE C
USING (CruiseID)
WHERE S.StaffID IN 
				(SELECT STAFFID
                FROM ROSTER
                WHERE TIME(StartDateTime) BETWEEN '12:00:00' AND '15:00:00'
                AND TIME(EndDateTime) BETWEEN '06:00:00' AND '12:00:00'
				);

-- SECTION D
-- Task 18: Display the CruiseName, SourceLocationName and the SourceDestinationName 
-- alongside their IDs, if the cruise is either departing or arriving in Sydney.
SELECT CruiseName, L.LocationName "Source Location Name", SourceLocationCode, L1.LocationName "Destination Location Name", DesLocationCode
FROM ROUTE R
JOIN CRUISE C
USING (RouteID)
JOIN LOCATION L 
ON L.LocationCode = R.SourceLocationCode
JOIN LOCATION L1
ON L1.LocationCode = R.DesLocationCode
WHERE L.LocationName = 'Sydney'
OR L1.LocationName = 'Sydney';

-- Task 19: Print year, average salary of the staff per year and the names of the staff 
-- who make an average cost lesser then the staff's average salary.
SELECT YEAR(EndDateTime), AVG(StaffPay*(HOUR(TIMEDIFF(EndDateTime, StartDateTime)))) "Average Salary of the Staff", StaffName
FROM STAFF S
LEFT JOIN ROSTER R 
USING (StaffID)
GROUP BY StaffName
HAVING AVG(StaffPay*(HOUR(TIMEDIFF(EndDateTime, StartDateTime)))) <
														(SELECT AVG(StaffPay*(HOUR(TIMEDIFF(EndDateTime, StartDateTime))))
                                                        FROM STAFF);

-- Task 20: List the count of the staff and cruise per service dock (ServiceDockName)
-- Only include Staff whose surnames do not start with the letter E. 
SELECT COUNT(R.StaffID) "Count of the Staff", COUNT(B.CruiseID) "Count of the Cruise", ServiceDockName
FROM SERVICEDOCK SD
JOIN SERVICE SV
USING(ServiceDockID)
JOIN BOOKING B
USING (VesselID)
JOIN SCHEDULE SC
USING (CruiseID)
JOIN ROSTER R
USING (ScheduleID)
JOIN STAFF ST 
USING (StaffID)
WHERE StaffName NOT LIKE '% E%'
GROUP BY ServiceDockName;
