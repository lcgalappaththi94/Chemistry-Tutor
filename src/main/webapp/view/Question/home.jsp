<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

    <script>
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

        function clearSpan() {
            setTimeout(clearSpanNow, 1500);
        }

        function clearSpanNow() {
            document.getElementById("msg").innerHTML = "";
        }
    </script>

</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body onload="clearSpan()">

<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1>My Dashboard &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span id="msg" style="background-color: #0f0f0f">${msg}</span></h1>
        </div>
        <div class="panel-body">
            <form method="GET" action="allQuesByMe">
                <button class="btn btn-info btn-lg" value="තමා විසින් එක්කල ප්‍රශ්න සියල්ල">
                    <span class="glyphicon glyphicon-star"></span> තමා විසින් එක්කල ප්‍රශ්න සියල්ල
                </button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>

            <form method="GET" action="allQues">
                <button class="btn btn-primary btn-lg" value="ප්‍රශ්න සියල්ල">
                    <span class="glyphicon glyphicon-list"></span> ප්‍රශ්න සියල්ල
                </button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>

            <form method="GET" action="addQ">
                <button class="btn btn-success btn-lg" value="නව ප්‍රශ්නයක් එක් කීරීමට">
                    <span class="glyphicon glyphicon-plus"></span> නව ප්‍රශ්නයක් එක් කීරීමට
                </button>
            </form>

            <form>
                <button class="btn btn-danger btn-lg" type="button" value="නව මාතෘකාවක් එක් කීරීමට"
                        onclick="openPopAddTopic()">
                    <span class="glyphicon glyphicon-plus"></span> නව මාතෘකාවක් එක් කීරීමට
                </button>
            </form>

            <form method="POST" action="getAuthor">
                <button class="btn btn-warning btn-lg" value="ඔබගේ ගිණුම වෙත පිවිසෙන්න">
                    <span class="glyphicon glyphicon-user"></span> ඔබගේ ගිණුම වෙනස් කිරීමට
                </button>
            </form>
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
                               placeholder="ඔබගේ ප්‍රශ්නයට අදාල මාතෘකාව" onkeyup="checkTopic(0)" autofocus required/>
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

</div>
</body>

<script>
    var modalAddTopic = document.getElementById('myModalAddTopic');

    function openPopAddTopic() {
        modalAddTopic.style.display = "block";
        document.getElementById('topicCheck').innerHTML = "";
    }

    function closePopAddTopic() {
        modalAddTopic.style.display = "none";
        document.getElementById('topic').value = "";
        document.getElementById('topicCheck').innerHTML = "";
        document.getElementById('topicSuccess').innerHTML = "";
    }

    window.onclick = function (event) {
        if (event.target == modalAddTopic) {
            modalAddTopic.style.display = "none";
            document.getElementById('topic').value = "";
        }
    }
</script>

<%--<div id="footer">--%>
<%--<%@ include file="../fragments/footer.jspf" %>--%>
<%--</div>--%>
</html>