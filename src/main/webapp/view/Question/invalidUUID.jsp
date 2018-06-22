<%@ page import="com.codex.dialog.model.Auther" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Not Found</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<div id="header">
    <%@ include file="../fragments/loginHeader.jspf" %>
</div>

<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1 style="color: #0f0f0f">404 Not Found (Try Again)</h1>
        </div>

        <div class="panel-body">
          <h2 style="color: red">${msg}</h2>
        </div>
    </div>
</div>
</body>

<%--<div id="footer">--%>
<%--<%@ include file="../fragments/footer.jspf" %>--%>
<%--</div>--%>

</html>