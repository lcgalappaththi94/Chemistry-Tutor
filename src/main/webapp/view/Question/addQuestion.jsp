<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>New Question</title>

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
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
    <script>
        tinymce.init({
            selector: 'textarea#area',
            statusbar: false,
            menubar: true,
            plugins: 'code autoresize',
            toolbar: 'cut copy paste undo redo superscript subscript bold italic underline strikethrough  bullist numlist styleselect code'
        });

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

        function validate(form) {
            if (form.getElementById("combo") != null) {
                return true;
            } else {
                alert('Subject is empty ..!');
                return false;
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
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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


<body onload="sendRequest();">

<div class="container">

    <div class="panel panel-primary">
        <div class="panel-heading"><h1>නව ප්‍රශ්නයක්</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/questionAdd" onsubmit="return validate(this);"
                  name="addQuestion">

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
                                  required></textarea>
                        <input type="hidden" name="ques" id="hiddenQues"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නයට අදාල වෙනත් මාධ්‍ය:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="media"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර. අත්‍යාවශ්‍ය නැත."/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 1:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans1" onclick="openPop(this)"
                               placeholder="පලවන පිළිතුර" required/>
                        <input type="hidden" name="anw1" id="hiddenAns1"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans2" onclick="openPop(this)"
                               placeholder="දෙවන පිළිතුර" required/>
                        <input type="hidden" name="anw2" id="hiddenAns2"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans3" onclick="openPop(this)"
                               placeholder="තෙවන පිළිතුර" required/>
                        <input type="hidden" name="anw3" id="hiddenAns3"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 4:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans4" onclick="openPop(this)"
                               placeholder="හතරවන පිළිතුර" required/>
                        <input type="hidden" name="anw4" id="hiddenAns4"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 5:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="Ans5" onclick="openPop(this)"
                               placeholder="පස්වන පිළිතුර"/>
                        <input type="hidden" name="anw5" id="hiddenAns5"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිළි කිරීම්:</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="Ex" rows="4"
                                  placeholder="ප්‍රශ්නයට අදාල පැහැදිළි කිරීම්" onclick="openPop(this)"> </textarea>
                        <input type="hidden" name="ex" id="hiddenEx"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල රූප:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="exImage"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර link. අත්‍යාවශ්‍ය නැත"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පැහැදිලි කිරීමට අදාල Video:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="exVed"
                               placeholder="ප්‍රශ්නයට අදාල Gif, පින්තුර link එක. අත්‍යාවශ්‍ය නැත."/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Reference:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="ref"
                               placeholder="ප්‍රශ්නයට අදාල reference link එක. අත්‍යාවශ්‍ය නැත."/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">නිවරදි පිළිතුරේ අංකය :</label>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" name="corAnw"
                               placeholder="නිවරදි පිළිතුරට අදාල  අංකය" min="1" max="5" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select class="form-control" name="diff">
                            <option selected value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
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

<script>
    var modal = document.getElementById('myModal');
    var modalAddTopic = document.getElementById('myModalAddTopic');
    var title = document.getElementsByClassName("textTitle")[0];
    var current;

    function openPop(clickedElement) {
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
            modal.style.display = "none";
            tinymce.get('area').setContent("");
            current = null;
        } else if (event.target == modalAddTopic) {
            modalAddTopic.style.display = "none";
            document.getElementById('topic').value = "";
        }
    }
</script>

<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>

</html>