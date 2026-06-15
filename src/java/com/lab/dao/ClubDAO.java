package com.lab.dao;

import com.lab.model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {

    // Helper to extract joined records safely
    private static final String SELECT_ALL_CLUBS = 
        "SELECT c.*, a.full_name AS advisor_name, ch.full_name AS chairperson_name " +
        "FROM clubs c " +
        "LEFT JOIN users a ON c.advisor_id = a.user_id " +
        "LEFT JOIN users ch ON c.chairperson_id = ch.user_id " +
        "ORDER BY c.club_name";
        
    private static final String SELECT_CLUBS_BY_ADVISOR =
        "SELECT c.*, a.full_name AS advisor_name, ch.full_name AS chairperson_name " +
        "FROM clubs c " +
        "LEFT JOIN users a ON c.advisor_id = a.user_id " +
        "LEFT JOIN users ch ON c.chairperson_id = ch.user_id " +
        "WHERE c.advisor_id = ? " +
        "ORDER BY c.club_name";
        
    private static final String SELECT_CLUB_BY_CHAIRPERSON =
        "SELECT c.*, a.full_name AS advisor_name, ch.full_name AS chairperson_name " +
        "FROM clubs c " +
        "LEFT JOIN users a ON c.advisor_id = a.user_id " +
        "LEFT JOIN users ch ON c.chairperson_id = ch.user_id " +
        "WHERE c.chairperson_id = ? LIMIT 1";
        
    private static final String INSERT_CLUB = "INSERT INTO clubs (club_name, description) VALUES (?, ?)";
    private static final String UPDATE_CLUB = "UPDATE clubs SET club_name = ?, description = ?, advisor_id = ?, chairperson_id = ? WHERE club_id = ?";
    private static final String DELETE_CLUB = "DELETE FROM clubs WHERE club_id = ?";
    private static final String SELECT_CLUB_BY_ID =
        "SELECT c.*, a.full_name AS advisor_name, ch.full_name AS chairperson_name " +
        "FROM clubs c " +
        "LEFT JOIN users a ON c.advisor_id = a.user_id " +
        "LEFT JOIN users ch ON c.chairperson_id = ch.user_id " +
        "WHERE c.club_id = ? LIMIT 1";

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    public List<Club> selectAllClubs() {
        return executeSelectQuery(SELECT_ALL_CLUBS, null);
    }

    public List<Club> selectClubsByAdvisor(int advisorId) {
        return executeSelectQuery(SELECT_CLUBS_BY_ADVISOR, advisorId);
    }

    private List<Club> executeSelectQuery(String query, Integer advisorId) {
        List<Club> clubs = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            if (advisorId != null) {
                preparedStatement.setInt(1, advisorId);
            }
            
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Club c = new Club();
                c.setClubId(rs.getInt("club_id"));
                c.setClubName(rs.getString("club_name"));
                c.setDescription(rs.getString("description"));
                
                c.setAdvisorId(rs.getObject("advisor_id") != null ? rs.getInt("advisor_id") : null);
                c.setChairpersonId(rs.getObject("chairperson_id") != null ? rs.getInt("chairperson_id") : null);
                
                c.setAdvisorName(rs.getString("advisor_name"));
                c.setChairpersonName(rs.getString("chairperson_name"));
                
                clubs.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public Club selectClubByChairperson(int chairpersonId) {
        Club c = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CLUB_BY_CHAIRPERSON)) {
            
            preparedStatement.setInt(1, chairpersonId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                c = new Club();
                c.setClubId(rs.getInt("club_id"));
                c.setClubName(rs.getString("club_name"));
                c.setDescription(rs.getString("description"));
                c.setAdvisorId(rs.getObject("advisor_id") != null ? rs.getInt("advisor_id") : null);
                c.setChairpersonId(rs.getObject("chairperson_id") != null ? rs.getInt("chairperson_id") : null);
                c.setAdvisorName(rs.getString("advisor_name"));
                c.setChairpersonName(rs.getString("chairperson_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public Club selectClubById(int clubId) {
        Club c = null;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_CLUB_BY_ID)) {
            ps.setInt(1, clubId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Club();
                c.setClubId(rs.getInt("club_id"));
                c.setClubName(rs.getString("club_name"));
                c.setDescription(rs.getString("description"));
                c.setAdvisorId(rs.getObject("advisor_id") != null ? rs.getInt("advisor_id") : null);
                c.setChairpersonId(rs.getObject("chairperson_id") != null ? rs.getInt("chairperson_id") : null);
                c.setAdvisorName(rs.getString("advisor_name"));
                c.setChairpersonName(rs.getString("chairperson_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public boolean insertClub(Club club) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CLUB)) {
            
            preparedStatement.setString(1, club.getClubName());
            preparedStatement.setString(2, club.getDescription());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public boolean updateClub(int clubId, String clubName, String description, Integer advisorId, Integer chairpersonId) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CLUB)) {
            
            preparedStatement.setString(1, clubName);
            preparedStatement.setString(2, description);
            
            if(advisorId != null && advisorId > 0) {
                preparedStatement.setInt(3, advisorId);
            } else {
                preparedStatement.setNull(3, java.sql.Types.INTEGER);
            }
            
            if(chairpersonId != null && chairpersonId > 0) {
                preparedStatement.setInt(4, chairpersonId);
            } else {
                preparedStatement.setNull(4, java.sql.Types.INTEGER);
            }
            
            preparedStatement.setInt(5, clubId);
            rowUpdated = preparedStatement.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Database Update Failed: " + e.getMessage());
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteClub(int clubId) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CLUB)) {
            
            preparedStatement.setInt(1, clubId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
