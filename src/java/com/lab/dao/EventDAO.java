package com.lab.dao;

import com.lab.model.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    private static final String SELECT_EVENTS_BY_CLUB
            = "SELECT e.*, c.club_name FROM events e "
            + "JOIN clubs c ON e.club_id = c.club_id "
            + "WHERE e.club_id = ? ORDER BY e.date DESC";

    private static final String SELECT_ALL_EVENTS
            = "SELECT e.*, c.club_name FROM events e "
            + "JOIN clubs c ON e.club_id = c.club_id "
            + "ORDER BY e.status = 'PENDING' DESC, e.date DESC";

    private static final String SELECT_APPROVED_EVENTS
            = "SELECT e.*, c.club_name FROM events e "
            + "JOIN clubs c ON e.club_id = c.club_id "
            + "WHERE e.status = 'APPROVED' ORDER BY e.date ASC";

    private static final String SELECT_PENDING_EVENTS_BY_ADVISOR
            = "SELECT e.*, c.club_name FROM events e "
            + "JOIN clubs c ON e.club_id = c.club_id "
            + "WHERE c.advisor_id = ? AND e.status = 'PENDING' ORDER BY e.date ASC";

    private static final String SELECT_ALL_EVENTS_BY_ADVISOR
            = "SELECT e.*, c.club_name FROM events e "
            + "JOIN clubs c ON e.club_id = c.club_id "
            + "WHERE c.advisor_id = ? ORDER BY e.date DESC";

    private static final String INSERT_EVENT
            = "INSERT INTO events (event_name, description, date, venue, quota, criteria, club_id, status, category) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING', ?)";

    private static final String UPDATE_EVENT_STATUS
            = "UPDATE events SET status = ? WHERE event_id = ?";

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    public List<Event> selectEventsByClub(int clubId) {
        List<Event> events = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EVENTS_BY_CLUB)) {

            preparedStatement.setInt(1, clubId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getDate("date"));
                e.setVenue(rs.getString("venue"));
                e.setQuota(rs.getInt("quota"));
                e.setCriteria(rs.getString("criteria"));
                e.setClubId(rs.getInt("club_id"));
                e.setStatus(rs.getString("status"));
                e.setCategory(rs.getString("category"));
                e.setClubName(rs.getString("club_name"));
                events.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> selectAllEvents() {
        List<Event> events = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EVENTS)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getDate("date"));
                e.setVenue(rs.getString("venue"));
                e.setQuota(rs.getInt("quota"));
                e.setCriteria(rs.getString("criteria"));
                e.setCategory(rs.getString("category"));

                e.setClubId(rs.getInt("club_id"));
                e.setStatus(rs.getString("status"));
                e.setClubName(rs.getString("club_name"));
                events.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> selectApprovedEvents() {
        List<Event> events = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_APPROVED_EVENTS)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getDate("date"));
                e.setVenue(rs.getString("venue"));
                e.setQuota(rs.getInt("quota"));
                e.setCriteria(rs.getString("criteria"));
                e.setClubId(rs.getInt("club_id"));
                e.setStatus(rs.getString("status"));
                e.setClubName(rs.getString("club_name"));
                events.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> selectPendingEventsByAdvisor(int advisorId) {
        List<Event> events = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PENDING_EVENTS_BY_ADVISOR)) {

            preparedStatement.setInt(1, advisorId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getDate("date"));
                e.setVenue(rs.getString("venue"));
                e.setQuota(rs.getInt("quota"));
                e.setCriteria(rs.getString("criteria"));
                e.setClubId(rs.getInt("club_id"));
                e.setStatus(rs.getString("status"));
                e.setCategory(rs.getString("category"));
                e.setClubName(rs.getString("club_name"));
                events.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> selectAllEventsByAdvisor(int advisorId) {
        List<Event> events = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EVENTS_BY_ADVISOR)) {

            preparedStatement.setInt(1, advisorId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setEventName(rs.getString("event_name"));
                e.setDescription(rs.getString("description"));
                e.setDate(rs.getDate("date"));
                e.setVenue(rs.getString("venue"));
                e.setQuota(rs.getInt("quota"));
                e.setCriteria(rs.getString("criteria"));
                e.setClubId(rs.getInt("club_id"));
                e.setStatus(rs.getString("status"));
                e.setCategory(rs.getString("category"));
                e.setClubName(rs.getString("club_name"));
                events.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public boolean insertEvent(Event e) {
        boolean rowInserted = false;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EVENT)) {

            preparedStatement.setString(1, e.getEventName());
            preparedStatement.setString(2, e.getDescription());
            preparedStatement.setDate(3, e.getDate());
            preparedStatement.setString(4, e.getVenue());
            preparedStatement.setInt(5, e.getQuota());
            preparedStatement.setString(6, e.getCriteria());
            preparedStatement.setInt(7, e.getClubId());
            preparedStatement.setString(8, e.getCategory());

            rowInserted = preparedStatement.executeUpdate() > 0;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rowInserted;
    }

    public boolean updateEventStatus(int eventId, String status) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_EVENT_STATUS)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, eventId);
            rowUpdated = preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
}
