package com.codex.dialog.controller;

import com.codex.dialog.dao.AnswerDAO;
import com.codex.dialog.dao.QuestionDAO;
import com.codex.dialog.dao.TopicDAO;
import com.codex.dialog.model.Answer;
import com.codex.dialog.model.Question;
import com.codex.dialog.model.Topic;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.GsonBuilderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;

@Controller
@RequestMapping("/")
public class QuestionController {

    @Autowired
    QuestionDAO questionDAO;

    @Autowired
    AnswerDAO answerDAO;

    @Autowired
    TopicDAO topicDAO;

    @RequestMapping(value = "questionAdd", method = RequestMethod.POST)
    public String addQuestion(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String lQuesId = questionDAO.getLastQuesId();
        int nQuesId = Integer.parseInt(lQuesId) + 1;
        String topicId = topicDAO.getTopicByName(request.getParameter("topic"));
        String authId = (String) session.getAttribute("authId");
        try {
            if (authId.equals(null)) {
                return "";
            }

        } catch (NullPointerException ex) {
            return "";
        }

        String myparam = request.getParameter("ques");
        byte[] bytes = myparam.getBytes("UTF-8");

        System.out.println(new String(bytes, "UTF-8"));

        session.setAttribute(topicId, null);
        Question question = new Question("" + nQuesId, authId, topicId, request.getParameter("ques"), request.getParameter("media"), request.getParameter("corAnw"), request.getParameter("diff"));

        ArrayList<Answer> answers = new ArrayList<Answer>();
        for (int i = 1; i <= 5; i++) {
            Answer answer = new Answer("" + i, "" + nQuesId, request.getParameter("anw" + i));
            answers.add(answer);
        }
        String msg;
        if (questionDAO.addQuestion(question, answers)) {
            msg = "Added Successfully";
            request.setAttribute("msg", msg);
            return "Question/successHome";

        } else {
            msg = "Failed to add";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
    }

    @RequestMapping(value = "searchQues", method = RequestMethod.POST)
    public String searchQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Question question = questionDAO.getAllQuestions_Topic(request.getParameter("quesNo"));
        ArrayList answerList = answerDAO.getAnswers(request.getParameter("quesNo"));
        request.setAttribute("ques", question);
        request.setAttribute("anw", answerList);
        return "Question/editQues";
    }

    @RequestMapping(value = "viewQues", method = RequestMethod.POST)
    public String viewQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Question question = questionDAO.getAllQuestions_Topic(request.getParameter("quesNo"));
        ArrayList answerList = answerDAO.getAnswers(request.getParameter("quesNo"));
        request.setAttribute("ques", question);
        request.setAttribute("anw", answerList);
        return "Question/viewQuestions";
    }

    @RequestMapping(value = "updateQ", method = RequestMethod.POST)
    public String UpdateQuestion(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String authId = (String) session.getAttribute("authId");

        String topicId = topicDAO.getTopicByName(request.getParameter("topic"));
        System.out.println(request.getParameter("topic"));

        try {
            if (authId.equals(null)) {
                return "";
            }

        } catch (NullPointerException ex) {
            return "";
        }

        String myparam = request.getParameter("ques");
        String qNo = request.getParameter("qNo");

        Question question = new Question(qNo, authId, topicId, request.getParameter("ques"), request.getParameter("media"), request.getParameter("corAnw"), request.getParameter("diff"));

        ArrayList<Answer> answers = new ArrayList<Answer>();
        Answer answer;
        answer = new Answer(request.getParameter("anw1No"), qNo, request.getParameter("anw1"));
        answers.add(answer);

        answer = new Answer(request.getParameter("anw2No"), qNo, request.getParameter("anw2"));
        answers.add(answer);

        answer = new Answer(request.getParameter("anw3No"), qNo, request.getParameter("anw3"));
        answers.add(answer);

        answer = new Answer(request.getParameter("anw4No"), qNo, request.getParameter("anw4"));
        answers.add(answer);

        answer = new Answer(request.getParameter("anw5No"), qNo, request.getParameter("anw5"));
        answers.add(answer);

        boolean isAns = false;
        for (Answer answer1 : answers) {
            isAns = false;
            isAns = answerDAO.updateAnswer(answer1);
        }

        String msg;
        if (questionDAO.updateQuestion(question) && isAns) {
            msg = "updated Successfully";
            request.setAttribute("msg", msg);
            return "Question/successHome";
        } else {
            msg = "Failed to update";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
    }

    @RequestMapping(value = "deleteQues", method = RequestMethod.POST)
    public String deleteQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        String msg;
        if (questionDAO.deleteQuestion(request.getParameter("quesNo"))) {
            msg = "Added Successfully";
            request.setAttribute("msg", msg);
            return "Question/successHome";
        } else {
            msg = "Failed to add";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
    }

    @RequestMapping(value = "ques10", method = RequestMethod.GET)
    @ResponseBody
    public String get10Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get10Ques();
        return json;
    }

    @RequestMapping(value = "ques20", method = RequestMethod.GET)
    @ResponseBody
    public String get20Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get20Ques();
        return json;
    }
    @RequestMapping(value = "ques30", method = RequestMethod.GET)
    @ResponseBody
    public String get30Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get30Ques();
        return json;
    }
    @RequestMapping(value = "ques40", method = RequestMethod.GET)
    @ResponseBody
    public String get40Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get40Ques();
        return json;
    }

    @RequestMapping(value = "ques50", method = RequestMethod.GET)
    @ResponseBody
    public String get50Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get50Ques();
        return json;
    }

    /*@RequestMapping(value = "topic", method = RequestMethod.GET)
    public String addTopic(HttpServletRequest request) throws ClassNotFoundException, SQLException {
        return "Question/newTopic";
    }
*/
}
