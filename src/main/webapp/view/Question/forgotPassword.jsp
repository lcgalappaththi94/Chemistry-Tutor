<%@ page import="com.codex.dialog.model.Auther" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset Password</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        /* Center the loader */
        #loaderDiv {
            position: absolute;
            left: 50%;
            top: 50%;
            z-index: 1;
            width: 150px;
            height: 150px;
            margin: -75px 0 0 -75px;
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite;
            animation: spin 2s linear infinite;
        }

        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }
            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        @-webkit-keyframes animatebottom {
            from {
                bottom: -100px;
                opacity: 0
            }
            to {
                bottom: 0px;
                opacity: 1
            }
        }

        @keyframes animatebottom {
            from {
                bottom: -100px;
                opacity: 0
            }
            to {
                bottom: 0;
                opacity: 1
            }
        }

    </style>

    <script type="text/javascript">

        var passwordOk = false;

        function createXMLHttpRequest() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;
        }

        function sendRequest() {
            if (passwordOk) {

                var authId = document.getElementById("authId").value;
                var password = document.getElementById("password").value;
                var url = "/resetPasswordNow?authId=" + authId + "&password=" + password;
                var request = createXMLHttpRequest();
                request.open("POST", url, true);
                request.send(null);
                request.onreadystatechange = function () {
                    if (request.readyState == 4) {
                        if (request.status == 200) {
                            var output = request.responseText;
                            if (output == "1") {
                                alert("Changed Password Successfully!!!");
                                document.getElementById("msg").style.color = "#FF0000"
                                document.getElementById("msg").innerHTML = "You Are Being Redirected To Home Page Please Login";
                                document.getElementById("loaderDiv").style.display = "block";
                                setTimeout(redirectNow, 2000);
                            } else {
                                alert("Failed Changing Password!!!");
                            }
                        }
                    }
                }
            }
        }

        function redirectNow() {
            window.location.replace("http://chemistrytutor.ddns.net/");
        }

        function compare() {
            var password = document.getElementById("password").value;
            var cPassword = document.getElementById("cPassword").value;
            if (password === cPassword) {
                passwordOk = true;
            } else {
                passwordOk = false;
            }
        }

        function validatePassword() {
            var password = document.getElementById("password").value;
            var cPassword = document.getElementById("cPassword");
            if (password.length > 0) {
                cPassword.readOnly = false;
            } else {
                cPassword.readOnly = true;
            }
        }
    </script>
</head>

<div id="header">
    <%@ include file="../fragments/loginHeader.jspf" %>
</div>

<body>
<div class="container">

    <%
        Auther auther = (Auther) request.getAttribute("auther");
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1 style="color: #0f0f0f">Hi <%out.print(auther.getName());%>,</h1>
            <h2 id="msg">Please Reset your Password Here...</h2>
        </div>

        <div class="panel-body">
            <div class="loader" id="loaderDiv" hidden></div>
            <form class="form-horizontal" id="form">

                <input type="hidden" id="authId" value="<%out.print(auther.getAuthId());%>">
                <input type="hidden" id="email" value="<%out.print(auther.getEmail());%>">

                <div class="form-group">
                    <label class="control-label col-sm-3">New Password :</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="password" onkeyup="validatePassword()"
                               placeholder="Enter your new password"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">Confirm new password :</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="cPassword"
                               placeholder="Confirm your new password" onkeyup="compare()" readonly/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <button type="button" onclick="sendRequest()" class="btn btn-success">Change Passowrd</button>
                        <button type="reset" class="btn btn-primary">Clear</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
</body>

<%--<div id="footer">--%>
<%--<%@ include file="../fragments/footer.jspf" %>--%>
<%--</div>--%>

</html>