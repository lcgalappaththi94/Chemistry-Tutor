<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
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
                <th>ප්‍රශ්නය</th><th>Search</th><th>Update</th> <th>Delete</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<Question> quesList = (ArrayList<Question>) request.getAttribute("quesList");

                for (Question question : quesList) {
            %>
            <tr class="add-row">
                    <%
                    String q = question.getQuesNo();
                %>
                <td class="ques"><% out.print(question.getQues()); %></td>
                        <td> <form method="post" action="/viewQues">
                            <input type="hidden" name="quesNo" value="<%=q%>">
                            <button class="btn btn-info" type="submit">Search</button>
                        </form> </td>
                        <td> <form method="post" action="/searchQues">
                            <input type="hidden" name="quesNo" value="<%=q%>">
                            <button class="btn btn-info" type="submit">Update</button>
                        </form> </td>
                        <td> <form method="post" onsubmit="return confirm('Do you really want to delete the Question ?');" action="/deleteQues">
                            <input type="hidden" name="quesNo" value="<%=q%>">
                            <button class="btn btn-info" type="submit">Delete</button>
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