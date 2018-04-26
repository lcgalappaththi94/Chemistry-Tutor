<%--
  Created by IntelliJ IDEA.
  User: tharindu
  Date: 11/19/17
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Home</title>
    <script type="text/javascript">
        function successs() {
            window.alert("Operation Failed")
        }
    </script>
</head>
<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>
<body onload="successs()">
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>My Dashboard</h1></div>
        <div class="panel-body">
            <form method="get" action="allQuesByMe">
                <button class="btn btn-info" value="තමා විසින් එක්කල ප්‍රශ්න සියල්ල">තමා විසින් එක්කල ප්‍රශ්න සියල්ල</button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>
            <form method="get" action="allQues">
                <button class="btn btn-primary" value="ප්‍රශ්න සියල්ල">ප්‍රශ්න සියල්ල</button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>
            <form method="get" action="addQ">
                <button class="btn btn-success" value="නව ප්‍රශ්නයක් එක් කීරීමට">නව ප්‍රශ්නයක් එක් කීරීමට</button>
            </form>
            <form method="get" action="topic">
                <button class="btn btn-danger" value="නව මාතෘකාවක් එක් කීරීමට">නව මාතෘකාවක් එක් කීරීමට</button>
            </form>
            <form method="POST" action="getAuthor">
                <button class="btn btn-warning" value="ඔබගේ ගිණුම වෙත පිවිසෙන්න">ඔබගේ ගිණුම වෙනස් කිරීමට</button>
            </form>
        </div>
    </div>
</div>
</body>
<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>
</html>
