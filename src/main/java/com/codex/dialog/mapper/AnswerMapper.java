package com.codex.dialog.mapper;

import com.codex.dialog.model.Answer;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AnswerMapper implements RowMapper<Answer> {

    @Override
    public Answer mapRow(ResultSet rs, int i) throws SQLException {
        Answer answer = new Answer("" + rs.getInt("ansNo"), "" + rs.getInt("qNo"), rs.getString("answer"));
        return answer;
    }
}
