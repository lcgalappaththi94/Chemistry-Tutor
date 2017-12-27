package com.codex.dialog.mapper;

import com.codex.dialog.model.Question;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QuestionMapper implements RowMapper<Question> {

    @Override
    public Question mapRow(ResultSet rs, int i) throws SQLException {
        Question ques = new Question("" + rs.getInt("qNo"), "" + rs.getInt("authorId"), "" + rs.getInt("topicId"), rs.getString("question"), rs.getString("media"), rs.getString("corAnwrId"), rs.getString("difficulty"));
        return ques;
    }
}

