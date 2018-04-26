package com.codex.dialog.model;

public class Leaderboard {
    private String username;
    private int score;
    private int rank;

    public Leaderboard() {
    }

    public Leaderboard(String username, int score, int rank) {
        this.setUsername(username);
        this.setScore(score);
        this.setRank(rank);
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
