package com.codex.dialog.mapper;

import com.codex.dialog.model.Topic;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TopicMapper implements RowMapper<Topic> {

    @Override
    public Topic mapRow(ResultSet rs, int i) throws SQLException {
        Topic ques = new Topic("" + rs.getInt("topicId"), rs.getString("topic"));
        return ques;
    }
}
