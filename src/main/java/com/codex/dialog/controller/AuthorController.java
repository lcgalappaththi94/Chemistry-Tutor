package com.codex.dialog.controller;

import com.codex.dialog.dao.AuthorDAO;
import com.codex.dialog.model.Auther;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;


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
            Auther addedAuther = authorDAO.getAuther(request.getParameter("form-email"));
            HttpSession session = request.getSession();
            session.setAttribute("authId", addedAuther.getAuthId());
            return "Question/successHome";
        } else {
            String msg = "Failed To add";
            request.setAttribute("msg", msg);
            return "Question/failHome";
        }
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

    @RequestMapping(value = "verif", method = RequestMethod.GET)
    public void confirmEmail(HttpServletRequest request ,HttpServletResponse response) throws SQLException, ClassNotFoundException, IOException {

        PrintWriter out = response.getWriter();

        String receiverEmail = request.getParameter("email");
        //Creating 4 digit random code
        Random random = new Random();
        String id = String.format("%04d", random.nextInt(10000));

        final String username = "teamcodexfit@gmail.com";
        final String password = "Codex123";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("teamcodexfit@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(receiverEmail));
            message.setSubject("Welcome to My Chemistry tutor");
            message.setText("Dear sir/ madam,\nThank your for login to out site. This is your verification code... "+ id);

            Transport.send(message);

            out.print(id);

        } catch (MessagingException e) {
            out.print("AB");
        }
    }
}
