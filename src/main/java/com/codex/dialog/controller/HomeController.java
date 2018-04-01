package com.codex.dialog.controller;

import com.codex.dialog.dao.QuestionDAO;
import com.codex.dialog.model.QueAuther;
import com.codex.dialog.model.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    QuestionDAO questionDAO;

    @RequestMapping(value = {"home", ""}, method = RequestMethod.GET)
    public String home(HttpServletRequest request) throws ClassNotFoundException, SQLException {
        return "Question/index";
    }

    @RequestMapping(value = "addQ", method = RequestMethod.GET)
    public String getQuestion(HttpServletRequest request) throws ClassNotFoundException, SQLException {
        return "Question/addQuestion";
    }

    @RequestMapping(value = "topic", method = RequestMethod.GET)
    public String addTopic() throws ClassNotFoundException, SQLException {
        return "Question/newTopic";
    }

    @RequestMapping(value = "editQues", method = RequestMethod.GET)
    public String editQuestion(HttpServletRequest request) throws ClassNotFoundException, SQLException {
        return "Question/editQues";
    }

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login(HttpServletRequest request) throws ClassNotFoundException, SQLException {
        return "Question/index";
    }

    @RequestMapping(value = "allQues", method = RequestMethod.GET)
    public String getAllQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        HttpSession session = request.getSession();
        String topicId = (String) session.getAttribute("topicId");
        String authId = (String) session.getAttribute("authId");

        try {
            if (authId.equals(null)) {
                return "";
            }

        } catch (NullPointerException ex) {
            return "";
        }
        ArrayList<QueAuther> questions = questionDAO.getAllQuestions();
        request.setAttribute("quesList", questions);
        return "Question/allQuestions";
    }

    @RequestMapping(value = "allQuesByMe", method = RequestMethod.GET)
    public String getAllQuesByMe(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        HttpSession session = request.getSession();
        String topicId = (String) session.getAttribute("topicId");
        String authId = (String) session.getAttribute("authId");

        try {
            if (authId.equals(null)) {
                return "";
            }

        } catch (NullPointerException ex) {
            return "";
        }
        ArrayList<Question> questions = questionDAO.getAllQuestionsToAuther(authId);
        request.setAttribute("quesList", questions);
        return "Question/allQuestionsByMe";
    }

    // Not implemented
    @RequestMapping(value = "allQuesToTopic", method = RequestMethod.GET)
    public String getAllQuesToTopic(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        return "";
    }

    @RequestMapping(value = "dash", method = RequestMethod.GET)
    public String dashBoard(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        return "Question/home";
    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        HttpSession session = request.getSession();
        session.removeAttribute("authId");
        session.removeAttribute("topicId");
        return "Question/index";
    }

}
