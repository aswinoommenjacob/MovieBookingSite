package com.movie.model;

import java.util.ArrayList;
import java.util.List;

public class Movie {
    private final int id;
    private final String title;
    private final String genre;
    private final int duration;
    private final double rating;
    private final String imageUrl;
    private List<Theater> theaters; // List of theaters where the movie is shown

    // Constructor
    public Movie(int id, String title, String genre, int duration, double rating, String imageUrl) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.rating = rating;
        this.imageUrl = imageUrl;
        this.theaters = new ArrayList<>();  // ✅ Initialize theaters list
    }

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getGenre() { return genre; }
    public int getDuration() { return duration; }
    public double getRating() { return rating; }
    public String getImageUrl() { return imageUrl; }
    public List<Theater> getTheaters() { return theaters; }

    // Setter for theaters list
    public void setTheaters(List<Theater> theaters) { 
        this.theaters = theaters; 
    }

    // ✅ Add a theater to the movie
    public void addTheater(Theater theater) {
        if (!theaters.contains(theater)) {
            theaters.add(theater);
        }
    }

    // ✅ Remove a theater from the movie
    public void removeTheater(Theater theater) {
        theaters.remove(theater);
    }

    // ✅ Display movie details
    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", genre='" + genre + '\'' +
                ", duration=" + duration +
                " mins, rating=" + rating +
                ", imageUrl='" + imageUrl + '\'' +
                ", theaters=" + theaters +
                '}';
    }
}
