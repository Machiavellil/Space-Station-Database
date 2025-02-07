## MASA Space Y Database 
 
 ## Scope of the Space Station Database
 This database was primarily designed to manage vast amounts of scientific and operational data.
 It tracks the details of each mission and stores data on the spacecraft during these missions. Every 
 spaceship has a maintenance log supervised by an engineer. Every engineer also had technicians 
 assigned to him. There are training programs for astronauts going on a mission as well as some animals
 that are trained to go with these astronauts on missions. Astronauts and animals created the crew team 
 responsible for the mission. It also tracks the equipment used in these missions. Some doctors have 
 developed medical records for staff members. Experiments were conducted, and the research was 
 tracked for each experiment
--- 
##  Database Functionaliti
### Facilitates Training Program Tracking
- Tracks ongoing training programs.
- The **Training Program** entity records whether a program has started and who is participating.
- Every astronaut follows a specific program to qualify for a mission.
- Some animals undergo special training to accompany astronauts on missions.
- Allows monitoring of who has completed their program and who is still in progress.

### Facilitates Tracking the Spacecraft's Status
- Stores information about whether a spacecraft is mission-ready.
- Includes an entity for **Maintenance Logs**, providing a full overview of spacecraft status.
- Logs are supervised by specialized engineers.
- Engineers are assisted by technicians who conduct checkups and provide feedback on spacecraft status.

### Facilitates the Follow-Up of Research and Experiments
- Contains entities to track the progress of research and experiments.
- Each research and experiment is assigned a unique identifier from initiation.
- After research is completed, an experiment is conducted for validation.
- Ensures smooth implementation of experiments using the associated research data.

### Facilitates the Tracking of Medical Records
- Stores medical records and health status information for all staff members.
- Each staff member has a medical record from the time they are hired.
- Medical records are supervised by specialized doctors.
- Enables easy determination of any health concerns among staff members.

