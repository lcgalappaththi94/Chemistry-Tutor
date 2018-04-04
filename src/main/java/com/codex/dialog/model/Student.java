package com.codex.dialog.model;

public class Student {
    private String username;
    private String email;
    private String password;
    private String contactNo;
    private String score;
    private String login;

    public Student(String username, String email, String password, String contactNo, String score, String login) {
        this.setUsername(username);
        this.setEmail(email);
        this.setPassword(password);
        this.setContactNo(contactNo);
        this.setScore(score);
        this.setLogin(login);
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
}
