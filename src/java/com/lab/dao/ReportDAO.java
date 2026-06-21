package com.lab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportDAO {

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    // 1. Users Module: Role Distribution
    public Map<String, Integer> getUserRoleDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT role, COUNT(*) as count FROM users GROUP BY role";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                distribution.put(rs.getString("role"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // 1b. Users Module: Total User Count
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 2. Clubs Module: Summaries
    public List<Map<String, Object>> getClubSummaries() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT c.club_id, c.club_name, " +
                     "u_adv.full_name as advisor_name, " +
                     "u_chair.full_name as chairperson_name, " +
                     "(SELECT COUNT(*) FROM events e WHERE e.club_id = c.club_id) as total_events, " +
                     "(SELECT COUNT(*) FROM events e JOIN attendances a ON e.event_id = a.event_id WHERE e.club_id = c.club_id AND a.status = 'ATTENDED') as total_attendees " +
                     "FROM clubs c " +
                     "LEFT JOIN users u_adv ON c.advisor_id = u_adv.user_id " +
                     "LEFT JOIN users u_chair ON c.chairperson_id = u_chair.user_id " +
                     "ORDER BY total_events DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("clubId", rs.getInt("club_id"));
                map.put("clubName", rs.getString("club_name"));
                map.put("advisorName", rs.getString("advisor_name") != null ? rs.getString("advisor_name") : "Not Assigned");
                map.put("chairpersonName", rs.getString("chairperson_name") != null ? rs.getString("chairperson_name") : "Not Assigned");
                map.put("totalEvents", rs.getInt("total_events"));
                map.put("totalAttendees", rs.getInt("total_attendees"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Events Module: Status Distribution
    public Map<String, Integer> getEventStatusDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM events GROUP BY status";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                distribution.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // 3b. Events Module: Category Distribution
    public Map<String, Integer> getEventCategoryDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM events WHERE category IS NOT NULL AND category != '' GROUP BY category";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                distribution.put(rs.getString("category"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // 3c. Events Module: SDG Goals Distribution
    public Map<String, Integer> getEventSdgDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT sdg_goals FROM events WHERE sdg_goals IS NOT NULL AND sdg_goals != ''";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String sdgStr = rs.getString("sdg_goals");
                String[] goals = sdgStr.split(",");
                for (String goal : goals) {
                    String trimmed = goal.trim();
                    if (!trimmed.isEmpty()) {
                        distribution.put(trimmed, distribution.getOrDefault(trimmed, 0) + 1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // 3d. Events Module: Recent Events details
    public List<Map<String, Object>> getRecentEvents() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT e.event_id, e.event_name, e.date, e.time, e.end_time, e.venue, e.quota, e.status, e.category, c.club_name, " +
                     "(SELECT COUNT(*) FROM attendances a WHERE a.event_id = e.event_id) as registered_count, " +
                     "(SELECT COUNT(*) FROM attendances a WHERE a.event_id = e.event_id AND a.status = 'ATTENDED') as attended_count " +
                     "FROM events e " +
                     "JOIN clubs c ON e.club_id = c.club_id " +
                     "ORDER BY e.date DESC LIMIT 10";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("eventId", rs.getInt("event_id"));
                map.put("eventName", rs.getString("event_name"));
                map.put("date", rs.getDate("date"));
                map.put("time", rs.getTime("time"));
                map.put("endTime", rs.getTime("end_time"));
                map.put("venue", rs.getString("venue"));
                map.put("quota", rs.getInt("quota"));
                map.put("status", rs.getString("status"));
                map.put("category", rs.getString("category"));
                map.put("clubName", rs.getString("club_name"));
                map.put("registeredCount", rs.getInt("registered_count"));
                map.put("attendedCount", rs.getInt("attended_count"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Attendance Module: Status Distribution
    public Map<String, Integer> getAttendanceStatusDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM attendances GROUP BY status";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                distribution.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // 4b. Attendance Module: General stats
    public Map<String, Object> getGeneralAttendanceStats() {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT COUNT(*) as total_registrations, " +
                     "SUM(CASE WHEN status = 'ATTENDED' THEN 1 ELSE 0 END) as total_attended, " +
                     "SUM(CASE WHEN status = 'ABSENT' THEN 1 ELSE 0 END) as total_absent, " +
                     "SUM(CASE WHEN status = 'REGISTERED' THEN 1 ELSE 0 END) as total_pending " +
                     "FROM attendances";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalRegistrations", rs.getInt("total_registrations"));
                stats.put("totalAttended", rs.getInt("total_attended"));
                stats.put("totalAbsent", rs.getInt("total_absent"));
                stats.put("totalPending", rs.getInt("total_pending"));
            } else {
                stats.put("totalRegistrations", 0);
                stats.put("totalAttended", 0);
                stats.put("totalAbsent", 0);
                stats.put("totalPending", 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // 5. Merits Module: Stats
    public Map<String, Object> getMeritStats() {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT COUNT(*) as total_awarded, " +
                     "COALESCE(SUM(points), 0) as total_points, " +
                     "COALESCE(AVG(points), 0) as avg_points " +
                     "FROM merits";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalAwarded", rs.getInt("total_awarded"));
                stats.put("totalPoints", rs.getInt("total_points"));
                stats.put("avgPoints", rs.getDouble("avg_points"));
            } else {
                stats.put("totalAwarded", 0);
                stats.put("totalPoints", 0);
                stats.put("avgPoints", 0.0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // 5b. Merits Module: Top students
    public List<Map<String, Object>> getTopStudentsByMerit() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT u.user_id, u.full_name, u.email, COALESCE(SUM(m.points), 0) as total_merits " +
                     "FROM users u " +
                     "JOIN merits m ON u.user_id = m.user_id " +
                     "WHERE u.role = 'STUDENT' OR u.role = 'CHAIRPERSON' " +
                     "GROUP BY u.user_id, u.full_name, u.email " +
                     "ORDER BY total_merits DESC LIMIT 10";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("userId", rs.getInt("user_id"));
                map.put("fullName", rs.getString("full_name"));
                map.put("email", rs.getString("email"));
                map.put("totalMerits", rs.getInt("total_merits"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
