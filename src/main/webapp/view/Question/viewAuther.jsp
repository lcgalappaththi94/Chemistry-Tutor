<%@ page import="com.codex.dialog.model.Auther" %><%--
  Created by IntelliJ IDEA.
  User: tharindu
  Date: 11/25/17
  Time: 12:17 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Author details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

        function sendRequest(doc) {
            var url = "checkOldVal?email=" + doc.email.value + "&pass=" + doc.oPassword.value;
            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        if (!(output === "1")) {
                            window.alert("Password give does not match with the previous one");
                            doc.oPassword.value = "";
                        }
                    }
                    /*else{
                        window.alert("Password give does not match with the previous one");
                        doc.oPassword.value = "";
                    }*/
                }
            }
        }

        function passwordVal(doc) {
            var password = doc.password.value;
            var cPassword = doc.cPassword.value;
            var isConfPassValidated = true;
            if (!(password === cPassword)) {
                isConfPassValidated = false
                window.alert("Passwords are not equal");
                doc.password.value = "";
                doc.cPassword.value = "";
                doc.oPassword.value = "";
            }
            console.log("isConfPassValidated :" + isConfPassValidated)
            return isConfPassValidated;
        }

        function checkPasswordFields(doc) {
            var password = doc.password.value;
            var cPassword = doc.cPassword.value;
            var oPassword = doc.oPassword.value;
            var isFieldValidated = false;
            if ((!(password === "") || !(cPassword === "") || !(oPassword === "")) && (!(password === "") && !(cPassword === "") && !(oPassword === ""))) {
                isFieldValidated = true;
            } else if ((password === "") && (cPassword === "") && (oPassword === "")) {
                isFieldValidated = true;
            } else {
                isFieldValidated = false;
                window.alert("If you are going to change the password. All three password fields should be filled");
                doc.password.value = "";
                doc.cPassword.value = "";
                doc.oPassword.value = "";
            }
            return isFieldValidated;
        }

        function onSubmitFunc(doc) {
            return (checkPasswordFields(doc) && passwordVal(doc));
        }
    </script>
</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body>
<div class="container">

    <%
        Auther auther = (Auther) request.getAttribute("auther");
    %>
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>Author Details</h1></div>
        <div class="panel-body">
            <form name="mod" onsubmit="return onSubmitFunc(mod);" class="form-horizontal" method="post"
                  action="/updateAuther">

                <input type="hidden" name="authId" value="<%out.print(auther.getAuthId());%>">
                <input type="hidden" name="email" value="<%out.print(auther.getEmail());%>">

                <div class="form-group">
                    <label class="control-label col-sm-3">Designation:</label>
                    <div class="col-sm-6">
                        <select name="designation" class="form-control">
                            <%if (auther.getDesig().equals("Ms")) {%>
                            <option value="Mr">Mr</option>
                            <option selected value="Ms" value="Ms">Ms</option>
                            <option value="Mrs">Mrs</option>
                            <% } else if (auther.getDesig().equals("Mr")) {%>
                            <option selected value="Mr">Mr</option>
                            <option value="Ms">Ms</option>
                            <option value="Mrs">Mrs</option>
                            <% } else if (auther.getDesig().equals("Mrs")) {%>
                            <option value="Mr">Mr</option>
                            <option value="Ms" value="Ms">Ms</option>
                            <option selected value="Mrs">Mrs</option>
                            <%}%>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">Name :</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name" value="<%=auther.getName()%>"
                               placeholder="ඔබගේ  නම ඇතුලත් කරන්න "/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">Old Password :</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="oPassword"
                               placeholder="Enter your old password (In case of changing) " onblur="sendRequest(mod);"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">New Password :</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="password"
                               placeholder="Enter your new password (In case of changing)"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3">Confirm new password :</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="cPassword"
                               placeholder="Confirm your new password (In case of changing)"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <button type="submit" class="btn btn-success">Submit</button>
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