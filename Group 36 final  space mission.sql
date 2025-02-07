create database masaspacey;
-- 1. Create Position_Salary table
CREATE TABLE Position_Salary (
    Position VARCHAR(30) PRIMARY KEY,
    Base_Salary DECIMAL(10,2) DEFAULT 50000.00
);

-- 2. Create Staff table (superclass)
CREATE TABLE Staff (
    Staff_ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Date_of_Birth DATE,
    Position VARCHAR(30),
    Hire_Date DATE DEFAULT GETDATE(),
    Gender VARCHAR(30) DEFAULT 'Not Specified',
    FOREIGN KEY (Position) REFERENCES Position_Salary(Position)
);

-- 3. Create Engineer table (subclass)
CREATE TABLE Engineer (
    Staff_ID INT PRIMARY KEY,
    Engineering_Field VARCHAR(30) DEFAULT 'General',
    Certification VARCHAR(30) DEFAULT 'None',
    Skills VARCHAR(30),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- 4. Create Technician table (subclass)
CREATE TABLE Technician (
    Staff_ID INT PRIMARY KEY,
    Technical_Certification VARCHAR(30) DEFAULT 'Basic',
    Specialization VARCHAR(30) DEFAULT 'General',
    Certification_Level VARCHAR(30) DEFAULT 'Level 1',
    Shift_Timing VARCHAR(30) DEFAULT 'Day',
    Skills VARCHAR(30),
    Eng_ID INT,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Eng_ID) REFERENCES Engineer(Staff_ID)
);

-- 5. Create Researcher table (subclass)
CREATE TABLE Researcher (
    Staff_ID INT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL,
    Specialization VARCHAR(30) DEFAULT 'General',
    Num_of_Research INT DEFAULT 0,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- 6. Create Trainer table (subclass)
CREATE TABLE Trainer (
    Staff_ID INT PRIMARY KEY,
    Certification VARCHAR(30) DEFAULT 'Basic',
    Expertise_Area VARCHAR(30) DEFAULT 'General',
    Training_Hours INT DEFAULT 0,
    Program_Assigned VARCHAR(30) DEFAULT 'None',
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- 7. Create Doctor table (subclass)
CREATE TABLE Doctor (
    Staff_ID INT PRIMARY KEY,
    Medical_Specialty VARCHAR(30) DEFAULT 'General',
    On_Call_Status VARCHAR(30) DEFAULT 'Off',
    Certification VARCHAR(30) DEFAULT 'None',
    Medical_School VARCHAR(50) DEFAULT 'Unknown',
    Shift_Timing VARCHAR(30) DEFAULT 'Day',
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- 8. Create Medical_Record table
CREATE TABLE Medical_Record (
    Medical_ID INT IDENTITY(1,1) PRIMARY KEY,
    Health_Status VARCHAR(30) DEFAULT 'Good',
    Last_Checked_Date DATE DEFAULT GETDATE(),
    Notes VARCHAR(255) DEFAULT '',
    Doctor_ID INT,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Staff_ID)
);

-- 9. Create Medicine_in_Record table
CREATE TABLE Medicine_in_Record (
    Medical_ID INT,
    Medicine_ID INT,
    PRIMARY KEY (Medical_ID, Medicine_ID),
    FOREIGN KEY (Medical_ID) REFERENCES Medical_Record(Medical_ID)
  
);

-- 10. Create Training_Program table
CREATE TABLE Training_Program (
    Training_ID INT IDENTITY(1,1) PRIMARY KEY,
    Start_Date DATE DEFAULT GETDATE(),
    Training_EndDate DATE DEFAULT DATEADD(month, 6, GETDATE()),
    Training_Status VARCHAR(30) DEFAULT 'Planned',
    Training_Type VARCHAR(30) DEFAULT 'General',
    Trainer_ID INT,
    FOREIGN KEY (Trainer_ID) REFERENCES Trainer(Staff_ID)
);

-- 11. Create Astronaut table (subclass)
CREATE TABLE Astronaut (
    Staff_ID INT PRIMARY KEY,
    Training_Level VARCHAR(30) DEFAULT 'Basic',
    Specialization VARCHAR(30) DEFAULT 'General',
    Blood_Type VARCHAR(5) DEFAULT 'O+',
    Hours_in_Space INT DEFAULT 0,
    Training_ID INT,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Training_ID) REFERENCES Training_Program(Training_ID)
);

-- 12. Create Trained_Animal table (subclass)
CREATE TABLE Trained_Animal (
    Staff_ID INT PRIMARY KEY,
    Species VARCHAR(30) DEFAULT 'Unknown',
    Training_Level VARCHAR(30) DEFAULT 'Basic',
    Purpose VARCHAR(30) DEFAULT 'None',
    Breed VARCHAR(30) DEFAULT 'Unknown',
    Training_ID INT,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Training_ID) REFERENCES Training_Program(Training_ID)
);

-- 13. Create Crew_Team table
CREATE TABLE Crew_Team (
    Crew_Team_ID INT IDENTITY(1,1) PRIMARY KEY,
    Crew_Name VARCHAR(30) NOT NULL DEFAULT 'Unnamed Crew'
);

-- 14. Create Crew_Team_Members table
CREATE TABLE Crew_Team_Members (
    Crew_Team_ID INT,
    Astronaut_ID INT,
    Trained_Animal_ID INT,
    PRIMARY KEY (Crew_Team_ID, Astronaut_ID, Trained_Animal_ID),
    FOREIGN KEY (Crew_Team_ID) REFERENCES Crew_Team(Crew_Team_ID),
    FOREIGN KEY (Astronaut_ID) REFERENCES Astronaut(Staff_ID),
    FOREIGN KEY (Trained_Animal_ID) REFERENCES Trained_Animal(Staff_ID)
   
);

-- 15. Create Spacecraft table
CREATE TABLE Spacecraft (
    SC_ID INT IDENTITY(1,1) PRIMARY KEY,
    SC_Name VARCHAR(30) NOT NULL DEFAULT 'Unnamed Spacecraft',
    SC_Model VARCHAR(30) DEFAULT 'Standard',
    Maintenance_Status VARCHAR(30) DEFAULT 'Not Scheduled',
    Maintenance_Type VARCHAR(30) DEFAULT 'None',
    Eng_ID INT,
    FOREIGN KEY (Eng_ID) REFERENCES Engineer(Staff_ID)
);

-- 16. Create Space_Mission table
CREATE TABLE Space_Mission (
    Mission_ID INT IDENTITY(1,1) PRIMARY KEY,
    Objectives VARCHAR(255) DEFAULT 'Undefined Objectives',
    Mission_Type VARCHAR(30) DEFAULT 'General',
    Start_Date DATE DEFAULT GETDATE(),
    End_Date DATE DEFAULT DATEADD(year, 1, GETDATE()),
    Departure_Location VARCHAR(30) DEFAULT 'Earth',
    Mission_Name VARCHAR(50) NOT NULL DEFAULT 'Unnamed Mission',
    Mission_Summary VARCHAR(500) DEFAULT '',
    Results VARCHAR(500) DEFAULT '',
    Crew_Team_ID INT,
    Spacecraft_ID INT,
    FOREIGN KEY (Crew_Team_ID) REFERENCES Crew_Team(Crew_Team_ID),
    FOREIGN KEY (Spacecraft_ID) REFERENCES Spacecraft(SC_ID)
);

-- 17. Create Experiment table
CREATE TABLE Experiment (
    Experiment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Start_Date DATE DEFAULT GETDATE(),
    End_Date DATE DEFAULT DATEADD(month, 6, GETDATE()),
    Status VARCHAR(30) DEFAULT 'Planned'
);

-- 18. Create Space_Mission_Experiment table
CREATE TABLE Space_Mission_Experiment (
    Space_Mission_ID INT,
    Experiment_ID INT,
    PRIMARY KEY (Space_Mission_ID, Experiment_ID),
    FOREIGN KEY (Space_Mission_ID) REFERENCES Space_Mission(Mission_ID),
    FOREIGN KEY (Experiment_ID) REFERENCES Experiment(Experiment_ID)
);

-- 19. Create Research table
CREATE TABLE Research (
    Research_ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL DEFAULT 'Untitled Research',
    Abstract VARCHAR(1000) DEFAULT '',
    Publication_Date DATE DEFAULT GETDATE(),
    Field_Of_Research VARCHAR(50) DEFAULT 'General',
    Researcher_ID INT,
    FOREIGN KEY (Researcher_ID) REFERENCES Researcher(Staff_ID)
);

-- 20. Create Research_Experiment table
CREATE TABLE Research_Experiment (
    Research_ID INT,
    Experiment_ID INT,
    PRIMARY KEY (Research_ID, Experiment_ID),
    FOREIGN KEY (Research_ID) REFERENCES Research(Research_ID),
    FOREIGN KEY (Experiment_ID) REFERENCES Experiment(Experiment_ID)
);

-- 21. Create Equipment table
CREATE TABLE Equipment (
    Equipment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Equipment_Type VARCHAR(50) DEFAULT 'Standard',
    Length INT DEFAULT 100,  
    Width INT DEFAULT 50,    
    Height INT DEFAULT 50,   
    Mission_ID INT,
    FOREIGN KEY (Mission_ID) REFERENCES Space_Mission(Mission_ID)
);
-- 1. Add FOREIGN KEY constraint to Staff (Position → Position_Salary)
ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_Position FOREIGN KEY (Position) REFERENCES Position_Salary(Position);

-- 2. Add FOREIGN KEY constraint to Engineer (Staff_ID → Staff)
ALTER TABLE Engineer
ADD CONSTRAINT FK_Engineer_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID);

-- 3. Add FOREIGN KEY constraint to Technician (Staff_ID → Staff, Eng_ID → Engineer)
ALTER TABLE Technician
ADD CONSTRAINT FK_Technician_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    CONSTRAINT FK_Technician_Engineer FOREIGN KEY (Eng_ID) REFERENCES Engineer(Staff_ID);

-- 4. Add FOREIGN KEY constraint to Researcher (Staff_ID → Staff)
ALTER TABLE Researcher
ADD CONSTRAINT FK_Researcher_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID);

-- 5. Add FOREIGN KEY constraint to Trainer (Staff_ID → Staff)
ALTER TABLE Trainer
ADD CONSTRAINT FK_Trainer_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID);

-- 6. Add FOREIGN KEY constraint to Doctor (Staff_ID → Staff)
ALTER TABLE Doctor
ADD CONSTRAINT FK_Doctor_Staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID);

-- 7. Add FOREIGN KEY constraint to Medical_Record (Doctor_ID → Doctor)
ALTER TABLE Medical_Record
ADD CONSTRAINT FK_Medical_Record_Doctor FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Staff_ID);

-- 8. Add FOREIGN KEY constraint to Medicine_in_Record (Medical_ID → Medical_Record)
ALTER TABLE Medicine_in_Record
ADD CONSTRAINT FK_Medicine_in_Record_Medical FOREIGN KEY (Medical_ID) REFERENCES Medical_Record(Medical_ID);

-- 9. Add FOREIGN KEY constraint to Astronaut (Training_ID → Training_Program)
ALTER TABLE Astronaut
ADD CONSTRAINT FK_Astronaut_Training FOREIGN KEY (Training_ID) REFERENCES Training_Program(Training_ID);

-- 10. Add FOREIGN KEY constraint to Spacecraft (Eng_ID → Engineer)
ALTER TABLE Spacecraft
ADD CONSTRAINT FK_Spacecraft_Engineer FOREIGN KEY (Eng_ID) REFERENCES Engineer(Staff_ID);

INSERT INTO Position_Salary (Position, Base_Salary)
VALUES
('Engineer', 70000.00),
('Technician', 45000.00),
('Researcher', 60000.00),
('Trainer', 50000.00),
('Doctor', 90000.00),
('Astronaut', 100000.00),
('Electrical Engineer', 80000.00),
('Mechanical Engineer', 78000.00),
('AI Specialist', 90000.00),
('Cybersecurity Expert', 85000.00),
('Trained Animal', 30000.00);


INSERT INTO Staff (Name, Date_of_Birth, Position, Hire_Date, Gender)
VALUES
('Ahmed Hassan', '1985-03-15', 'Engineer', '2010-06-01', 'Male'),
('Mona Ali', '1990-07-22', 'Technician', '2015-03-12', 'Female'),
('Hany Youssef', '1982-11-05', 'Researcher', '2008-09-15', 'Male'),
('Samir Tawfik', '1978-02-28', 'Trainer', '2005-01-10', 'Male'),
('Laila Saeed', '1981-05-19', 'Doctor', '2012-04-20', 'Female'),
('Omar Adel', '1987-08-30', 'Engineer', '2011-07-15', 'Male'),
('Nadia Khalil', '1992-01-14', 'Engineer', '2017-02-25', 'Female'),
('Salma Fathy', '1995-09-10', 'Electrical Engineer', '2020-08-01', 'Female'),
('Hisham Rami', '1989-12-25', 'Mechanical Engineer', '2016-05-10', 'Male'),
('Mahmoud Tarek', '1991-04-13', 'Technician', '2014-11-18', 'Male'),
('Aya Nabil', '1993-06-22', 'Technician', '2018-01-05', 'Female'),
('Kareem Mostafa', '1988-07-09', 'Technician', '2013-09-01', 'Male'),
('Dina Hamdy', '1996-03-18', 'Technician', '2021-06-15', 'Female'),
('Mariam Samy', '1985-11-20', 'Researcher', '2010-03-01', 'Female'),
('Khaled Adel', '1990-05-08', 'Researcher', '2015-08-12', 'Male'),
('Sara Atef', '1988-10-25', 'AI Specialist', '2013-07-18', 'Female'),
('Nader Ibrahim', '1992-12-14', 'Cybersecurity Expert', '2018-03-10', 'Male'),
('Amal Ezz', '1979-04-02', 'Trainer', '2006-09-20', 'Female'),
('Tarek Shawky', '1983-06-17', 'Trainer', '2008-12-05', 'Male'),
('Yasmine Hafez', '1986-09-27', 'Trainer', '2011-10-15', 'Female'),
('Hossam El-Din', '1980-01-19', 'Trainer', '2007-03-30', 'Male'),
('Ayman Zaki', '1977-11-03', 'Doctor', '2004-07-10', 'Male'),
('Reem Adel', '1984-02-16', 'Doctor', '2009-05-20', 'Female'),
('Osama Fathy', '1989-10-12', 'Doctor', '2015-06-25', 'Male'),
('Ferial Magdy', '1991-03-29', 'Doctor', '2017-08-15', 'Female'),
('Ali Mostafa', '1990-01-07', 'Astronaut', '2016-04-01', 'Male'),
('Heba Mahmoud', '1992-09-14', 'Astronaut', '2018-05-10', 'Female'),
('Youssef Zaki', '1995-06-05', 'Astronaut', '2021-09-20', 'Male'),
('Nour El-Sayed', '1987-10-30', 'Astronaut', '2012-11-15', 'Female'),
('Samar Gaber', '1993-12-22', 'Astronaut', '2019-07-01', 'Female'),
('Bolt', '2017-05-01', 'Trained Animal', '2019-01-10', 'Male'),
('George', '2015-08-15', 'Trained Animal', '2017-03-20', 'Male'),
('Luna', '2019-01-05', 'Trained Animal', '2020-06-10', 'Female'),
('Falco', '2016-04-12', 'Trained Animal', '2018-09-01', 'Male'),
('Thunder', '2018-02-28', 'Trained Animal', '2020-11-15', 'Male'),
('Mo', '2018-02-28', 'Astronaut', '2020-11-15', 'Male');
-- Disable IDENTITY_INSERT after insertion
SET IDENTITY_INSERT Staff OFF;

-- 27. Insert records into Engineer
INSERT INTO Engineer (Staff_ID, Engineering_Field, Certification, Skills) VALUES
(1, 'Aerospace', 'Certified Engineer', 'Structural Analysis'),
(6, 'Mechanical', 'Certified Engineer', 'Thermodynamics'),
(7, 'Electrical', 'Certified Engineer', 'Circuit Design'),
(8, 'Software', 'Certified Engineer', 'Programming'),
(9, 'Civil', 'Certified Engineer', 'Construction Management');

-- 28. Insert records into Technician
INSERT INTO Technician (Staff_ID, Technical_Certification, Specialization, Certification_Level, Shift_Timing, Skills, Eng_ID) VALUES
(2, 'Space Systems', 'Robotics', 'Advanced', 'Day', 'Automation', 1),
(10, 'Electronics', 'Sensors', 'Intermediate', 'Night', 'Troubleshooting', 1),
(11, 'Mechanical', 'Hydraulics', 'Basic', 'Day', 'Welding', 6),
(12, 'Software', 'Networks', 'Advanced', 'Night', 'Networking', 7),
(13, 'Instrumentation', 'Measurement', 'Intermediate', 'Day', 'Calibration', 7);

-- 29. Insert records into Researcher
INSERT INTO Researcher (Staff_ID, Email, Specialization, Num_of_Research) VALUES
(3, 'hany.youssef@example.com', 'Astrophysics', 12),
(14, 'mariam.samy@example.com', 'Biomedical', 10),
(15, 'khaled.adel@example.com', 'AI', 8),
(16, 'sara.atef@example.com', 'Cybersecurity', 11),
(17, 'nader.ibrahim@example.com', 'Quantum Computing', 9);

-- 30. Insert records into Trainer
INSERT INTO Trainer (Staff_ID, Certification, Expertise_Area, Training_Hours, Program_Assigned) VALUES
(4, 'Certified Trainer', 'Spacecraft Maintenance', 120, 'Program 1'),
(18, 'Certified Trainer', 'Medical Training', 100, 'Program 2'),
(19, 'Certified Trainer', 'Astronaut Training', 150, 'Program 3'),
(20, 'Certified Trainer', 'Technical Skills', 200, 'Program 4'),
(21, 'Certified Trainer', 'Research Methods', 180, 'Program 5');

-- Insert records into Doctor 
INSERT INTO Doctor (Staff_ID, Medical_Specialty, On_Call_Status, Certification, Medical_School, Shift_Timing) VALUES
(5, 'Cardiology', 'Yes', 'Board Certified', 'Cairo University', 'Day'),
(22, 'Neurology', 'No', 'Board Certified', 'Ain Shams University', 'Night'),
(23, 'Pediatrics', 'Yes', 'Board Certified', 'Alexandria University', 'Day'),
(24, 'Orthopedics', 'No', 'Board Certified', 'Cairo University', 'Night'),
(25, 'Dermatology', 'Yes', 'Board Certified', 'Mansoura University', 'Day');


-- 32. Insert records into Training_Program
INSERT INTO Training_Program (Start_Date, Training_EndDate, Training_Status, Training_Type, Trainer_ID) VALUES
('2024-01-01', '2024-03-01', 'Ongoing', 'Spacecraft Maintenance', 4),
('2024-02-01', '2024-04-01', 'Planned', 'Astronaut Training', 4),
('2023-10-01', '2023-12-01', 'Completed', 'Medical Training', 4),
('2023-11-01', '2024-01-15', 'Ongoing', 'Technical Certification', 4),
('2024-03-01', '2024-05-01', 'Planned', 'Research Methods', 4);

-- 33. Insert records into Astronaut
INSERT INTO Astronaut (Staff_ID, Training_Level, Specialization, Hours_in_Space, Training_ID) VALUES
(26, 'Advanced', 'Mission Specialist', 200, 1),
(27, 'Intermediate', 'Payload Specialist', 150, 2),
(28, 'Beginner', 'Flight Engineer', 100, 3),
(29, 'Advanced', 'Commander', 300, 4),
(30, 'Intermediate', 'Scientist', 180, 5);

-- 34. Insert records into Trained_Animal
INSERT INTO Trained_Animal (Staff_ID, Species, Training_Level, Purpose, Breed, Training_ID) VALUES
(31, 'Dog', 'Intermediate', 'Rescue Operations', 'German Shepherd', 1),
(32, 'Monkey', 'Advanced', 'Experimental Testing', 'Rhesus Macaque', 2),
(33, 'Cat', 'Beginner', 'Companion Support', 'Persian', 3),
(34, 'Falcon', 'Advanced', 'Aerial Reconnaissance', 'Peregrine', 4),
(35, 'Horse', 'Intermediate', 'Load Transport', 'Arabian', 5);

-- 35. Insert records into Spacecraft
INSERT INTO Spacecraft (SC_Name, SC_Model, Maintenance_Status, Maintenance_Type, Eng_ID) VALUES
('Unnamed Spacecraft', 'Standard', 'Not Scheduled', 'None', 1),
('Unnamed Spacecraft', 'Standard', 'Not Scheduled', 'None', 6),
('Unnamed Spacecraft', 'Standard', 'Not Scheduled', 'None', 7),
('Unnamed Spacecraft', 'Standard', 'Not Scheduled', 'None', 8),
('Unnamed Spacecraft', 'Standard', 'Not Scheduled', 'None', 9);

-- 36. Insert records into Crew_Team
INSERT INTO Crew_Team (Crew_Name) VALUES
('Alpha Team'),
('Beta Team'),
('Gamma Team');

-- 37. Insert records into Crew_Team_Members
INSERT INTO Crew_Team_Members (Crew_Team_ID, Astronaut_ID, Trained_Animal_ID) VALUES
(1, 26, 31),
(1, 27, 32),
(2, 28, 33),
(2, 29, 34),
(3, 30, 35);

-- 38. Insert records into Space_Mission
INSERT INTO Space_Mission (Objectives, Mission_Type, Start_Date, End_Date, Departure_Location, Mission_Name, Mission_Summary, Results, Crew_Team_ID, Spacecraft_ID) VALUES
('Explore the surface of Mars.', 'Exploration', '2025-05-01', '2025-12-31', 'Cairo Launch Center', 'Mars Explorer', 'Successful landing and data collection.', 'Success', 1, 1),
('Deploy a new satellite.', 'Deployment', '2026-01-15', '2026-07-15', 'Cairo Launch Center', 'Satellite Deployment', 'Satellite successfully deployed.', 'Success', 1, 2),
('Conduct lunar research.', 'Research', '2027-03-10', '2027-09-10', 'Giza Launch Site', 'Lunar Research Mission', 'Collected valuable lunar samples.', 'Success', 2, 3),
('Deep space probe launch.', 'Research', '2028-04-20', '2028-10-20', 'Red Sea Launch Facility', 'Deep Space Probe', 'Probe launched and operational.', 'Success', 2, 4),
('Habitat construction on ISS.', 'Construction', '2029-06-05', '2029-12-05', 'Hurghada Launch Center', 'ISS Habitat Expansion', 'New habitat module installed.', 'Success', 3, 5);

-- 39. Insert records into Experiment
INSERT INTO Experiment (Start_Date, End_Date, Status) VALUES
('2025-06-01', '2025-09-30', 'Completed'),
('2026-02-01', '2026-05-31', 'Completed'),
('2027-04-01', '2027-07-31', 'Ongoing'),
('2028-05-01', '2028-08-31', 'Planned'),
('2029-07-01', '2029-10-31', 'Planned');

-- 40. Insert records into Space_Mission_Experiment
INSERT INTO Space_Mission_Experiment (Space_Mission_ID, Experiment_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- 41. Insert records into Research
INSERT INTO Research (Title, Abstract, Publication_Date, Field_Of_Research, Researcher_ID) VALUES
('Mars Soil Composition', 'Analyzing the mineral composition of Martian soil samples.', '2026-01-15', 'Astrophysics', 3),
('Satellite Communication Systems', 'Improving satellite communication reliability.', '2026-08-20', 'Engineering', 3),
('Lunar Surface Biology', 'Studying potential life forms on the lunar surface.', '2028-02-10', 'Biology', 14),
('Deep Space Propulsion', 'Developing advanced propulsion systems for deep space missions.', '2028-09-05', 'Engineering', 15),
('ISS Habitat Sustainability', 'Ensuring long-term sustainability of habitats on ISS.', '2029-11-20', 'Environmental Science', 16);

-- 42. Insert records into Research_Experiment
INSERT INTO Research_Experiment (Research_ID, Experiment_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- 43. Insert records into Equipment
INSERT INTO Equipment (Equipment_Type, Length, Width, Height, Mission_ID) VALUES
('Soil Analyzer', 2, 1, 1, 1),
('Communication Antenna', 5, 2, 2, 2),
('Biology Lab Kit', 3, 3, 2, 3),
('Propulsion Module', 10, 5, 5, 4),
('Habitat Module', 20, 10, 10, 5);







-- 44. Insert records into Medical_Record
INSERT INTO Medical_Record (Health_Status, Last_Checked_Date, Notes, Doctor_ID) VALUES
('Good', '2024-11-01', 'Routine checkup. All vital signs normal.', 5),
('Fair', '2024-11-02', 'Minor injury from space debris. Treatment administered.', 22),
('Excellent', '2024-11-03', 'No health issues. Ready for the mission.', 23),
('Good', '2024-11-04', 'No symptoms of space sickness. Regular monitoring.', 24),
('Satisfactory', '2024-11-05', 'Routine check. No concerns detected.', 25);
-- 45. Insert records into Medicine_in_Record
INSERT INTO Medicine_in_Record (Medical_ID, Medicine_ID)
VALUES
(1, 101),  
(2, 102),  
(3, 103),  
(4, 104),  
(5, 105);

SELECT 
    S.Name AS Staff_Name,
   
    DATEDIFF(YEAR, S.Hire_Date, GETDATE()) AS Years_of_Service,
    (PS.Base_Salary * DATEDIFF(YEAR, S.Hire_Date, GETDATE())) AS Salary
FROM 
    Staff S
INNER JOIN 
    Position_Salary PS
ON 
    S.Position = PS.Position
ORDER BY 
    Salary DESC;

SELECT 
    E.Staff_ID AS Engineer_ID,
    E.Engineering_Field,
    E.Skills AS Engineer_Skills,
    COUNT(SC.SC_Name) AS Total_Spacecraft,
    CASE 
        WHEN COUNT(SC.SC_Name) > 3 THEN 'Busy'
        WHEN COUNT(SC.SC_Name) BETWEEN 1 AND 3 THEN 'Moderate'
        ELSE 'Free'
    END AS Workload_Category,
    (SELECT COUNT(T.Staff_ID) 
     FROM Technician T 
     WHERE T.Eng_ID = E.Staff_ID) AS Total_Technicians,
    AVG(CASE 
        WHEN SC.Maintenance_Status = 'Not Scheduled' THEN 1
        WHEN SC.Maintenance_Status = 'Scheduled' THEN 2
        WHEN SC.Maintenance_Status = 'Overdue' THEN 3
        ELSE 0
    END) AS Average_Maintenance,
    (
        SELECT DISTINCT 
            STUFF(
                (SELECT ', ' + T.Shift_Timing
                 FROM Technician T
                 WHERE T.Eng_ID = E.Staff_ID
                 FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 
                 1, 2, ''
            )
    ) AS Technician_Shift_Timings
FROM 
    Engineer E
JOIN 
    Spacecraft SC
ON 
    E.Staff_ID = SC.Eng_ID
GROUP BY 
    E.Staff_ID, E.Engineering_Field, E.Skills
ORDER BY 
    Workload_Category DESC, Total_Technicians DESC;
    
 
    
    
    CREATE VIEW EngineerTechnicianView AS
SELECT 
    E.Staff_ID AS Engineer_ID,
    SE.Name AS Engineer_Name,
    T.Staff_ID AS Technician_ID,
    ST.Name AS Technician_Name
FROM 
    Engineer E
JOIN 
    Technician T
ON 
    E.Staff_ID = T.Eng_ID
JOIN 
    Staff SE
ON 
    E.Staff_ID = SE.Staff_ID
JOIN 
    Staff ST
ON 
    T.Staff_ID = ST.Staff_ID;
    
    SELECT * FROM EngineerTechnicianView;
    
    
  SELECT 
    S.Staff_ID,
    S.Name,
    S.Position
FROM 
    Staff S
LEFT JOIN 
    Engineer E ON S.Staff_ID = E.Staff_ID
LEFT JOIN 
    Technician T ON S.Staff_ID = T.Staff_ID
LEFT JOIN 
    Doctor D ON S.Staff_ID = D.Staff_ID
LEFT JOIN 
    Researcher R ON S.Staff_ID = R.Staff_ID
LEFT JOIN 
    Trainer Tr ON S.Staff_ID = Tr.Staff_ID
LEFT JOIN 
    Astronaut A ON S.Staff_ID = A.Staff_ID
LEFT JOIN 
    Trained_Animal TA ON S.Staff_ID = TA.Staff_ID
WHERE 
    E.Staff_ID IS NULL AND 
    T.Staff_ID IS NULL AND 
    D.Staff_ID IS NULL AND 
    R.Staff_ID IS NULL AND 
    Tr.Staff_ID IS NULL AND 
    A.Staff_ID IS NULL AND 
    TA.Staff_ID IS NULL;
    
    SELECT Staff_ID, Name, Hire_Date,DATEDIFF(YEAR, S.Hire_Date, GETDATE()) AS Years_of_Service FROM Staff S;
    
    
    SELECT 
    COUNT(Experiment.Experiment_ID) AS Experiment_Count, -- Add COUNT() for Experiment_Count
    Experiment.Experiment_ID, 
    Experiment.[Status], 
    Experiment.Start_Date, 
    Experiment.End_Date, 
    Research.Title AS Research_Title, 
    Staff.Name AS Researcher_Name, 
    Research.Field_Of_Research
FROM Experiment
INNER JOIN Research_Experiment 
    ON Experiment.Experiment_ID = Research_Experiment.Experiment_ID
INNER JOIN Research 
    ON Research_Experiment.Research_ID = Research.Research_ID
INNER JOIN Staff 
    ON Research.Researcher_ID = Staff.Staff_ID
WHERE Experiment.Start_Date > '2016-12-31' 
  AND Research.Field_Of_Research = 'Astrophysics'
GROUP BY 
    Experiment.Experiment_ID, 
    Experiment.[Status], 
    Experiment.Start_Date, 
    Experiment.End_Date, 
    Research.Title, 
    Staff.Name, 
    Research.Field_Of_Research;
    
    



SELECT 
    Space_Mission.Mission_ID, 
    Space_Mission.Mission_Name, 
    Space_Mission.Mission_Type, 
    Space_Mission.Start_Date AS Mission_Start_Date, 
    Space_Mission.End_Date AS Mission_End_Date,
    Experiment.Experiment_ID, 
    Experiment.Status AS Experiment_Status,
    Experiment.Start_Date AS Experiment_Start_Date, 
    Experiment.End_Date AS Experiment_End_Date,
    CASE 
        WHEN Experiment.Status = 'Completed' THEN 'Experiment successfully completed'
        WHEN Experiment.Status = 'Ongoing' THEN 'Experiment is currently in progress'
        WHEN Experiment.Status = 'Planned' THEN 'Experiment is planned for future'
        WHEN Experiment.Status IS NULL THEN 'No associated experiment'
        ELSE 'Unknown status'
    END AS Experiment_Description
FROM Space_Mission
LEFT JOIN Space_Mission_Experiment ON Space_Mission.Mission_ID = Space_Mission_Experiment.Space_Mission_ID
LEFT JOIN Experiment ON Space_Mission_Experiment.Experiment_ID = Experiment.Experiment_ID
ORDER BY Space_Mission.Start_Date, Experiment.Start_Date;


SELECT 
    Crew_Team.Crew_Team_ID, 
    Crew_Team.Crew_Name, 
    COUNT(Space_Mission.Mission_ID) AS Mission_Count,
    CASE 
        WHEN COUNT(Space_Mission.Mission_ID) > 5 THEN 'Gold'
        WHEN COUNT(Space_Mission.Mission_ID) > 2 THEN 'Silver'
        WHEN COUNT(Space_Mission.Mission_ID) = 1 THEN 'Bronze'
        ELSE 'No Level'
    END AS Team_Level
FROM Crew_Team
LEFT JOIN Space_Mission ON Crew_Team.Crew_Team_ID = Space_Mission.Crew_Team_ID
GROUP BY Crew_Team.Crew_Team_ID, Crew_Team.Crew_Name
ORDER BY Mission_Count DESC;


SELECT 
    Crew_Team.Crew_Team_ID, 
    Crew_Team.Crew_Name, 
    COUNT(CASE WHEN Crew_Team_Members.Astronaut_ID IS NOT NULL THEN 1 END) AS Astronaut_Count,
    COUNT(CASE WHEN Crew_Team_Members.Trained_Animal_ID IS NOT NULL THEN 1 END) AS Trained_Animal_Count,
    COUNT(*) AS Total_Capacity
FROM Crew_Team
LEFT JOIN Crew_Team_Members ON Crew_Team.Crew_Team_ID = Crew_Team_Members.Crew_Team_ID
GROUP BY Crew_Team.Crew_Team_ID, Crew_Team.Crew_Name
ORDER BY Total_Capacity DESC;


SELECT 
    Space_Mission.Mission_ID, 
    Space_Mission.Mission_Name, 
    Space_Mission.Mission_Type, 
    Space_Mission.Start_Date, 
    Space_Mission.End_Date, 
    Space_Mission.Departure_Location, 
    Crew_Team.Crew_Name AS Assigned_Crew_Team,
    Spacecraft.SC_Name AS Assigned_Spacecraft,
    (SELECT COUNT(Space_Mission_Experiment.Experiment_ID)
     FROM Space_Mission_Experiment
     WHERE Space_Mission_Experiment.Space_Mission_ID = Space_Mission.Mission_ID) AS Experiment_Count
FROM Space_Mission
LEFT JOIN Crew_Team ON Space_Mission.Crew_Team_ID = Crew_Team.Crew_Team_ID
LEFT JOIN Spacecraft ON Space_Mission.Spacecraft_ID = Spacecraft.SC_ID
ORDER BY Space_Mission.Start_Date;




	SELECT 
    TA.Staff_ID AS Animal_ID,
    TA.Species,
    TA.Breed,
    TA.Training_Level,
    TA.Purpose
FROM 
    Trained_Animal TA
WHERE 
    TA.Purpose LIKE '%Rescue%' 
    AND TA.Training_Level IN ('Intermediate', 'Advanced')
ORDER BY 
    TA.Training_Level DESC, 
    TA.Species;

SELECT 
    TP.Training_ID,
    TP.Training_Type,
    TP.Start_Date,
    TP.Training_EndDate,
    TP.Training_Status,
    Trainer.Staff_ID AS Trainer_ID,
    Trainer.Certification AS Trainer_Certification,
    Trainer.Expertise_Area AS Trainer_Expertise,
    (SELECT STRING_AGG(Ast.Staff_ID, ', ') 
     FROM Astronaut Ast
     WHERE Ast.Training_ID = TP.Training_ID
    ) AS Assigned_Astronaut_Ids,
    (SELECT STRING_AGG(TA.Species + ' (' + TA.Breed + ')', ', ') 
     FROM Trained_Animal TA
     WHERE TA.Training_ID = TP.Training_ID
    ) AS Assigned_Animals
FROM 
    Training_Program TP
LEFT JOIN 
    Trainer ON TP.Trainer_ID = Trainer.Staff_ID
WHERE 
    TP.Training_Status = 'Active'
ORDER BY 
    TP.Start_Date;

 SELECT 
    TA.Staff_ID AS Animal_ID, 
    TA.Species, 
    TA.Training_Level, 
    TA.Purpose, 
    COUNT(SM.Mission_ID) AS Missions_Assigned,
    CASE 
        WHEN TA.Training_Level = 'Advanced' AND COUNT(SM.Mission_ID) >= 2 THEN 'Highly Useful'
        WHEN TA.Training_Level = 'Intermediate' THEN 'Moderately Useful'
        ELSE 'Low Usefulness'
    END AS Usefulness_Rank
FROM 
    Trained_Animal TA
LEFT JOIN 
    Crew_Team_Members CTM ON TA.Staff_ID = CTM.Trained_Animal_ID
LEFT JOIN 
    Space_Mission SM ON CTM.Crew_Team_ID = SM.Crew_Team_ID
GROUP BY 
    TA.Staff_ID, TA.Species, TA.Training_Level, TA.Purpose

SELECT 
    S.Name AS Trainer_Name, 
    COUNT(DISTINCT TA.Staff_ID) AS Animals_Trained, 
    SUM(CASE WHEN TA.Training_Level = 'Advanced' THEN 1 ELSE 0 END) AS Advanced_Trained,
    COUNT(DISTINCT SM.Mission_ID) AS Missions_Completed,
    (SUM(CASE WHEN TA.Training_Level = 'Advanced' THEN 1 ELSE 0 END) + COUNT(DISTINCT SM.Mission_ID)) AS Performance_Score
FROM 
    Trainer T
LEFT JOIN 
    Staff S ON T.Staff_ID = S.Staff_ID
LEFT JOIN 
    Training_Program TP ON T.Staff_ID = TP.Trainer_ID
LEFT JOIN 
    Trained_Animal TA ON TP.Training_ID = TA.Training_ID
LEFT JOIN 
    Crew_Team_Members CTM ON TA.Staff_ID = CTM.Trained_Animal_ID
LEFT JOIN 
    Space_Mission SM ON CTM.Crew_Team_ID = SM.Crew_Team_ID
GROUP BY 
    S.Name
ORDER BY 
    Performance_Score DESC;

 SELECT 
    TA.Species, 
    COUNT(TA.Staff_ID) AS Total_Animals_Trained, 
    CASE 
        WHEN COUNT(TA.Staff_ID) > 20 THEN 'High Demand'
        WHEN COUNT(TA.Staff_ID) BETWEEN 10 AND 20 THEN 'Moderate Demand'
        ELSE 'Low Demand'
    END AS Training_Demand
FROM 
    Trained_Animal TA
LEFT JOIN 
    Training_Program TP ON TA.Training_ID = TP.Training_ID
GROUP BY 
    TA.Species
ORDER BY 
    Total_Animals_Trained DESC;
	SELECT 
    Mission_Name,
    Start_Date,
    End_Date,
    DATEDIFF(DAY, Start_Date, End_Date) AS Mission_Duration_Days,
    CASE 
        WHEN DATEDIFF(DAY, Start_Date, End_Date) >= 180 THEN 'Long Mission'
        ELSE 'Short Mission'
    END AS Mission_Type
FROM 
    Space_Mission
WHERE 
    Start_Date >= '2026-01-01' AND End_Date <= '2028-12-31';
       SELECT 
    CT.Crew_Name,
    S1.Name AS Astronaut_Name,
    S2.Name AS Trained_Animal_Name
FROM 
    Crew_Team CT
JOIN 
    Crew_Team_Members CTM ON CT.Crew_Team_ID = CTM.Crew_Team_ID
JOIN 
    Staff S1 ON CTM.Astronaut_ID = S1.Staff_ID
JOIN 
    Staff S2 ON CTM.Trained_Animal_ID = S2.Staff_ID
WHERE 
    CT.Crew_Name = 'Alpha Team';
    SELECT 
    R.Researcher_ID,
    COUNT(R.Research_ID) AS Total_Research
FROM 
    Research R
GROUP BY 
    R.Researcher_ID;
SELECT 
    S.Name AS Researcher_Name,
    R.Field_Of_Research
FROM 
    Research R
JOIN 
    Researcher RS ON R.Researcher_ID = RS.Staff_ID
JOIN 
    Staff S ON RS.Staff_ID = S.Staff_ID
WHERE 
    R.Field_Of_Research IN (
        SELECT 
            Field_Of_Research
        FROM 
            Research
        GROUP BY 
            Field_Of_Research
        HAVING 
            COUNT(Research_ID) = (
                SELECT 
                    MAX(Field_Research_Count)
                FROM (
                    SELECT 
                        Field_Of_Research, 
                        COUNT(Research_ID) AS Field_Research_Count
                    FROM 
                        Research
                    GROUP BY 
                        Field_Of_Research
                ) AS Temp
            )
    );
SELECT 
    CT.Crew_Name,
    COUNT(CTM.Astronaut_ID) AS Astronaut_Count
FROM 
    Crew_Team CT
JOIN 
    Crew_Team_Members CTM ON CT.Crew_Team_ID = CTM.Crew_Team_ID
GROUP BY 
    CT.Crew_Name
ORDER BY 
    Astronaut_Count ;
  SELECT 
    R.Title AS Research_Title, 
    S.Name AS Researcher_Name
FROM 
    Research R, Staff S
WHERE 
    R.Researcher_ID = S.Staff_ID;

    SELECT 
    Research.Title AS Research_Title, 
    Staff.Name AS Researcher_Name, 
    Crew_Team.Crew_Name 
FROM 
    Research 
JOIN 
    Researcher ON Research.Researcher_ID = Researcher.Staff_ID 
JOIN 
    Staff ON Researcher.Staff_ID = Staff.Staff_ID 
LEFT JOIN 
    Crew_Team_Members ON Staff.Staff_ID = Crew_Team_Members.Astronaut_ID
LEFT JOIN 
    Crew_Team ON Crew_Team_Members.Crew_Team_ID = Crew_Team.Crew_Team_ID;

	SELECT Health_Status
FROM Medical_Record , Space_Mission
WHERE Doctor_ID = 5
  AND Medical_Record.Medical_ID IN (
    SELECT Medical_ID
    FROM Medical_Record
    WHERE Medical_Record.Medical_ID = Space_Mission.Mission_ID
    AND Space_Mission.Mission_ID = 1
  );

SELECT 
    Equipment.Equipment_Type, 
     
    (Equipment.Length * Equipment.Width * Equipment.Height) AS Volume,
    Space_Mission.Mission_ID
FROM Equipment
JOIN Space_Mission ON Equipment.Mission_ID = Space_Mission.Mission_ID;


SELECT Doctor_ID, COUNT(*) AS Number_of_Records
FROM Medical_Record
GROUP BY Doctor_ID;
 
SELECT Health_Status
FROM Medical_Record
WHERE Doctor_ID <26;






SELECT 
    S.Name AS Doctor_Name, 
    d.Medical_Specialty, 
    m.Health_Status, 
    m.Last_Checked_Date
FROM 
    Doctor d
LEFT JOIN 
    Medical_Record m ON d.Staff_ID = m.Doctor_ID
JOIN 
    Staff S ON d.Staff_ID = S.Staff_ID;