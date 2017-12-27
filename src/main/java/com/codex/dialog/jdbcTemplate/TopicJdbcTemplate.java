package com.codex.dialog.jdbcTemplate;

import com.codex.dialog.dao.TopicDAO;
import com.codex.dialog.mapper.TopicMapper;
import com.codex.dialog.model.Topic;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;

public class TopicJdbcTemplate implements TopicDAO {
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplateObject;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.jdbcTemplateObject = new JdbcTemplate(dataSource);
    }

    @Override
    public boolean addTopic(Topic topic) throws ClassNotFoundException, SQLException {
        String sql = "Insert into Topic (topic) values (?)";
        return (jdbcTemplateObject.update(sql, topic.getTopic())) > 0;

    }

    @Override
    public ArrayList<Topic> getTopics() throws ClassNotFoundException, SQLException {
        String sql = "select * from Topic";
        return (ArrayList<Topic>) jdbcTemplateObject.query(sql, new TopicMapper());
    }

    @Override
    public boolean isTopic(String topic) {
        String sql = "select * from Topic where topic = '" + topic + "' limit 1";
        Topic t;
        try {
            t = jdbcTemplateObject.queryForObject(sql, new TopicMapper());
            return true;
        } catch (EmptyResultDataAccessException ex) {
            return false;
        }
    }

    @Override
    public String getTopicByName(String name) throws ClassNotFoundException, SQLException {
        String sql = "select * from Topic where topic = ?";
        Topic topic;
        try {
            topic = jdbcTemplateObject.queryForObject(sql, new TopicMapper(), name);
            return topic.getTopicId();
        } catch (EmptyResultDataAccessException ex) {
            return "";
        }
    }
}
