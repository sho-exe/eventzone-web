package com.lab.model;

import java.sql.Date;

public class Event {
    private int eventId;
    private String eventName;
    private String description;
    private Date date;
    private java.sql.Time time;
    private java.sql.Time endTime;
    private String venue;
    private int quota;
    private String criteria;
    private int clubId;
    private String status;
    private String category;
    private String sdgGoals;
    private String image;

    // Helper specific to UI mapping
    private String clubName;
    private boolean alreadyRegistered;
    private int currentEnrollments;

    public Event() {}

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public java.sql.Time getTime() { return time; }
    public void setTime(java.sql.Time time) { this.time = time; }

    public java.sql.Time getEndTime() { return endTime; }
    public void setEndTime(java.sql.Time endTime) { this.endTime = endTime; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public int getQuota() { return quota; }
    public void setQuota(int quota) { this.quota = quota; }

    public String getCriteria() { return criteria; }
    public void setCriteria(String criteria) { this.criteria = criteria; }

    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSdgGoals() { return sdgGoals; }
    public void setSdgGoals(String sdgGoals) { this.sdgGoals = sdgGoals; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }

    public boolean isAlreadyRegistered() { return alreadyRegistered; }
    public void setAlreadyRegistered(boolean alreadyRegistered) { this.alreadyRegistered = alreadyRegistered; }

    public int getCurrentEnrollments() { return currentEnrollments; }
    public void setCurrentEnrollments(int currentEnrollments) { this.currentEnrollments = currentEnrollments; }
}
