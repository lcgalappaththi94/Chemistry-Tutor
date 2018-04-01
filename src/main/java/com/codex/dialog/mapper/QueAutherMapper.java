package com.codex.dialog.mapper;

import com.codex.dialog.model.QueAuther;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QueAutherMapper implements RowMapper<QueAuther> {

    @Override
    public QueAuther mapRow(ResultSet rs, int i) throws SQLException {
        QueAuther ques = new QueAuther("" + rs.getInt("qNo"), "" + rs.getInt("authorId"),
                "" + rs.getInt("topicId"), rs.getString("question"),
                rs.getString("media"), rs.getString("corAnwrId"),
                rs.getString("difficulty"), rs.getString("name") ,
                rs.getString("destination"));
        return ques;
    }

}
