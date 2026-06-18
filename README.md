# EventZone [EZ]

<div align="justify">
EventZone is a web-based application developed to streamline the management and registration of student events within the Computer Science and Mathematics Faculty. 
  <br>
The system is designed to serve the various clubs operating under this faculty, addressing key inefficiencies found in traditional event management practices. 

These inefficiencies are low student participation, ghost registrations where students register but fail to attend, and overbooking where the number of registered participants exceeds the venue capacity.
</div>

## System Modules

| No | Module | Description | Type | Member |
|----|--------|-------------|------|--------|
| 1 | Manage Users | Handles user login and role-based access control for all four user types. Admin HEPA manages user profiles and role assignments. | — | Iqbal |
| 2 | Manage Clubs | Manages club creation, assignment of Club Advisors and Chairpersons, scoped to one faculty. | Core | Adly |
| 3 | Manage Events | Manages event creation including venue details, capacity control, registration approval/rejection, and auto-rejects new registrations when venue capacity is full. | — | Shukri *(Leader)* |
| 4 | View Events | Allows Students to browse and view event listings, details, venue, and registration status. Read-only access extending from Manage Events. | Extends M3 | Shukri |
| 5 | Manage Attendance | Handles student self-check-in, Chairperson verification, and attendance history tracking for HEPA and Advisors. | Core | Iqbal |
| 6 | Manage Merits | Admin HEPA calculates and assigns merit points to students based on attendance and event criteria. Includes merit summary management across all semesters. | — | Adly |
| 7 | View Merits | Allows Students to view merit point summaries, breakdown by event, and history across semesters. Read-only access extending from Manage Merits. | Extends M6 | Adly |
 
## User Roles
 
| Role | Description |
|------|-------------|
| Student | Browse events, self-check-in attendances, view own merits |
| Chairperson | Manage events, verify attendance |
| Advisor | Approve Events, View attendance history |
| Admin HEPA | Full access — manage users, clubs, events, merits |


## Group Members
| No. | Name | Matric No. |
| :---: | :--- | :---: |
| 1 | MUHAMMAD IQBAL HAIKAL BIN MOHD ZAFERI| S75635 |
| 2 | RAJA AHMAD SHUKRI BIN RAJA AHMAD KAHAR | S74644 |
| 3 | ADLY AZAMIN BIN AZMAN | S76094 |

## Tech Stack
* **Language:** Java (JDK 11+)
* **Architecture:** Servlets & JSP
* **Server:** Apache Tomcat 9
* **Database:** MySQL
* **Frontend Framework:** [Bootstrap 5](https://getbootstrap.com/)
* **Admin Template:** [Sneat 1.0.0 HTML5 Admin Template](https://themewagon.com/themes/free-responsive-bootstrap-5-html5-admin-template-sneat/)

## Getting Started

### Prerequisites
Before you begin, ensure you have the following installed:
* [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/downloads/)
* [Apache Tomcat](https://tomcat.apache.org/)
* [MySQL Server](https://dev.mysql.com/downloads/mysql/)
* Your preferred Java IDE (NetBeans, etc.)

## Installation & Setup
Open your terminal and run the following commands:
```bash
git clone https://github.com/sho-exe/eventzone-web.git
cd eventzone-web
