<%@ page import="com.codex.dialog.model.Answer" %>
<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script type="text/javascript">

        function createXMLHttpRequest() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {
                // code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;

        }

        function sendRequest() {
            var url = "allTopics";

            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        document.getElementById('combo').innerHTML = output;
                    }
                }
            }
        }
    </script>
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
    %>

    <div class="panel panel-primary">
        <div class="panel-heading"><h1>ප්‍රශ්නය යාවත්කාලින කිරිම</h1></div>
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
                    <div id="combo" class="col-sm-6">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නය අතුලත් කරන්න</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" rows="4" cols="50" name="ques"
                                  placeholder="ඔබගේ ප්‍රශ්නය ඇතුලත් කරන්න" required><% out.print(question.getQues()); %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නයට අදාල වෙනත් මාධ්‍ය:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="media"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර. අත්‍යාවශ්‍ය නැත."
                               value="<% out.print(question.getMedia());%>"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 1:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw1" required
                               value="<% out.print(answers.get(0).getAnswer());%>" placeholder="පලවන පිළිතුර">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" value="<% out.print(answers.get(1).getAnswer());%>"
                               name="anw2" placeholder="දෙවන පිළිතුර" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw3" required
                               value="<% out.print(answers.get(2).getAnswer());%>" placeholder="තෙවන පිළිතුර">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 4:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw4"
                               value="<% out.print(answers.get(3).getAnswer());%>" required placeholder="හතරවන පිළිතුර">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 5:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw5"
                               value="<% out.print(answers.get(4).getAnswer());%>" placeholder="පස්වන පිළිතුර">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිළි කිරීම්:</label>
                    <div>
                        <textarea class="form-control" rows="6" cols="75" name="ex"
                               placeholder="ප්‍රශ්නයට අදාල පැහැදිළි කිරීම්" value="<% out.print(question.getEx());%>">
                        </textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල රූප:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="exImage"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර link. අත්‍යාවශ්‍ය නැත"
                               value="<% out.print(question.getExImage());%>"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල Video:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="exVed"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර link එක. අත්‍යාවශ්‍ය නැත."
                               value="<% out.print(question.getExVed());%>"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Reference:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="ref"
                               placeholder="ප්‍රශ්නයට අදාල reference link එක. අත්‍යාවශ්‍ය නැත."
                               value="<% out.print(question.getRef());%>"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">නිවරදි පිළිතුරේ අංකය :</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" name="corAnw"
                               value="<%out.print(question.getCorAnw());%>"
                               placeholder="නිවරදි පිළිතුරට අදාල  අංකය" min="1" max="5" required>
                    </div>
                </div>

                <% if (question.getDiff().equals("Easy")) {
                %>

                <div class="selectpicker">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select name="diff">
                            <option selected value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                        </select>

                    </div>
                </div>

                <% } else if (question.getDiff().equals("Medium")) {
                %>

                <div class="selectpicker">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select name="diff">
                            <option value="Easy">Easy</option>
                            <option Selected value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                        </select>

                    </div>
                </div>

                <% } else if (question.getDiff().equals("Hard")) {
                %>

                <div class="selectpicker">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select name="diff">
                            <option value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option selected value="Hard">Hard</option>
                        </select>

                    </div>
                </div>

                <%
                    }
                %>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-success">Submit</button>
                        <button type="reset" class="btn btn-primary">Clear</button>
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