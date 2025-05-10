package com.movie.dao;

import com.movie.model.Movie;
import com.movie.model.Theater;
import com.movie.model.ShowTime;
import com.movie.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MovieDAO {
    private Connection con;

    // ✅ Default constructor
    public MovieDAO() {
        this.con = DBConnection.getConnection();
    }

    // ✅ Constructor with Connection
    public MovieDAO(Connection con) {
        this.con = con;
    }

    // ✅ Get all movies
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String query = "SELECT * FROM movies";

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Movie movie = new Movie(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("genre"),
                    rs.getInt("duration"),
                    rs.getDouble("rating"),
                    rs.getString("image_url")
                );
                movie.setTheaters(new ArrayList<>());
                movies.add(movie);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    // ✅ Add a new movie
    public void addMovie(String title, String genre, int duration, double rating, String imageUrl) {
        String query = "INSERT INTO movies (title, genre, duration, rating, image_url) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, title);
            ps.setString(2, genre);
            ps.setInt(3, duration);
            ps.setDouble(4, rating);
            ps.setString(5, imageUrl);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Remove a movie
    public void removeMovie(int id) {
        String query = "DELETE FROM movies WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Get movies with theaters and showtimes
    public List<Movie> getMoviesWithTheatersAndShowTimes() {
        List<Movie> movies = new ArrayList<>();
        Map<Integer, Movie> movieMap = new HashMap<>();

 String sql = "SELECT m.id, m.title, m.genre, m.duration, m.rating, m.image_url, " +
             "t.id AS theater_id, t.name AS theater_name, t.location, t.location_url, mt.show_time " +
             "FROM movies m " +
             "JOIN movie_theater mt ON m.id = mt.movie_id " +
             "JOIN theaters t ON mt.theater_id = t.id " +
             "ORDER BY m.id, t.id, mt.show_time";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int movieId = rs.getInt("id");
                Movie movie = movieMap.get(movieId);

                if (movie == null) {
                    movie = new Movie(
                        movieId,
                        rs.getString("title"),
                        rs.getString("genre"),
                        rs.getInt("duration"),
                        rs.getDouble("rating"),
                        rs.getString("image_url")
                    );
                    movie.setTheaters(new ArrayList<>());
                    movieMap.put(movieId, movie);
                    movies.add(movie);
                }

                int theaterId = rs.getInt("theater_id");
                Theater theater = movie.getTheaters().stream()
                    .filter(t -> t.getId() == theaterId)
                    .findFirst()
                    .orElse(null);

                if (theater == null) {
                    theater = new Theater(
    theaterId,
    rs.getString("theater_name"),
    rs.getString("location"),
    rs.getString("location_url") // ✅ make sure this column exists in your query!
);

                    theater.setShowTimes(new ArrayList<>());
                    movie.getTheaters().add(theater);
                }

                Timestamp showTime = rs.getTimestamp("show_time");

                // ✅ FIXED: Correct parameter types (int, int, Timestamp)
                theater.getShowTimes().add(new ShowTime(theaterId, movieId, showTime));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movies;
    }

    // ✅ Delete movie by ID
    public boolean deleteMovie(int movieId) {
        String query = "DELETE FROM movies WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, movieId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public Movie getMovieById(int movieId) {
    String sql = "SELECT * FROM movies WHERE id = ?";
    try (PreparedStatement stmt = con.prepareStatement(sql)) {
        stmt.setInt(1, movieId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new Movie(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("genre"),
                rs.getInt("duration"),
                rs.getDouble("rating"),
                rs.getString("image_url")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

}
