package com.codex.dialog.model;

import org.springframework.stereotype.Service;

@Service
public class Question {
    private String quesNo;
    private String authId;
    private String topicId;
    private String ques;
    private String media;
    private String corAnw;
    private String diff;
    private String ex;
    private String exImage;
    private String exVed;
    private String ref;

    public Question() {
    }

    public Question(String quesNo, String authId, String topicId, String ques, String media,
                    String corAnw, String diff, String ex, String exImage, String exVed, String ref) {
        this.setQuesNo(quesNo);
        this.setAuthId(authId);
        this.setTopicId(topicId);
        this.setQues(ques);
        this.setMedia(media);
        this.setCorAnw(corAnw);
        this.setDiff(diff);
        this.setEx(ex);
        this.setExImage(exImage);
        this.setExVed(exVed);
        this.setRef(ref);
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

    public String getEx() {
        return ex;
    }

    public void setEx(String ex) {
        this.ex = ex;
    }

    public String getExImage() {
        return exImage;
    }

    public void setExImage(String exImage) {
        this.exImage = exImage;
    }

    public String getExVed() {
        return exVed;
    }

    public void setExVed(String exVed) {
        this.exVed = exVed;
    }

    public String getRef() {
        return ref;
    }

    public void setRef(String ref) {
        this.ref = ref;
    }
}
