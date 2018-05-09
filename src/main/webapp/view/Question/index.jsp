<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>

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
            if(document.getElementById("form-email").value.length>0) {
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
    </script>
</head>

<div id="header">
    <%@ include file="../fragments/loginHeader.jspf" %>
</div>

<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1><strong>My Chemistry Tutor</strong> Login &amp; Register Forms</h1>
            <div class="description">
                <p>
                    Objective of this project is to practise students who face A/L Exams
                </p>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-5">
                    <div class="form-box">
                        <div class="form-top">
                            <div class="form-top-left">
                                <h3>Login to our site</h3>
                                <p>Enter username and password to log on:</p>
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
                                <button type="submit" class="btn btn-success">Sign In</button>
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
<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>
</html>