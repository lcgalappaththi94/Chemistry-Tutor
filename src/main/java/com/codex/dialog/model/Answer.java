package com.codex.dialog.model;

import org.springframework.stereotype.Service;

@Service
public class Answer {
    private String ansNo;
    private String questionNo;
    private String answer;

    public Answer() {
    }

    public Answer(String ansNo, String questionNo, String answer) {
        this.setAnsNo(ansNo);
        this.setQuestionNo(questionNo);
        this.setAnswer(answer);
    }


    public String getAnsNo() {
        return ansNo;
    }

    public void setAnsNo(String ansNo) {
        this.ansNo = ansNo;
    }

    public String getQuestionNo() {
        return questionNo;
    }

    public void setQuestionNo(String questionNo) {
        this.questionNo = questionNo;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
