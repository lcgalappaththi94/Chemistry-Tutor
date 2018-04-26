<%@ page import="com.codex.dialog.model.Answer" %>
<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Question</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: 'textarea',
            statusbar: false,
            plugins: 'code',
            toolbar: 'undo redo styleselect superscript subscript bold italic alignleft aligncenter alignright bullist numlist outdent indent'
        });
    </script>

    <style type="text/css">
        body {
            background: url(${pageContext.request.contextPath}/resources/images/93742-d09dd7090171c70be749072814043b26.jpg);
        }
    </style>
</head>

<body onload="sendRequest();">
<div class="container">
    <%
        Question question = (Question) request.getAttribute("ques");
        ArrayList<Answer> answers = (ArrayList<Answer>) request.getAttribute("anw");
        String media = question.getMedia().replace("open", "uc");
        String exImage = question.getExImage().replace("open", "uc");
    %>

    <div class="panel panel-primary">
        <div class="panel-heading"><h1>සම්පූර්ණ ප්‍රශ්නය (ප්‍රශ්න අංක <%=question.getQuesNo()%>)</h1></div>
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
                        <textarea class="form-control" name="ques" readonly><% out.print(question.getQues()); %></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නයට අදාල වෙනත් මාධ්‍ය:</label>
                    <div class="col-sm-6">
                        <img src="<%out.print(media);%>" height="200" width="300">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 1:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="anw1" readonly><% out.print(answers.get(0).getAnswer()); %></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="anw2" readonly><% out.print(answers.get(1).getAnswer()); %></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="anw3" readonly><% out.print(answers.get(2).getAnswer()); %></textarea>
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
                    <label class="control-label col-sm-2">පැහැදිළි කිරීම්:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" name="ex">
                            <% out.print(question.getEx());%>
                        </textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල රූප:</label>
                    <div class="col-sm-6">
                        <img src="<%out.print(exImage);%>" height="200" width="300"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල Video:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="exVed"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර link එක. අත්‍යාවශ්‍ය නැත."
                               value="<% out.print(question.getExVed());%>" readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Reference:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="ref"
                               placeholder="ප්‍රශ්නයට අදාල reference link එක. අත්‍යාවශ්‍ය නැත."
                               value="<% out.print(question.getRef());%>" readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">නිවරදි පිළිතුරේ අංකය:</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" name="corAnw"
                               value="<%out.print(question.getCorAnw());%>" placeholder="නිවරදි පිළිතුරට අදාල  අංකය"
                               readonly/>
                    </div>
                </div>


                <div class="form-group">
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
</html>
