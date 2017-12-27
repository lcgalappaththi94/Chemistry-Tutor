package com.codex.dialog.dao;

import com.codex.dialog.model.Answer;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public interface AnswerDAO {

    public ArrayList<Answer> getAnswers(String qNo) throws ClassNotFoundException, SQLException;

    public boolean updateAnswer(Answer answer) throws ClassNotFoundException, SQLException;
}
