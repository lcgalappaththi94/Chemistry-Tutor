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
            <form method="GET" action="allQuesByMe">
                <button class="btn btn-info" value="තමා විසින් එක්කල ප්‍රශ්න සියල්ල">තමා විසින් එක්කල ප්‍රශ්න සියල්ල</button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>
            <form method="GET" action="allQues">
                <button class="btn btn-primary" value="ප්‍රශ්න සියල්ල">ප්‍රශ්න සියල්ල</button>
                <input type="hidden" name="currentPage" value="1"/>
            </form>
            <form method="GET" action="addQ">
                <button class="btn btn-success" value="නව ප්‍රශ්නයක් එක් කීරීමට">නව ප්‍රශ්නයක් එක් කීරීමට</button>
            </form>
            <form method="GET" action="topic">
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