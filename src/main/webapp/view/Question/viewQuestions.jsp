<%@ page import="com.codex.dialog.model.Answer" %>
<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Question</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body onload="sendRequest();">
<div class="container">
    <%
        Question question = (Question) request.getAttribute("ques");
        ArrayList<Answer> answers = (ArrayList<Answer>) request.getAttribute("anw");
        String media = question.getMedia().replace("open","uc");
    %>

    <div class="panel panel-primary">
        <div class="panel-heading"><h1>නව ප්‍රශ්නයක්</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/updateQ" name="addQuestion">

                <input type="hidden" name="qNo" value="<%out.print(question.getQuesNo());%>">
                <input type="hidden" name="anw1No" value="<%out.print(answers.get(0).getAnsNo());%>">
                <input type="hidden" name="anw2No" value="<%out.print(answers.get(1).getAnsNo());%>">
                <input type="hidden" name="anw3No" value="<%out.print(answers.get(2).getAnsNo());%>">
                <input type="hidden" name="anw4No" value="<%out.print(answers.get(3).getAnsNo());%>">
                <input type="hidden" name="anw5No" value="<%out.print(answers.get(4).getAnsNo());%>">

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්ණයට අදාළ මාතෘකාව:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw1"
                               value="<% out.print(question.getTopicId());%>" placeholder="පලවන පිළිතුර"
                               readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නය:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" rows="4" cols="50" name="ques"
                                  placeholder="ඔබගේ ප්‍රශ්නය ඇතුලත් කරන්න"
                                  readonly><% out.print(question.getQues()); %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 1:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw1"
                               value="<% out.print(answers.get(0).getAnswer());%>" placeholder="පලවන පිළිතුර"
                               readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" value="<% out.print(answers.get(1).getAnswer());%>"
                               name="anw2" placeholder="දෙවන පිළිතුර" readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw3"
                               value="<% out.print(answers.get(2).getAnswer());%>" placeholder="තෙවන පිළිතුර"
                               readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 4:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw4"
                               value="<% out.print(answers.get(3).getAnswer());%>" placeholder="හතරවන පිළිතුර"
                               readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 5:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw5"
                               value="<% out.print(answers.get(4).getAnswer());%>" placeholder="පස්වන පිළිතුර"
                               readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">වෙනත් මාධ්‍ය:</label>
                    <img src="<%out.print(media);%>" height="200" width="300"></img>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">නිවරදි පිළිතුරේ අංකය :</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" name="corAnw"
                               value="<%out.print(question.getCorAnw());%>" placeholder="නිවරදි පිළිතුරට අදාල  අංකය"
                               readonly/>
                    </div>
                </div>


                <div class="selectpicker">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" name="corAnw" value="<%out.print(question.getDiff());%>"
                               placeholder="නිවරදි පිළිතුරට අදාල  අංකය" readonly/>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
</body>

<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>
</html>
