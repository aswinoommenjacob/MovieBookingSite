package com.movie.dao;

import com.movie.model.ShowTime;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShowTimeDAO {
    private Connection conn;

    public ShowTimeDAO(Connection conn) {
        this.conn = conn;
    }

    // Add a new show time
    public boolean addShowTime(ShowTime showTime) {
        String sql = "INSERT INTO movie_theater (theater_id, movie_id, show_time) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, showTime.getTheaterId());
            stmt.setInt(2, showTime.getMovieId());
            stmt.setTimestamp(3, showTime.getShowTime()); // Ensure show_time is a Timestamp
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Retrieve show times for a given theater
    public List<ShowTime> getShowTimesByTheater(int theaterId) {
        List<ShowTime> showTimes = new ArrayList<>();
        String sql = "SELECT * FROM movie_theater WHERE theater_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, theaterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                showTimes.add(new ShowTime(
                        rs.getInt("id"),
                        rs.getInt("theater_id"),
                        rs.getInt("movie_id"),
                        rs.getTimestamp("show_time")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showTimes;
    }

    // Retrieve show times for a given movie in a specific theater
    public List<ShowTime> getShowTimesByMovieAndTheater(int movieId, int theaterId) {
        List<ShowTime> showTimes = new ArrayList<>();
        String sql = "SELECT * FROM movie_theater WHERE movie_id = ? AND theater_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            stmt.setInt(2, theaterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                showTimes.add(new ShowTime(
                        rs.getInt("id"),
                        rs.getInt("theater_id"),
                        rs.getInt("movie_id"),
                        rs.getTimestamp("show_time")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showTimes;
    }

    // Remove a show time by ID
    public boolean removeShowTime(int showTimeId) {
        String sql = "DELETE FROM movie_theater WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, showTimeId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all showtimes with movie and theater names
    public List<Object[]> getAllShowtimesWithDetails() {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT m.title, t.name, s.show_time, s.id " +
                     "FROM movie_theater s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN theaters t ON s.theater_id = t.id";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getString("title");           // Movie title
                row[1] = rs.getString("name");            // Theater name
                row[2] = rs.getTimestamp("show_time");    // Timestamp is better than string
                row[3] = rs.getInt("id");                 // ShowTime ID
                list.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
