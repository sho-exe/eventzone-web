package com.lab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class MeritDAO {

    private static final String GET_ELIGIBLE_ATTENDEES = "SELECT user_id FROM attendances WHERE event_id = ? AND status = 'ATTENDED'";
    private static final String INSERT_MERIT = "INSERT INTO merits (user_id, event_id, points, awarded_date) VALUES (?, ?, ?, NOW())";
    private static final String CHECK_IF_DISTRIBUTED = "SELECT COUNT(*) FROM merits WHERE event_id = ?";
    private static final String SUM_TOTAL_MERITS = "SELECT SUM(points) FROM merits WHERE user_id = ?";

    private static final String ADVISOR_METRICS = "SELECT COUNT(DISTINCT m.event_id) as total_events, " +
            "COUNT(DISTINCT m.user_id) as total_students, " +
            "COALESCE(SUM(m.points), 0) as total_points " +
            "FROM merits m " +
            "JOIN events e ON m.event_id = e.event_id " +
            "JOIN clubs c ON e.club_id = c.club_id " +
            "WHERE c.advisor_id = ?";

    private static final String ADVISOR_TOP_STUDENTS = "SELECT u.full_name, u.email, SUM(m.points) as merits_earned " +
            "FROM merits m " +
            "JOIN events e ON m.event_id = e.event_id " +
            "JOIN clubs c ON e.club_id = c.club_id " +
            "JOIN users u ON m.user_id = u.user_id " +
            "WHERE c.advisor_id = ? " +
            "GROUP BY u.user_id, u.full_name, u.email " +
            "ORDER BY merits_earned DESC LIMIT 10";

    private static final String GET_MERIT_HISTORY_FOR_USER = "SELECT m.points, m.awarded_date, e.event_name, e.date, e.category "
            +
            "FROM merits m " +
            "JOIN events e ON m.event_id = e.event_id " +
            "WHERE m.user_id = ? " +
            "ORDER BY m.awarded_date DESC";

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    public boolean isDistributed(int eventId) {
        boolean distributed = false;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(CHECK_IF_DISTRIBUTED)) {

            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                distributed = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distributed;
    }

    public int getTotalMerits(int userId) {
        int total = 0;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SUM_TOTAL_MERITS)) {

            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int distributeMerits(int eventId, int points) {
        int eligibleCount = 0;
        int successCount = 0;

        try (Connection connection = getConnection()) {

            // 1. Gather all verified attendees
            List<Integer> attendees = new ArrayList<>();
            try (PreparedStatement ps1 = connection.prepareStatement(GET_ELIGIBLE_ATTENDEES)) {
                ps1.setInt(1, eventId);
                ResultSet rs = ps1.executeQuery();
                while (rs.next()) {
                    attendees.add(rs.getInt("user_id"));
                }
            }

            eligibleCount = attendees.size();

            // 2. Distribute points ignoring constraints silently if already awarded
            if (eligibleCount > 0) {
                try (PreparedStatement ps2 = connection.prepareStatement(INSERT_MERIT)) {
                    for (int userId : attendees) {
                        ps2.setInt(1, userId);
                        ps2.setInt(2, eventId);
                        ps2.setInt(3, points);

                        try {
                            if (ps2.executeUpdate() > 0) {
                                successCount++;
                            }
                        } catch (SQLException ex) {
                            // Fails silently if duplicate or constraint fails
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return successCount;
    }

    public Map<String, Integer> getAdvisorMetrics(int advisorId) {
        Map<String, Integer> metrics = new HashMap<>();
        metrics.put("totalEvents", 0);
        metrics.put("totalStudents", 0);
        metrics.put("totalPoints", 0);

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(ADVISOR_METRICS)) {

            preparedStatement.setInt(1, advisorId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                metrics.put("totalEvents", rs.getInt("total_events"));
                metrics.put("totalStudents", rs.getInt("total_students"));
                metrics.put("totalPoints", rs.getInt("total_points"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return metrics;
    }

    public List<Map<String, Object>> getTopStudentsForAdvisor(int advisorId) {
        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(ADVISOR_TOP_STUDENTS)) {

            preparedStatement.setInt(1, advisorId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("fullName", rs.getString("full_name"));
                map.put("email", rs.getString("email"));
                map.put("meritsEarned", rs.getInt("merits_earned"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getMeritHistoryForUser(int userId) {
        List<Map<String, Object>> history = new ArrayList<>();

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(GET_MERIT_HISTORY_FOR_USER)) {

            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("points", rs.getInt("points"));
                map.put("awardedDate", rs.getTimestamp("awarded_date"));
                map.put("eventName", rs.getString("event_name"));
                map.put("date", rs.getDate("date"));
                map.put("category", rs.getString("category"));
                history.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}
