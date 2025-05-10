package com.movie.model;

import java.util.List;

public class Theater {
    private int id;
    private String name;
    private String location;
    private String locationUrl; // ✅ New field
    private List<ShowTime> showTimes;

    // Constructor without ID (for adding new theaters)
    public Theater(String name, String location, String locationUrl) {
        this.name = name;
        this.location = location;
        this.locationUrl = locationUrl;
    }

    // Constructor with ID (for existing theaters)
    public Theater(int id, String name, String location, String locationUrl) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.locationUrl = locationUrl;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getLocationUrl() { return locationUrl; }
    public void setLocationUrl(String locationUrl) { this.locationUrl = locationUrl; }

    public List<ShowTime> getShowTimes() { return showTimes; }
    public void setShowTimes(List<ShowTime> showTimes) { this.showTimes = showTimes; }
}
