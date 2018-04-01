package com.codex.dialog.model;

public class QueAuther {
    private String quesNo;
    private String authId;
    private String topicId;
    private String ques;
    private String media;
    private String corAnw;
    private String diff;
    private String autherName;
    private String desig;

    public QueAuther(String quesNo, String authId, String topicId, String ques, String media, String corAnw,
                     String diff, String autherName, String desig) {
        this.setQuesNo(quesNo);
        this.setAuthId(authId);
        this.setTopicId(topicId);
        this.setQues(ques);
        this.setMedia(media);
        this.setCorAnw(corAnw);
        this.setDiff(diff);
        this.setAutherName(autherName);
        this.setDesig(desig);
    }

    public QueAuther() {
    }


    public String getQuesNo() {
        return quesNo;
    }

    public void setQuesNo(String quesNo) {
        this.quesNo = quesNo;
    }

    public String getAuthId() {
        return authId;
    }

    public void setAuthId(String authId) {
        this.authId = authId;
    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public String getQues() {
        return ques;
    }

    public void setQues(String ques) {
        this.ques = ques;
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

    public String getAutherName() {
        return autherName;
    }

    public void setAutherName(String autherName) {
        this.autherName = autherName;
    }

    public String getDesig() {
        return desig;
    }

    public void setDesig(String desig) {
        this.desig = desig;
    }
}
