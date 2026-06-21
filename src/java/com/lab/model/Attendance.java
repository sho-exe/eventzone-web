package com.lab.model;

import java.sql.Timestamp;

public class Attendance {
    private int attendanceId;
    private int eventId;
    private int userId;
    private Timestamp registrationDate;
    private String status;
    private Integer verifiedBy;
    private String position;

    // View Mapping Properties - For Chairpersons
    private String studentName;
    private String studentEmail;
    private String verifierName;
    private String verifierRole;
    
    // View Mapping Properties - For Students
    private String eventName;
    private String clubName;
    private java.sql.Date eventDate;
    private java.sql.Time eventTime;
    private java.sql.Time eventEndTime;
    private String eventVenue;

    public Attendance() {}

    public int getAttendanceId() { return attendanceId; }
    public void setAttendanceId(int attendanceId) { this.attendanceId = attendanceId; }

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Timestamp getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Timestamp registrationDate) { this.registrationDate = registrationDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getVerifiedBy() { return verifiedBy; }
    public void setVerifiedBy(Integer verifiedBy) { this.verifiedBy = verifiedBy; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }

    public String getVerifierName() { return verifierName; }
    public void setVerifierName(String verifierName) { this.verifierName = verifierName; }

    public String getVerifierRole() { return verifierRole; }
    public void setVerifierRole(String verifierRole) { this.verifierRole = verifierRole; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }

    public java.sql.Date getEventDate() { return eventDate; }
    public void setEventDate(java.sql.Date eventDate) { this.eventDate = eventDate; }

    public java.sql.Time getEventTime() { return eventTime; }
    public void setEventTime(java.sql.Time eventTime) { this.eventTime = eventTime; }

    public java.sql.Time getEventEndTime() { return eventEndTime; }
    public void setEventEndTime(java.sql.Time eventEndTime) { this.eventEndTime = eventEndTime; }

    public String getEventVenue() { return eventVenue; }
    public void setEventVenue(String eventVenue) { this.eventVenue = eventVenue; }
}
