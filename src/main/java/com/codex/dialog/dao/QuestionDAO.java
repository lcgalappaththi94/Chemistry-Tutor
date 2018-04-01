package com.codex.dialog.dao;

import com.codex.dialog.model.Answer;
import com.codex.dialog.model.QueAuther;
import com.codex.dialog.model.Question;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public interface QuestionDAO {

    public boolean addQuestion(Question question, ArrayList<Answer> answers) throws ClassNotFoundException, SQLException;

    public String getLastQuesId() throws ClassNotFoundException, SQLException;

    public boolean updateQuestion(Question question) throws ClassNotFoundException, SQLException;

    public ArrayList<Question> getAllQuestions(String autherId, String topicId) throws ClassNotFoundException, SQLException;

    public ArrayList<Question> getAllQuestionsToAuther(String autherId) throws ClassNotFoundException, SQLException;

    public Question getAllQuestions_Topic(String quesId) throws ClassNotFoundException, SQLException;

    public ArrayList<QueAuther> getAllQuestions() throws ClassNotFoundException, SQLException;

    public Question getQuestion(String quesId) throws ClassNotFoundException, SQLException;

    public ArrayList<Question> getAllQuestions(String topicId) throws ClassNotFoundException, SQLException;

    public boolean deleteQuestion(String questionId) throws ClassNotFoundException, SQLException;

    public String get10Ques() throws ClassNotFoundException, SQLException;

    public String get20Ques() throws ClassNotFoundException, SQLException;

    public String get30Ques() throws ClassNotFoundException, SQLException;

    public String get40Ques() throws ClassNotFoundException, SQLException;

    public String get50Ques() throws ClassNotFoundException, SQLException;

    public String getVarQues(String quesNo, String username) throws ClassNotFoundException, SQLException;
}
