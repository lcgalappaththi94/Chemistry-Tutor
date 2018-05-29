package com.codex.dialog.controller;

import com.codex.dialog.dao.AnswerDAO;
import com.codex.dialog.dao.QuestionDAO;
import com.codex.dialog.dao.TopicDAO;
import com.codex.dialog.model.Answer;
import com.codex.dialog.model.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

        session.setAttribute(topicId, null);
        Question question = new Question("" + nQuesId, authId, topicId, request.getParameter("ques"),
                request.getParameter("media"), request.getParameter("corAnw"), request.getParameter("diff"),
                request.getParameter("ex"), request.getParameter("exImage"), request.getParameter("exVed"),
                request.getParameter("ref"));

        ArrayList<Answer> answers = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            Answer answer = new Answer("" + i, "" + nQuesId, request.getParameter("anw" + i));
            answers.add(answer);
        }
        String msg;
        if (questionDAO.addQuestion(question, answers)) {
            msg = "Question Added Successfully";
        } else {
            msg = "Failed to add";
        }
        request.setAttribute("msg", msg);
        return "Question/home";
    }

    @RequestMapping(value = "searchQues", method = RequestMethod.POST)
    public String searchQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Question question = questionDAO.getAllQuestions_Topic(request.getParameter("quesNo"));
        ArrayList answerList = answerDAO.getAnswers(request.getParameter("quesNo"));
        int length = Integer.parseInt(request.getParameter("length"));
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int allQuestions = Integer.parseInt(request.getParameter("allQuestions"));


        request.setAttribute("ques", question);
        request.setAttribute("anw", answerList);
        request.setAttribute("length", length);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("allQuestions", allQuestions);
        return "Question/editQues";
    }

    @RequestMapping(value = "viewQues", method = RequestMethod.POST)
    public String viewQues(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        String questionNumber = request.getParameter("quesNo");
        Question question = questionDAO.getAllQuestions_Topic(questionNumber);
        ArrayList answerList = answerDAO.getAnswers(questionNumber);
        request.setAttribute("ques", question);
        request.setAttribute("anw", answerList);
        return "Question/viewQuestions";
    }

    @RequestMapping(value = "updateQ", method = RequestMethod.POST)
    public String UpdateQuestion(HttpServletRequest request, ModelMap model) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String authId = (String) session.getAttribute("authId");
        int allQuestions = Integer.parseInt(request.getParameter("allQuestions"));

        int length = Integer.parseInt(request.getParameter("length"));
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        model.addAttribute("length", length);
        model.addAttribute("currentPage", currentPage);

        String topicId = topicDAO.getTopicByName(request.getParameter("topic"));

        try {
            if (authId.equals(null)) {
                return "";
            }

        } catch (NullPointerException ex) {
            return "";
        }
        String myparam = request.getParameter("ques");
        String qNo = request.getParameter("qNo");

        Question question = new Question(qNo, authId, topicId, request.getParameter("ques"),
                request.getParameter("media"), request.getParameter("corAnw"), request.getParameter("diff"),
                request.getParameter("ex"), request.getParameter("exImage"), request.getParameter("exVed"),
                request.getParameter("ref"));

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
            msg = "Question Updated Successfully";
            model.addAttribute("msg", msg);
            if (allQuestions == 0)
                return "redirect:/allQuesByMe";
            else
                return "redirect:/allQues";
        } else {
            msg = "Failed to update";
            model.addAttribute("msg", msg);
            if (allQuestions == 0)
                return "redirect:/allQuesByMe";
            else
                return "redirect:/allQues";
        }
    }

    @RequestMapping(value = "deleteQues", method = RequestMethod.POST)
    public String deleteQues(HttpServletRequest request, ModelMap model) throws SQLException, ClassNotFoundException {
        String msg;
        int length = Integer.parseInt(request.getParameter("length"));
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int allQuestions = Integer.parseInt(request.getParameter("allQuestions"));

        model.addAttribute("length", length);
        model.addAttribute("currentPage", currentPage);
        if (questionDAO.deleteQuestion(request.getParameter("quesNo"))) {
            msg = "Question Deleted Successfully";
            model.addAttribute("msg", msg);
            if (allQuestions == 0)
                return "redirect:/allQuesByMe";
            else
                return "redirect:/allQues";
        } else {
            msg = "Failed to delete";
            model.addAttribute("msg", msg);
            if (allQuestions == 0)
                return "redirect:/allQuesByMe";
            else
                return "redirect:/allQues";
        }
    }

    @RequestMapping(value = "ques10", method = RequestMethod.GET)
    @ResponseBody
    public String get10Ques() throws SQLException, ClassNotFoundException {
        String json = questionDAO.get10Ques();
        return json;
    }

    @RequestMapping(value = "varQues", produces = "text/plain;charset=UTF-8", method = RequestMethod.GET)
    @ResponseBody
    public String getVarQues(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String quesNo = request.getParameter("quesNo");
        String username = request.getParameter("username");

//        String json = questionDAO.getVarQues(quesNo, username);

//        Map<String, String> vars = new HashMap<>();
//        vars.put("quesNo",quesNo);
//        vars.put("username", username);
        RestTemplate restTemplate = new RestTemplate();
        String json = restTemplate.getForObject(
                "http://localhost/getQuestions.php?quesNo=" + quesNo + "&username=" + username, String.class);

        String out;
        try {
            out = new String(json.getBytes("UTF-8"));
        } catch (java.io.UnsupportedEncodingException e) {
            out = null;
        }
        return out;
    }
}
