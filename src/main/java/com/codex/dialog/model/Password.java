package com.codex.dialog.model;

public class Password {

    private String password;
    private String newPassword;
    private String authId;

    public Password(String password, String newPassword, String authId) {
        this.password = password;
        this.newPassword = newPassword;
        this.setAuthId(authId);
    }

    public Password() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getAuthId() {
        return authId;
    }

    public void setAuthId(String authId) {
        this.authId = authId;
    }
}
