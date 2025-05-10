package com.movie.dao;

import com.movie.model.ShowTime;
import com.movie.model.Theater;
import com.movie.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TheaterDAO {
    private Connection con;

    public TheaterDAO(Connection con) {
        if (con == null) {
            System.err.println("Provided DB connection was null. Creating new connection from DBConnection.");
            this.con = DBConnection.getConnection();
        } else {
            this.con = con;
        }

        if (this.con == null) {
            throw new IllegalArgumentException("Database connection cannot be null.");
        }
    }

    public boolean addTheater(Theater theater) {
        String sql = "INSERT INTO theaters (name, location, location_url) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, theater.getName());
            stmt.setString(2, theater.getLocation());
            stmt.setString(3, theater.getLocationUrl());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    theater.setId(generatedKeys.getInt(1));
                }
                System.out.println("Theater inserted successfully!");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error inserting theater: " + e.getMessage());
        }
        return false;
    }

    public List<Theater> getAllTheaters() {
        List<Theater> theaters = new ArrayList<>();
        String sql = "SELECT * FROM theaters";

        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String location = rs.getString("location");
                String locationUrl = rs.getString("location_url");

                Theater theater = new Theater(id, name, location, locationUrl);
                theaters.add(theater);

                System.out.println("Retrieved Theater: " + theater.getId() + " - " + theater.getName());
            }

            System.out.println("Total Theaters Retrieved: " + theaters.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return theaters;
    }

    public Theater getTheaterById(int theaterId) {
        String sql = "SELECT * FROM theaters WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, theaterId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Theater theater = new Theater(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("location"),
                        rs.getString("location_url")
                );
                theater.setShowTimes(getShowTimesByTheaterId(theaterId));
                return theater;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private List<ShowTime> getShowTimesByTheaterId(int theaterId) {
        List<ShowTime> showTimes = new ArrayList<>();
        String sql = "SELECT * FROM movie_theater WHERE theater_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
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

    public boolean removeTheater(int theaterId) {
        String deleteShowTimesSQL = "DELETE FROM movie_theater WHERE theater_id = ?";
        String deleteTheaterSQL = "DELETE FROM theaters WHERE id = ?";

        try {
            con.setAutoCommit(false);

            try (PreparedStatement stmt = con.prepareStatement(deleteShowTimesSQL)) {
                stmt.setInt(1, theaterId);
                stmt.executeUpdate();
            }

            try (PreparedStatement stmt = con.prepareStatement(deleteTheaterSQL)) {
                stmt.setInt(1, theaterId);
                int rowsDeleted = stmt.executeUpdate();
                con.commit();
                return rowsDeleted > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                con.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        }
    }
}
