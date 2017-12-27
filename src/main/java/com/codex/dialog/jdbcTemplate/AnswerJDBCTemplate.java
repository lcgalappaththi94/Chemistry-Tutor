package com.codex.dialog.jdbcTemplate;

import com.codex.dialog.dao.AnswerDAO;
import com.codex.dialog.mapper.AnswerMapper;
import com.codex.dialog.model.Answer;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;

public class AnswerJDBCTemplate implements AnswerDAO {

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    @Override
    public ArrayList<Answer> getAnswers(String qNo) throws ClassNotFoundException, SQLException {
        String sql = "select * from Answer where qNo = ?";
        ArrayList<Answer> answers;
        answers = (ArrayList<Answer>) jdbcTemplateObject.query(sql, new AnswerMapper(), qNo);
        return answers;
    }

    @Override
    public boolean updateAnswer(Answer answer) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE Answer SET answer= ? WHERE ansNo=? && qNo=? ";
        return (jdbcTemplateObject.update(sql, answer.getAnswer(), Integer.parseInt(answer.getAnsNo()), Integer.parseInt(answer.getQuestionNo())) > 0);
    }
}
