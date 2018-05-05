package com.codex.dialog.controller;

import com.codex.dialog.dao.StudentDAO;
import com.codex.dialog.model.Leaderboard;
import com.codex.dialog.model.Student;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@Controller
@RequestMapping("/")
public class StudentController {
    @Autowired
    StudentDAO studentDAO;

    @RequestMapping(value = "addStudent", method = RequestMethod.POST)
    @ResponseBody
    public String addStudent(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        boolean isStudentExists = studentDAO.checkUsername(request.getParameter("username"));
        if (!isStudentExists) {
            studentDAO.addStudent(request.getParameter("username"), request.getParameter("email"),
                    request.getParameter("password"), request.getParameter("contactNo"),
                    request.getParameter("login"));
            return "true";
        } else {
            return "false";
        }
    }

    @RequestMapping(value = "getStudent", method = RequestMethod.GET)
    @ResponseBody
    public String getStudent(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Student student = studentDAO.viewAccount(request.getParameter("username"));
        Gson gson = new Gson();
        String jsonStr = gson.toJson(student);
        return jsonStr;
    }

    @RequestMapping(value = "updateStudent", method = RequestMethod.POST)
    @ResponseBody
    public String updateStudent(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        HttpSession session = request.getSession();
        if (studentDAO.updateDetails(request.getParameter("username"), request.getParameter("email"),
                request.getParameter("password"), request.getParameter("contactNo"))) {

            return "true";
        } else {
            return "false";
        }
    }

    @RequestMapping(value = "updateLogin", method = RequestMethod.POST)
    @ResponseBody
    public String updateLogin(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        if (studentDAO.updateLoginTime(request.getParameter("username"), request.getParameter("login"))) {
            return "true";
        } else {
            return "false";
        }
    }

    @RequestMapping(value = "updateScore", method = RequestMethod.POST)
    @ResponseBody
    public String updateScore(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Gson gson = new Gson();
        ArrayList<Double> questions = gson.fromJson(request.getParameter("questions"), ArrayList.class);
        studentDAO.updateScore(request.getParameter("username"), request.getParameter("score"), questions);
        ArrayList<Leaderboard> students = studentDAO.getLeaderbord(request.getParameter("username"));
        String jsonArray = gson.toJson(students);
        return jsonArray;
    }

    @RequestMapping(value = "getLeaderbord", method = RequestMethod.GET)
    @ResponseBody
    public String getLeaderbord(HttpServletRequest request) throws SQLException, ClassNotFoundException {
        Gson gson = new Gson();
        ArrayList<Leaderboard> students = studentDAO.getLeaderbord(request.getParameter("username"));
        String jsonArray = gson.toJson(students);
        return jsonArray;
    }

    @RequestMapping(value = "authenticate", method = RequestMethod.POST)
    @ResponseBody
    public String isCorrectPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        boolean isCorrect = studentDAO.checkPass(username, pass);
        if (isCorrect) {
            return "true";
        } else {
            return "false";
        }
    }
}