package com.codex.dialog.model;

public class QueAnswer {
    private String quesiId;
    private String topicId;
    private String authId;
    private String anw1;
    private String anw2;
    private String anw3;
    private String anw4;
    private String anw5;
    private String media;
    private String corAnw;
    private String diff;

    public QueAnswer() {
    }

    public QueAnswer(String quesiId, String topicId, String authId, String anw1, String anw2, String anw3, String anw4, String anw5, String media, String corAnw, String diff) {
        this.setQuesiId(quesiId);
        this.setTopicId(topicId);
        this.setAuthId(authId);
        this.setAnw1(anw1);
        this.setAnw2(anw2);
        this.setAnw3(anw3);
        this.setAnw4(anw4);
        this.setAnw5(anw5);
        this.setMedia(media);
        this.setCorAnw(corAnw);
        this.setDiff(diff);
    }

    public String getQuesiId() {
        return quesiId;
    }

    public void setQuesiId(String quesiId) {
        this.quesiId = quesiId;
    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public String getAuthId() {
        return authId;
    }

    public void setAuthId(String authId) {
        this.authId = authId;
    }

    public String getAnw1() {
        return anw1;
    }

    public void setAnw1(String anw1) {
        this.anw1 = anw1;
    }

    public String getAnw2() {
        return anw2;
    }

    public void setAnw2(String anw2) {
        this.anw2 = anw2;
    }

    public String getAnw3() {
        return anw3;
    }

    public void setAnw3(String anw3) {
        this.anw3 = anw3;
    }

    public String getAnw4() {
        return anw4;
    }

    public String getAnw5() {
        return anw5;
    }

    public void setAnw5(String anw5) {
        this.anw5 = anw5;
    }

    public void setAnw4(String anw4) {
        this.anw4 = anw4;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getCorAnw() {
        return corAnw;
    }

    public void setCorAnw(String corAnw) {
        this.corAnw = corAnw;
    }

    public String getDiff() {
        return diff;
    }

    public void setDiff(String diff) {
        this.diff = diff;
    }
}
