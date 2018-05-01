package com.codex.dialog.controller;

import com.codex.dialog.dao.TopicDAO;
import com.codex.dialog.model.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;

@Controller
@RequestMapping("/")
public class TopicController {

    @Autowired
    TopicDAO topicDAO;

    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public String addTopic(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        Topic topic = new Topic("", request.getParameter("topic"));
        boolean isAdded = false;
        boolean isTopicExists = topicDAO.isTopic(topic.getTopic());
        if (!isTopicExists) {
            isAdded = topicDAO.addTopic(topic);
        }
        String msg;

        if (isAdded) {
            msg = "Added Successfully";
            return msg;
        } else if (isTopicExists) {
            msg = "That Topic already exists";
            return msg;
        } else {
            msg = "Failed To add";
            return msg;
        }
    }

    @RequestMapping(value = "check", method = RequestMethod.POST)
    @ResponseBody
    public String checkTopic(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        Topic topic = new Topic("", request.getParameter("topic"));
        boolean isTopicExists = topicDAO.isTopic(topic.getTopic());
        if (!isTopicExists) {
            return "1";
        }else{
            return "0";
        }

    }

    @RequestMapping(value = "allTopics", method = RequestMethod.GET)
    public void getAllTopics(HttpServletResponse resp) throws ClassNotFoundException, SQLException, IOException {
        ArrayList<Topic> topics = topicDAO.getTopics();
        String txt = "<select id=\"type\" class=\"form-control\" name=\"topic\" required>";
        for (Topic topic : topics) {
            if (topic.getTopic() != null) {
                txt += "<option>" + topic.getTopic() + "</option>";
            }
        }
        txt += "</select>";
        txt += "<a onclick=\"openPopAddTopic()\"><button type=\"button\" class=\"btn btn-primary\">Add New Topic</button></a>";
        PrintWriter out = resp.getWriter();
        out.print(txt);
        out.close();
    }

    @RequestMapping(value = "isTopic", method = RequestMethod.GET)
    public void topicValidation(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        PrintWriter out = response.getWriter();
        boolean isTopicExists = topicDAO.isTopic(request.getParameter("topic"));
        if (!isTopicExists) {
            out.print("1");
        } else {
            out.print("0");
        }
    }


}
