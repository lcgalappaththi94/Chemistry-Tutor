package com.codex.dialog.model;

public class Auther {
    private String authId;
    private String desig;
    private String email;
    private String password;
    private String name;

    public Auther(String authId, String desig, String email, String password, String name) {
        this.setAuthId(authId);
        this.setDesig(desig);
        this.setEmail(email);
        this.setPassword(password);
        this.setName(name);
    }

    public Auther() {
    }

    public String getAuthId() {
        return authId;
    }

    public void setAuthId(String authId) {
        this.authId = authId;
    }

    public String getDesig() {
        return desig;
    }

    public void setDesig(String desig) {
        this.desig = desig;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
