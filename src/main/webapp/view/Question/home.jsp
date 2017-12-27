<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Home</title>
</head>
<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>
<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>My Dashboard</h1></div>
        <div class="panel-body">
            <form method="get" action="allQues">
                <button class="btn btn-info" value="ප්‍රශ්න සියල්ල">ප්‍රශ්න සියල්ල</button>
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