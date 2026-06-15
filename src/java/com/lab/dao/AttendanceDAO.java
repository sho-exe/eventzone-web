package com.lab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AttendanceDAO {
    
    // Adapted from previous Registration logic to use a unified `attendance` table mapped precisely to custom schema
    private static final String INSERT_ATTENDANCE = "INSERT INTO attendances (event_id, user_id, registration_date, status) VALUES (?, ?, NOW(), 'PENDING')";
    private static final String INSERT_CHAIRPERSON_ATTENDANCE = 
        "INSERT IGNORE INTO attendances (event_id, user_id, registration_date, status, position) " +
        "VALUES (?, ?, NOW(), 'ATTENDED', 'Presiden Kelab')";
    private static final String CHECK_IF_REGISTERED = "SELECT COUNT(*) FROM attendances WHERE event_id = ? AND user_id = ?";
    private static final String COUNT_REGISTRATIONS_FOR_EVENT = "SELECT COUNT(*) FROM attendances WHERE event_id = ?";
    
    private static final String SELECT_ATTENDANCES_BY_EVENT = 
        "SELECT a.*, u.full_name, u.email, v.full_name AS verifier_name, v.role AS verifier_role " +
        "FROM attendances a " +
        "JOIN users u ON a.user_id = u.user_id " +
        "LEFT JOIN users v ON a.verified_by = v.user_id " +
        "WHERE a.event_id = ? ORDER BY a.registration_date DESC";

    private static final String UPDATE_ATTENDANCE_STATUS = 
        "UPDATE attendances SET status = ?, verified_by = ? WHERE attendance_id = ?";
        
    private static final String SELECT_STUDENT_REGISTRATIONS = 
        "SELECT a.*, e.event_name, e.date AS event_date, e.venue AS event_venue, c.club_name " +
        "FROM attendances a " +
        "JOIN events e ON a.event_id = e.event_id " +
        "JOIN clubs c ON e.club_id = c.club_id " +
        "WHERE a.user_id = ? ORDER BY a.registration_date DESC";

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    public boolean registerStudent(int eventId, int userId) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ATTENDANCE)) {
            
            preparedStatement.setInt(1, eventId);
            preparedStatement.setInt(2, userId);
            rowInserted = preparedStatement.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            // Fails silently if duplicate or constraint fails
            ex.printStackTrace();
        }
        return rowInserted;
    }

    public boolean registerChairpersonAsParticipant(int eventId, int chairpersonId) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_CHAIRPERSON_ATTENDANCE)) {
            ps.setInt(1, eventId);
            ps.setInt(2, chairpersonId);
            rowInserted = ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rowInserted;
    }

    public boolean isStudentRegistered(int eventId, int userId) {
        boolean isRegistered = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_IF_REGISTERED)) {
            
            preparedStatement.setInt(1, eventId);
            preparedStatement.setInt(2, userId);
            
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                isRegistered = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isRegistered;
    }

    public int getEnrollmentCount(int eventId) {
        int count = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_REGISTRATIONS_FOR_EVENT)) {
            
            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public java.util.List<com.lab.model.Attendance> getAttendancesForEvent(int eventId) {
        java.util.List<com.lab.model.Attendance> list = new java.util.ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ATTENDANCES_BY_EVENT)) {
            
            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()) {
                com.lab.model.Attendance a = new com.lab.model.Attendance();
                a.setAttendanceId(rs.getInt("attendance_id"));
                a.setEventId(rs.getInt("event_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setRegistrationDate(rs.getTimestamp("registration_date"));
                a.setStatus(rs.getString("status"));
                Object vb = rs.getObject("verified_by");
                if(vb != null) a.setVerifiedBy(rs.getInt("verified_by"));
                
                a.setStudentName(rs.getString("full_name"));
                a.setStudentEmail(rs.getString("email"));
                a.setVerifierName(rs.getString("verifier_name"));
                a.setVerifierRole(rs.getString("verifier_role"));
                a.setPosition(rs.getString("position"));
                list.add(a);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateAttendanceStatus(int attendanceId, String status, int verifiedBy) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ATTENDANCE_STATUS)) {
            
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, verifiedBy);
            preparedStatement.setInt(3, attendanceId);
            rowUpdated = preparedStatement.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    private static final String UPDATE_ATTENDANCE_POSITION = "UPDATE attendances SET position = ? WHERE attendance_id = ?";
    
    public boolean updateAttendancePosition(int attendanceId, String position) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ATTENDANCE_POSITION)) {
            preparedStatement.setString(1, position);
            preparedStatement.setInt(2, attendanceId);
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public java.util.List<com.lab.model.Attendance> getStudentRegistrations(int userId) {
        java.util.List<com.lab.model.Attendance> list = new java.util.ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_REGISTRATIONS)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()) {
                com.lab.model.Attendance a = new com.lab.model.Attendance();
                a.setAttendanceId(rs.getInt("attendance_id"));
                a.setEventId(rs.getInt("event_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setRegistrationDate(rs.getTimestamp("registration_date"));
                a.setStatus(rs.getString("status"));
                
                a.setEventName(rs.getString("event_name"));
                a.setEventDate(rs.getDate("event_date"));
                a.setEventVenue(rs.getString("event_venue"));
                a.setClubName(rs.getString("club_name"));
                a.setPosition(rs.getString("position"));
                list.add(a);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
