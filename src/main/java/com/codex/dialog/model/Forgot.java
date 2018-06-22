package com.codex.dialog.model;

import java.util.Date;

public class Forgot {
    private String userId;
    private String uuid;
    private Date timestamp;
    private boolean used;

    public Forgot(String userId, String uuid) {
        this.userId = userId;
        this.uuid = uuid;
        this.timestamp = new Date();
        this.used = false;
    }

    public Forgot(String userId, String uuid, Date timestamp, Boolean used) {
        this.userId = userId;
        this.uuid = uuid;
        this.timestamp = timestamp;
        this.used = used;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }
}
