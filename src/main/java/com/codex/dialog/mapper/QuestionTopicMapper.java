package com.codex.dialog.mapper;

import com.codex.dialog.model.Question;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QuestionTopicMapper implements RowMapper<Question> {

    @Override
    public Question mapRow(ResultSet rs, int i) throws SQLException {
        Question ques = new Question("" + rs.getInt("qNo"), "" + rs.getInt("authorId"),
                rs.getString("topic"), rs.getString("question"), rs.getString("media"),
                rs.getString("corAnwrId"), rs.getString("difficulty"),
                rs.getString("ex"), rs.getString("exImage"), rs.getString("exVed"),
                rs.getString("ref"));
        return ques;
    }
}
