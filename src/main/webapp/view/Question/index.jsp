<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>

    <style>
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

    <script type="text/javascript">
        var verificationCode = "";

        function passwordVal(doc) {
            var password = doc.password.value;
            var cPassword = doc.cPassword.value;
            if (!(password === cPassword)) {
                window.alert("Passwords are not equal");
                document.getElementById("password").value = "";
                document.getElementById("cPassword").value = "";
            }
        }

        function checkEmail(form) {
            if (document.getElementById("form-email").value.length > 0) {
                if (!/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(document.getElementById("form-email").value)) {
                    window.alert("Invalid Email");
                    document.getElementById("form-email").value = "";
                    document.getElementById("btn-veri").disabled = true;
                } else {
                    sendRequest(form);
                }
            }
        }

        function createXMLHttpRequest() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;

        }

        function sendRequest(form) {
            var url = "mailTaken?email=" + form.value;
            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        if (output === "0") {
                            window.alert("Email already taken please re-enter ....");
                            document.getElementById("form-email").value = "";
                            document.getElementById("btn-veri").disabled = true;
                        } else {
                            document.getElementById("btn-veri").disabled = false;
                        }
                    }
                }
            }
        }

        function veriCode() {
            var email = document.getElementById("form-email").value;
            var url = "verify?email=" + email;
            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        verificationCode = request.responseText;
                        alert("Email Sent! Please Enter Verification Code")
                    }
                }
            }
        }

        function onSubmitCodeCheck() {
            var code = document.getElementById("code").value;
            if (code === verificationCode) {
                return true;
            } else {
                document.getElementById("code").value = "";
                window.alert("Verification code is invalid...");
                return false;
            }
        }

        function sendForgot() {
            var email = document.getElementById('email').value;
            var forgotSuccess = document.getElementById('forgotSuccess');
            var url = "forgotSend?email=" + email;

            var request = createXMLHttpRequest();
            request.open("POST", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        if (output == "1") {
                            forgotSuccess.style.color = "green";
                            forgotSuccess.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email Sent Check Your Inbox!!!";
                            setTimeout(closePopForget, 1500);
                        }
                    } else {
                        forgotSuccess.style.color = "red";
                        forgotSuccess.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error Occurred!!!";
                    }
                }
            }
        }

        function checkForgot(isSubmit) {
            var email = document.getElementById('email').value;
            var label = document.getElementById('forgotCheck');
            var button = document.getElementById("forgotSend");
            var url = "forgot?email=" + email;
            var emailOK = true;

            if (!/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)) {
                emailOK = false;
            }

            if (email.length != 0 && emailOK) {
                var request = createXMLHttpRequest();
                request.open("POST", url, true);
                request.send(null);
                request.onreadystatechange = function () {
                    if (request.readyState == 4) {
                        if (request.status == 200) {
                            var output = request.responseText;
                            if (output == "1") {
                                label.innerHTML = "<span style='color:blue'><h4><= Ok</h4></span>";
                                button.disabled = false;
                                if (isSubmit == 1) {
                                    sendForgot();
                                }
                            } else {
                                button.disabled = true;
                                label.innerHTML = "<span style='color:red'><h4><= Email Not Valid</h4></span>";
                            }
                        } else {
                            alert("Error When Sending Email!!!");
                        }
                    }
                }
            } else {
                label.innerHTML = "<span style='color:red'><h4><= Email Not Valid</h4></span>";
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
    <%@ include file="../fragments/loginHeader.jspf" %>
</div>

<div id="myModalForgot" class="modal">
    <div class="modal-content">
        <span class="close" style="color: red" onclick="closePopForget()">Close</span>
        <h1 class="textTitle">Forgot Password<span id="forgotSuccess"></span></h1>
        <br><br><br>
        <hr>
        <form class="form-horizontal">

            <div class="form-group">
                <label class="control-label col-sm-2">Your Email : </label>
                <div class="col-sm-6">
                    <input id="email" type="email" class="form-control"
                           placeholder="Enter your email here" onkeyup="checkForgot(0)" autofocus required/>
                </div>
                <label id="forgotCheck"></label>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" id="forgotSend" onclick="checkForgot(1)" class="btn btn-success" disabled>Send
                        Password Reset Email
                    </button>
                    <button type="reset" class="btn btn-primary">Clear</button>
                </div>
            </div>
        </form>
    </div>
</div>

<body onload="clearSpan()">
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1><strong>My Chemistry Tutor</strong> Login &amp; Register Forms</h1>
            <div class="description">
                <p>
                    Objective of this project is to practise students who face A/L Exams
                </p>
            </div>
            <h1 id="msg" style="background-color: #0f0f0f">${msg}</h1>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-sm-5">
                    <div class="form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>Login to our site</h3>
                                <p>Enter username and password to login:</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-key"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form role="form" action="/auth" method="post" class="login-form">
                                <div class="form-group">
                                    <label class="sr-only" for="form-username">Email</label>
                                    <input type="text" name="email" placeholder="Username..."
                                           class="form-username form-control" id="form-username" required>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="SignInPassword">Password</label>
                                    <input type="password" name="pass" placeholder="Password..."
                                           class="form-password form-control" id="SignInPassword" required>
                                    <input type="checkbox"
                                           onclick="if(this.checked)SignInPassword.type='text';else SignInPassword.type='password';"/>
                                    show password
                                    <br>
                                </div>
                                <button type="submit" class="btn btn-success">Sign In</button><br><br>
                                <button type="button" onclick="openPopForget()" class="btn btn-danger">Forgot Password
                                </button>
                            </form>
                        </div>
                    </div>


                </div>

                <div class="col-sm-1 middle-border"></div>
                <div class="col-sm-1"></div>

                <div class="col-sm-5">

                    <div class="form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>Sign up now</h3>
                                <p>Fill in the form below to get instant access:</p>
                            </div>
                            <div class="form-top-right">
                                <i class="fa fa-pencil"></i>
                            </div>
                        </div>
                        <div class="form-bottom">
                            <form name="sign" action="/addAuther" method="post" class="registration-form"
                                  onsubmit="return onSubmitCodeCheck();">

                                <div class="form-group">
                                    <label>Designation:</label>
                                    <select name="designation" class="form-control" id="sel1">
                                        <option selected value="Mr">Mr</option>
                                        <option value="Ms">Ms</option>
                                        <option value="Mrs">Mrs</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="form-first-name">First name</label>
                                    <input type="text" name="name" placeholder="Enter Enter Name"
                                           class="form-first-name form-control" id="form-first-name" required>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="form-email">Email</label>
                                    <input type="text" name="form-email" placeholder="Enter Your Email"
                                           class="form-email form-control" id="form-email" required
                                           onblur="checkEmail(this);">
                                    <button id="btn-veri" type="button" class="btn btn-danger" onclick="veriCode();"
                                            disabled> Send Verification Code
                                    </button>

                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-email">Verification Code</label>
                                    <input type="text" name="form-code" placeholder="Enter 4 digit verification code"
                                           class="form-email form-control" id="code" required>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-first-name">Password</label>
                                    <input type="password" name="password" placeholder="Password..."
                                           class="form-first-name form-control" id="password" required>
                                    <input type="checkbox"
                                           onclick="if(this.checked)password.type='text';else password.type='password';"/>
                                    show password
                                    <br>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="form-first-name">Confirm Password</label>
                                    <input type="password" name="cPassword" placeholder="Confirm Password..."
                                           class="form-first-name form-control" id="cPassword"
                                           onblur="passwordVal(document.sign)" required/>
                                    <input type="checkbox"
                                           onclick="if(this.checked)cPassword.type='text';else cPassword.type='password';"/>
                                    show password
                                    <br>
                                </div>

                                <button type="submit" class="btn btn-primary">Sign Me Up</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>


<script>
    var modalForgot = document.getElementById('myModalForgot');

    function openPopForget() {
        modalForgot.style.display = "block";
        document.getElementById('forgotCheck').innerHTML = "";
        document.getElementById("forgotSend").disabled = true;
    }

    function closePopForget() {
        modalForgot.style.display = "none";
        document.getElementById('email').value = "";
        document.getElementById('forgotCheck').innerHTML = "";
        document.getElementById('forgotSuccess').innerHTML = "";
        document.getElementById("forgotSend").disabled = true;
    }

    window.onclick = function (event) {
        if (event.target == modalForgot) {
            modalForgot.style.display = "none";
            document.getElementById('email').value = "";
            document.getElementById("forgotSend").disabled = true;
        }
    }
</script>

<%--<div id="footer">--%>
<%--<%@ include file="../fragments/footer.jspf" %>--%>
<%--</div>--%>
</html>