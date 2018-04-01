<%@ page import="java.util.ArrayList" %>
<%@ page import="com.codex.dialog.model.QueAuther" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Questions</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--<script type="javascript">

    </script>--%>
</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1>සියලුම ප්‍රශ්න</h1>
        </div>
        <table id="services" class="table table-striped table-hover table-users">
            <thead>
            <tr>
                <th>ප්‍රශ්නය</th><th>Search</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<QueAuther> quesList = (ArrayList<QueAuther>) request.getAttribute("quesList");
                for (QueAuther question : quesList) {
            %>
            <tr class="add-row">
                    <%
                    String q = question.getQuesNo();
                    StringBuilder questionWithAuthor = new StringBuilder(question.getQues());
                    questionWithAuthor.append("\n").append("- ").
                    append(question.getDesig()).append(".").append(question.getAutherName()).append(" -");
                    %>
                <td class="ques"><% out.print(questionWithAuthor); %></td>
                        <td> <form method="post" action="/viewQues">
                            <input type="hidden" name="quesNo" value="<%=q%>">
                            <button class="btn btn-info" type="submit">Search</button>
                        </form> </td>
                    <%}%>
            </tbody>
        </table>
    </div>
</div>
</body>

<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>

</html>