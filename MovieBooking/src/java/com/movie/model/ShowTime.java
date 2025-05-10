package com.movie.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ShowTime {
    private int id;
    private int theaterId;
    private int movieId;
    private Timestamp showTime;

    // Constructor for creating new ShowTime objects
    public ShowTime(int theaterId, int movieId, Timestamp showTime) {
        this.theaterId = theaterId;
        this.movieId = movieId;
        this.showTime = showTime;
    }

    // Constructor for retrieving from DB (with ID)
    public ShowTime(int id, int theaterId, int movieId, Timestamp showTime) {
        this.id = id;
        this.theaterId = theaterId;
        this.movieId = movieId;
        this.showTime = showTime;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTheaterId() { return theaterId; }
    public void setTheaterId(int theaterId) { this.theaterId = theaterId; }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public Timestamp getShowTime() { return showTime; }
    public void setShowTime(Timestamp showTime) { this.showTime = showTime; }

    // ✅ Add this method to format showTime properly
    public String getFormattedShowTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        return sdf.format(showTime);
    }
}
