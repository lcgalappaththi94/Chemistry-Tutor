package com.codex.dialog.controller;

import com.codex.dialog.dao.TopicDAO;
import com.codex.dialog.model.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
    public String addQuestion(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        Topic topic = new Topic("", request.getParameter("topic"));
        boolean isAdded = false;
        boolean isTopicExists = topicDAO.isTopic(topic.getTopic());
        if (!isTopicExists) {
            isAdded = topicDAO.addTopic(topic);
        }

        if (isAdded) {
            String msg = "Added Successfully";
            request.setAttribute("msg", msg);
            return "Question/successHome";
        } else if (isTopicExists) {
            String msg = "That Topic already exists";
            request.setAttribute("msg", msg);
        } else {
            String msg = "Failed To add";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
        return "success";
    }

    @RequestMapping(value = "allTopics", method = RequestMethod.GET)
    public void getAllTopics(HttpServletResponse resp) throws ClassNotFoundException, SQLException, IOException {
        ArrayList<Topic> topics = topicDAO.getTopics();
        String txt = "<select id=\"type\" class=\"form-control\" name=\"topic\" required>";
        for (Topic topic : topics) {
            if (topic.getTopic() != null){
                txt += "<option>" + topic.getTopic() + "</option>";
            }
        }
        txt += "</select>";
        txt += "<a href=\"topic\">Add New Topic</a>";
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
