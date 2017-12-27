package com.codex.dialog.controller;

import com.codex.dialog.dao.AuthorDAO;
import com.codex.dialog.model.Auther;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
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

@Controller
@RequestMapping("/")
public class AuthorController {

    @Autowired
    AuthorDAO authorDAO;

    @RequestMapping(value = "addAuther", method = RequestMethod.POST)
    public String addQuestion(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        Auther auther = new Auther("", request.getParameter("designation"), request.getParameter("form-email"), request.getParameter("password"), request.getParameter("name"));
        boolean isAdded = false;
        boolean isAuthExists = authorDAO.isAuther(request.getParameter("form-email"));
        if (!isAuthExists) {
            isAuthExists = authorDAO.addAuther(auther);
            String msg = "Added Successfully";
            request.setAttribute("msg", msg);
            return "Question/successHome";
        } else if (isAuthExists) {
            String msg = "Email is already taken";
            request.setAttribute("msg", msg);
        } else {
            String msg = "Failed To add";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
        return "success";
    }

    @RequestMapping(value = "mailTaken", method = RequestMethod.GET)
    public void mailValidation(HttpServletRequest request, HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        PrintWriter out = response.getWriter();
        boolean isAuthExists = authorDAO.isAuther(request.getParameter("email"));
        if (!isAuthExists) {
            out.print("1");
        } else {
            out.print("0");
        }
    }

    @RequestMapping(value = "auth", method = RequestMethod.POST)
    public String authenticateAuthor(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");

        String authId = authorDAO.authenticate(pass, email);
        if (!authId.equals("")) {
            //String msg = "Authenticated User :"+authId ;
            HttpSession session = request.getSession();
            session.setAttribute("authId", authId);
            return "Question/home";

        } else {
            String msg = "Wrong Credentials";
            request.setAttribute("msg", msg);
            return "Question/index";
        }
    }

    @RequestMapping(value = "getAuthor", method = RequestMethod.POST)
    public String getAuthor(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        HttpSession session = request.getSession();
        String authId = (String) session.getAttribute("authId");

        if (!authId.equals("")) {
            //String msg = "Authenticated User :"+authId ;
            Auther auther = authorDAO.getAuthor(authId);
            auther.getDesig();
            request.setAttribute("auther", auther);
            return "Question/viewAuther";
        }
        else {
            return "";
        }
    }

    @RequestMapping(value = "updateAuther", method = RequestMethod.POST)
    public String updateAuthor(HttpServletRequest request) throws SQLException, ClassNotFoundException, UnsupportedEncodingException {
        HttpSession session = request.getSession();
        Auther auther = new Auther(request.getParameter("authId"),request.getParameter("designation"),request.getParameter("email"),request.getParameter("password"),request.getParameter("name"));
        if (!auther.getPassword().equals("")) {
            if(authorDAO.updateAuthor(auther)){
                return "Question/successHome";
            }else{
                return "Question/failHome";
            }
        }
        else {
            if(authorDAO.updateAuthorWithoutPassword(auther)){
                return "Question/successHome";
            }else{
                return "Question/failHome";
            }
        }
    }

    @RequestMapping(value = "checkOldVal", method = RequestMethod.GET)
    public void confirmOldPassword(HttpServletRequest request ,HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        PrintWriter out = response.getWriter();
        String authId = authorDAO.authenticate(pass,email);
        if (authId.equals("")){
           out.print("0");
        }else {
            out.print("1");
        }
    }
}
