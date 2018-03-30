package com.codex.dialog.jdbcTemplate;

import com.codex.dialog.dao.QuestionDAO;
import com.codex.dialog.mapper.AnswerMapper;
import com.codex.dialog.mapper.QuestionMapper;
import com.codex.dialog.mapper.QuestionTopicMapper;
import com.codex.dialog.model.Answer;
import com.codex.dialog.model.Question;
import com.google.gson.Gson;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;

public class QuestionJDBCTemplate implements QuestionDAO {

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    public boolean addQuestion(Question question, ArrayList<Answer> answers) throws ClassNotFoundException, SQLException {
        String sql = "Insert into Question (qNo,topicId,authorId,question,corAnwrId,difficulty,media) values ( ? , ? , ? , ? , ? ,? ,?)";
        boolean isAns = false;
        boolean isQues = jdbcTemplateObject.update(sql, question.getQuesNo(), question.getTopicId(), question.getAuthId(), question.getQues(), question.getCorAnw(), question.getDiff(), question.getMedia()) > 0;
        for (Answer answer : answers) {
            isAns = false;
            String sql2 = "Insert into Answer values ( ? , ? , ?)";
            isAns = jdbcTemplateObject.update(sql2, answer.getAnsNo(), answer.getQuestionNo(), answer.getAnswer()) > 0;
        }
        System.out.println(question.getQues());
        return isQues && isAns;
    }

    @Override
    public String getLastQuesId() throws ClassNotFoundException, SQLException {
        String sql = "select * from Question order by 1 desc limit 1";
        Question question;
        try {
            question = jdbcTemplateObject.queryForObject(sql, new QuestionMapper());
            return question.getQuesNo();
        } catch (EmptyResultDataAccessException ex) {
            return "0";
        }
    }

    @Override
    public boolean updateQuestion(Question question) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Question SET question= ?,topicId=?,corAnwrId=?,difficulty=?,media=?  WHERE qNo=?";
        return (jdbcTemplateObject.update(sql, question.getQues(), Integer.parseInt(question.getTopicId()), Integer.parseInt(question.getCorAnw()), question.getDiff(), question.getMedia(), Integer.parseInt(question.getQuesNo())) > 0);
    }

    @Override
    public Question getQuestion(String quesNo) throws ClassNotFoundException, SQLException {
        String sql = "select * from Question where qNo = ?";
        Question question;
        question = jdbcTemplateObject.queryForObject(sql, new QuestionMapper(), quesNo);
        return question;

    }

    @Override
    public ArrayList<Question> getAllQuestions(String autherId, String topicId) throws ClassNotFoundException, SQLException {
        String sql = "select * from Question where authorId = ? && topicId=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper(), autherId, topicId);
        return questions;
    }

    @Override
    public Question getAllQuestions_Topic(String qNo) throws ClassNotFoundException, SQLException {
        String sql = "select qNo,authorId,topic,question,media,corAnwrId,difficulty from Question q,Topic t where q.topicId=t.topicId  && qNo=?";
        Question question;
        question = jdbcTemplateObject.queryForObject(sql, new QuestionTopicMapper(), qNo);
        return question;
    }

    @Override
    public ArrayList<Question> getAllQuestions(String topicId) throws ClassNotFoundException, SQLException {
        String sql = "select * from Question where topicId=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper(), topicId);
        return questions;
    }

    @Override
    public boolean deleteQuestion(String questionId) throws ClassNotFoundException, SQLException {
        System.out.println(questionId);
        String sql = "Delete from Question Where qNo=?";
        return jdbcTemplateObject.update(sql, questionId) > 0;
    }

    @Override
    public ArrayList<Question> getAllQuestionsToAuther(String autherId) throws ClassNotFoundException, SQLException {
        String sql = "select * from Question where authorId = ?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper(), autherId);
        return questions;
    }

    @Override
    public String get10Ques() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `Question` ORDER BY RAND() LIMIT 10";
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper());

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;
        return finalString;
    }

    @Override
    public String get20Ques() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `Question` ORDER BY RAND() LIMIT 20";
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper());

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;
        return finalString;
    }

    @Override
    public String get30Ques() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `Question` ORDER BY RAND() LIMIT 30";
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper());

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;

        return finalString;
    }

    @Override
    public String get40Ques() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `Question` ORDER BY RAND() LIMIT 40";
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper());

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;

        return finalString;
    }

    @Override
    public String get50Ques() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `Question` ORDER BY RAND() LIMIT 50";
        //SELECT * FROM Question WHERE qNo NOT in (SELECT qNo FROM DoneQuestion WHERE username=2) ORDER BY RAND() LIMIT 50
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper());

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;

        return finalString;
    }

    @Override
    public String getVarQues(String quesNo, String username) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM Question WHERE qNo NOT in (SELECT qNo FROM DoneQuestion WHERE username=?) ORDER BY RAND() LIMIT " + quesNo;
        //SELECT * FROM Question WHERE qNo NOT in (SELECT qNo FROM DoneQuestion WHERE username=2) ORDER BY RAND() LIMIT 50
        String sql1 = "SELECT * FROM `Answer` WHERE qNo=?";
        ArrayList<Question> questions;
        questions = (ArrayList<Question>) jdbcTemplateObject.query(sql, new QuestionMapper(), username);

        ArrayList<Answer> allAnswers = new ArrayList<>();
        for (Question q:questions) {
            ArrayList<Answer> answersToQue = (ArrayList<Answer>) jdbcTemplateObject.query(sql1, new AnswerMapper(),q.getQuesNo());
            allAnswers.addAll(answersToQue);
        }

        Gson gson = new Gson();
        String json1 = gson.toJson(questions);
        String json2 = gson.toJson(allAnswers);
        String finalString = json1 +"@"+json2;

        return finalString;
    }
}
