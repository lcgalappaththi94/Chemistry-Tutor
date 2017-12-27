package com.codex.dialog.dao;

import com.codex.dialog.model.Topic;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public interface TopicDAO {

    public boolean addTopic(Topic topic) throws ClassNotFoundException, SQLException;

    public ArrayList<Topic> getTopics() throws ClassNotFoundException, SQLException;

    public boolean isTopic(String topic) throws ClassNotFoundException, SQLException;

    public String getTopicByName(String name) throws ClassNotFoundException, SQLException;
}
