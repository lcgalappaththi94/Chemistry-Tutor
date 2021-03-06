<%@ page import="com.codex.dialog.model.Answer" %>
<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Question</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
        body {
            background: url(${pageContext.request.contextPath}/resources/images/93742-d09dd7090171c70be749072814043b26.jpg);
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888888;
            width: 80%;
        }

        /* The Close Button */
        .close {
            color: #FF0000;
            float: right;
            font-size: 30px;
            font-weight: bold;
        }

        .textTitle {
            color: #0000FF;
            float: left;
            font-size: 30px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000000;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

    <script src="${pageContext.request.contextPath}/resources/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: 'textarea#area',
            statusbar: false,
            menubar: true,
            plugins: 'code autoresize paste',
            paste_enable_default_filters: false,
            valid_elements: 'p,sup,sub,h1,h2,h3,h4,h5,h6,b,i,emp,strong,strike,s,del',
            toolbar: 'cut copy paste undo redo superscript subscript bold italic underline strikethrough  bullist numlist styleselect code'
        });

        function createXMLHttpRequest() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;

        }

        function sendRequest(selected) {
            var url = "allTopicsSelected?selected=" + selected;

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
            convertElements();
        }

        function convertElements() {
            var ques = document.getElementById("Ques");
            var ans1 = document.getElementById("Ans1");
            var ans2 = document.getElementById("Ans2");
            var ans3 = document.getElementById("Ans3");
            var ans4 = document.getElementById("Ans4");
            var ans5 = document.getElementById("Ans5");
            var ex = document.getElementById("Ex");
            convert(ques, "textArea");
            convert(ans1, "input");
            convert(ans2, "input");
            convert(ans3, "input");
            convert(ans4, "input");
            convert(ans5, "input");
            convert(ex, "textArea");
        }

        function convert(element, type) {
            if (type == "textArea") {
                var value = element.value;
                element.value = getPlainText(value);
            } else if (type == "input") {
                var value = element.value;
                element.value = getPlainText(value);
            }
        }

        function sendTopic() {
            var topic = document.getElementById('topic').value;
            var topicSuccess = document.getElementById('topicSuccess');
            var url = "add?topic=" + topic;

            var request = createXMLHttpRequest();
            request.open("POST", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        if (output == "Added Successfully") {
                            topicSuccess.style.color = "green";
                            topicSuccess.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Added Successfully!!!";
                            setTimeout(closePopAddTopic, 1500);
                        }
                    } else {
                        topicSuccess.style.color = "red";
                        topicSuccess.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error Occurred!!!";
                    }
                }
            }
        }

        function checkTopic(isSubmit) {
            var topic = document.getElementById('topic').value;
            var label = document.getElementById('topicCheck');
            var url = "check?topic=" + topic;

            if (topic.length != 0) {
                var request = createXMLHttpRequest();
                request.open("POST", url, true);
                request.send(null);
                request.onreadystatechange = function () {
                    if (request.readyState == 4) {
                        if (request.status == 200) {
                            var output = request.responseText;
                            if (output == "1") {
                                label.innerHTML = "<span style='color:blue'><h4><= Ok</h4></span>";
                                if (isSubmit == 1) {
                                    sendTopic();
                                }
                            } else {
                                label.innerHTML = "<span style='color:red'><h4><= Topic Already Exists</h4></span>";
                            }
                        } else {
                            alert("Error With Topic Add!!!");
                        }
                    }
                }
            } else {
                label.innerHTML = "<span style='color:red'><h4><= Empty</h4></span>";
            }
        }
    </script>



</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" style="color: red" onclick="closePop()">Save and Close</span>
        <span class="textTitle"></span>
        <br><br>
        <hr>
        <textarea id="area"></textarea>
    </div>
</div>

<div id="myModalAddTopic" class="modal">
    <div class="modal-content">
        <span class="close" style="color: red" onclick="closePopAddTopic()">Close</span>
        <h1 class="textTitle">නව මාතෘකාවක්<span id="topicSuccess"></span></h1>
        <br><br><br>
        <hr>
        <form class="form-horizontal">

            <div class="form-group">
                <label class="control-label col-sm-2">මාතෘකාව : </label>
                <div class="col-sm-6">
                    <input id="topic" type="text" class="form-control"
                           placeholder="ඔබගේ ප්‍රශ්නයට අදාල මාතෘකාව" onkeyup="checkTopic(0)" autofocus/>
                </div>
                <label id="topicCheck"></label>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" onclick="checkTopic(1)" class="btn btn-success">Submit</button>
                    <button type="reset" class="btn btn-primary">Clear</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%
    Question question = (Question) request.getAttribute("ques");
    ArrayList<Answer> answers = (ArrayList<Answer>) request.getAttribute("anw");
%>

<body onload="sendRequest(<%out.print("'"+question.getTopicId()+"'");%>)">
<div class="container">

    <div class="panel panel-primary">
        <div class="panel-heading"><h1>ප්‍රශ්නය යාවත්කාලින කිරිම (ප්‍රශ්න අංක <%=question.getQuesNo()%>)</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="POST" action="/updateQ" name="updateQuestion">

                <input type="hidden" name="qNo" value="<%out.print(question.getQuesNo());%>">
                <input type="hidden" name="anw1No" value="<%out.print(answers.get(0).getAnsNo());%>">
                <input type="hidden" name="anw2No" value="<%out.print(answers.get(1).getAnsNo());%>">
                <input type="hidden" name="anw3No" value="<%out.print(answers.get(2).getAnsNo());%>">
                <input type="hidden" name="anw4No" value="<%out.print(answers.get(3).getAnsNo());%>">
                <input type="hidden" name="anw5No" value="<%out.print(answers.get(4).getAnsNo());%>">
                <input type="hidden" name="currentPage" value="<%out.print(request.getAttribute("currentPage"));%>">
                <input type="hidden" name="length" value="<%out.print(request.getAttribute("length"));%>">
                <input type="hidden" name="allQuestions" value="<%out.print(request.getAttribute("allQuestions"));%>">

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්ණයට අදාළ මාතෘකාව:</label>
                    <div id="combo" class="col-sm-6">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නය අතුලත් කරන්න</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="Ques" rows="4"
                                  placeholder="ඔබගේ ප්‍රශ්නය ඇතුලත් කරන්න" onclick="openPop(this)"
                                  required><% out.print(question.getQues()); %></textarea>
                        <input type="hidden" name="ques" value="<% out.print(question.getQues()); %>"
                               id="hiddenQues"/>
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
                        <input type="text" class="form-control" id="Ans1"
                               value="<% out.print(answers.get(0).getAnswer());%>"
                               onclick="openPop(this)" placeholder="පලවන පිළිතුර" required>
                        <input type="hidden" name="anw1" value="<% out.print(answers.get(0).getAnswer());%>"
                               id="hiddenAns1"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans2"
                               value="<% out.print(answers.get(1).getAnswer());%>"
                               placeholder="දෙවන පිළිතුර" onclick="openPop(this)" required>
                        <input type="hidden" name="anw2" value="<% out.print(answers.get(1).getAnswer());%>"
                               id="hiddenAns2"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans3"
                               value="<% out.print(answers.get(2).getAnswer());%>" onclick="openPop(this)"
                               placeholder="තෙවන පිළිතුර" required>
                        <input type="hidden" name="anw3" value="<% out.print(answers.get(2).getAnswer());%>"
                               id="hiddenAns3"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 4:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans4"
                               value="<% out.print(answers.get(3).getAnswer());%>" onclick="openPop(this)"
                               placeholder="හතරවන පිළිතුර" required>
                        <input type="hidden" name="anw4" value="<% out.print(answers.get(3).getAnswer());%>"
                               id="hiddenAns4"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 5:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans5"
                               value="<% out.print(answers.get(4).getAnswer());%>" onclick="openPop(this)"
                               placeholder="පස්වන පිළිතුර">
                        <input type="hidden" name="anw5" value="<% out.print(answers.get(4).getAnswer());%>"
                               id="hiddenAns5"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිළි කිරීම්:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="Ex" rows="4" placeholder="ඔබගේ පැහැදිළි කිරීම"
                                  onclick="openPop(this)">
                            <%out.print(question.getEx());%></textarea>
                        <input type="hidden" name="ex" value="<%out.print(question.getEx());%>" id="hiddenEx"/>
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

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select class="form-control" name="diff">
                            <% if (question.getDiff().equals("Easy")) {%>
                            <option selected value="Easy">Easy</option>
                            <%} else {%>
                            <option value="Easy">Easy</option>
                            <%}%>

                            <%if (question.getDiff().equals("Medium")) { %>
                            <option selected value="Medium">Medium</option>
                            <%} else {%>
                            <option value="Medium">Medium</option>
                            <%}%>

                            <%if (question.getDiff().equals("Hard")) { %>
                            <option selected value="Hard">Hard</option>
                            <%} else {%>
                            <option value="Hard">Hard</option>
                            <%}%>
                        </select>

                    </div>
                </div>


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

<script>
    var modal = document.getElementById('myModal');
    var modalAddTopic = document.getElementById('myModalAddTopic');
    var title = document.getElementsByClassName("textTitle")[0];
    var current;

    function openPop(clickedElement) {
        tinymce.get('area').setContent("");
        if (clickedElement.value != "") {
            var actualContent = document.getElementById("hidden" + clickedElement.id).value;
            tinymce.get('area').setContent(actualContent);
        }
        current = clickedElement;
        tinymce.execCommand('mceFocus', false, 'area');
        modal.style.display = "block";
        title.innerHTML = clickedElement.placeholder;
    }

    function closePop() {
        modal.style.display = "none";
        var content = tinymce.get('area').getContent();
        var plainText = getPlainText(content);
        document.getElementById("hidden" + current.id).value = content;
        current.value = plainText;
        tinymce.get('area').setContent("");
        current = null;
    }

    function openPopAddTopic() {
        modalAddTopic.style.display = "block";
        document.getElementById('topicCheck').innerHTML = "";
    }

    function closePopAddTopic() {
        modalAddTopic.style.display = "none";
        document.getElementById('topic').value = "";
        document.getElementById('topicCheck').innerHTML = "";
        document.getElementById('topicSuccess').innerHTML = "";
        sendRequest();
    }

    function getPlainText(originalContent) {
        var temporalDivElement = document.createElement("div");
        temporalDivElement.innerHTML = originalContent;
        return temporalDivElement.textContent || temporalDivElement.innerText || "";
    }

    window.onclick = function (event) {
        if (event.target == modal) {
            //modal.style.display = "none";
            //tinymce.get('area').setContent("");
            closePop();
        } else if (event.target == modalAddTopic) {
            modalAddTopic.style.display = "none";
            document.getElementById('topic').value = "";
            document.getElementById('topicCheck').innerHTML = "";
            document.getElementById('topicSuccess').innerHTML = "";
        }
    }
</script>
</html>