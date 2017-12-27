<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page contentType="text/html" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login and SignIn</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script type="text/javascript">
        var validEmail = 0;

        $(document).ready(function () {
            $("#signin").hide();
            $("#login").show();
            document.getElementById("emailBtn").style.display = "none";


            $("a").click(function (event) {
                $("#login").hide();
                $("#signin").hide();
                $(event.target.id).show();
            });

            $("#business").click(function () {
                window.open("/facilitator/signIn", "_self");
            });

        });

        function checkDatabase(str) {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    document.getElementById("validEmail").innerHTML = xmlhttp.responseText;
                    if (xmlhttp.responseText.length == 37) {
                        validEmail = 1;
                        document.getElementById("emailBtn").style.display = "initial";
                    } else {
                        document.getElementById("emailBtn").style.display = "none";
                    }
                }
            };
            xmlhttp.open("POST", "/ajax?email=" + str, true);
            xmlhttp.send();
        }

        function checkEmail(str) {
            if (str.length == 0) {
                document.getElementById("validEmail").innerHTML = "";
                document.getElementById("emailBtn").style.display = "none";
                return;
            } else {
                if
                (!/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(str)) {
                    document.getElementById("validEmail").style.color = "red";
                    document.getElementById("validEmail").innerHTML = "<- Invalid Email";
                    document.getElementById("emailBtn").style.display = "none";
                    validEmail = 0;
                } else {
                    document.getElementById("validEmail").style.color = "blue";
                    document.getElementById("validEmail").innerHTML = "<- Valid Email";
                    checkDatabase(str)
                }
            }
        }

        function startNotifications() {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                }
            };
            xmlhttp.open("POST", "/notifications", true);
            xmlhttp.send();
            return true;
        }
    </script>
</head>
<div id="header">
    <%@include file="../fragments/header.jspf" %>
</div>

<body>
<div class=" container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1>Login Or SignIn</h1>
            <h1 id="msg">${status} ${loggedUser}</h1>
        </div>
        <div class="panel-body">
            <div class="form">

                <div class="btn-group btn-group-justified">
                    <a id="#login" class="btn btn-primary"><strong>Login</strong></a>
                    <a id="#signin" class="btn btn-primary"><strong>Sign In</strong></a>
                </div>

                <div class="tab-content">

                    <div id="login">
                        <h1>Welcome Back!!!</h1>
                        <form method="post" class="form-horizontal" onsubmit="startNotifications()" action="/logged"
                              name="userCheck">

                            <div class="form-group">
                                <label class="control-label col-sm-2">Email:</label>
                                <div class="col-sm-6">
                                    <input type="email" class="form-control" name="email" placeholder="Enter Email"/>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-2">Password:</label>
                                <div class="col-sm-6">
                                    <input type="password" class="form-control" name="password"
                                           placeholder="Enter Password"/>
                                    <a id="forget">forgot password</a>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success">Login</button>
                                    <button type="reset" class="btn btn-primary">Clear</button>
                                </div>
                            </div>


                        </form>
                    </div>

                    <div id="signin">
                        <br>
                        <h2 style="display: inline;">Personal Account Free SignIn &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
                        <button type="button" class="btn btn-success" id="business"><h4>Business Account Free
                            SignIn&nbsp;>></h4>
                        </button>
                        <hr>
                        <form method="post" class="form-horizontal" action="/vehicleOwner/addVehicleOwner"
                              name="addVehicleOwner">

                            <div class="form-group">
                                <label class="control-label col-sm-2">First Name:</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="vehicleOwnerFName"
                                           name="vehicleOwnerFName"
                                           placeholder="Enter Name"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">Last Name:</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="vehicleOwnerLName"
                                           placeholder="Enter Name"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">NIC:</label>
                                <div class="col-sm-6">
                                    <input type="text" id="nic" class="form-control" onkeyup="checkNIC()"
                                           onkeydown="checkNIC()" name="nic"
                                           placeholder="Enter National ID"/>
                                    <label id="Lnic"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">Address:</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="address"
                                           placeholder="Enter Address"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">Contact Number:</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="ownerContactNumber"
                                           placeholder="Enter Address"/>
                                </div>
                            </div>


                            <input id="email_verified" type="hidden" name="emailVerified"/>
                            <div class="form-group">
                                <label class="control-label col-sm-2">Email:</label>
                                <div class="col-sm-6">
                                    <input id="emailtxt" type="email" class="form-control" name="email"
                                           placeholder="Enter Email"
                                           onblur="checkEmail(this.value)" onkeyup="checkEmail(this.value)" required/>
                                    <label id="validEmail"></label>
                                    <button id="emailBtn" type="button" class="btn btn-primary" onclick="sendEmail()">
                                        Send
                                        Verification Code
                                    </button>
                                    <br>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">Password:</label>
                                <div class="col-sm-6">
                                    <input type="password" id="passBox" class="form-control" name="password"
                                           placeholder="Enter Password" required/>
                                    <input type="checkbox"
                                           onclick="if(this.checked)passBox.type='text';else passBox.type='password';"/>
                                    show
                                    characters
                                    <br>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">Retype Password:</label>
                                <div class="col-sm-6">
                                    <input type="password" id="repassBox" class="form-control" name="passwordConfirm"
                                           placeholder="Re-type Password" required/>
                                    <input type="checkbox"
                                           onclick="if(this.checked)repassBox.type='text';else repassBox.type='password';"/>
                                    show
                                    characters
                                    <br>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success">SignIn</button>
                                    <button type="reset" class="btn btn-primary">Clear</button>
                                </div>
                            </div>

                        </form>
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

