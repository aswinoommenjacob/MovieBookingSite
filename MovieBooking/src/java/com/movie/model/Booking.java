package com.movie.model;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int movieId;
    private String seatNo;
    private Timestamp bookingDate;
    private int theaterId;   // New field
    private int showtimeId;  // New field

    // Constructor with theaterId and showtimeId
    public Booking(int id, int userId, int movieId, String seatNo, Timestamp bookingDate, int theaterId, int showtimeId) {
        this.id = id;
        this.userId = userId;
        this.movieId = movieId;
        this.seatNo = seatNo;
        this.bookingDate = bookingDate;
        this.theaterId = theaterId;
        this.showtimeId = showtimeId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public String getSeatNo() {
        return seatNo;
    }

    public void setSeatNo(String seatNo) {
        this.seatNo = seatNo;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getTheaterId() {
        return theaterId;
    }

    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }
}
