<%@ page import="java.util.ArrayList" %>
<%@ page import="com.codex.dialog.model.QueAuther" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Questions</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript">
        var currentPage = 0;
        var length = 0;
        var pages = 0;
        var newWindow = null;


        function init() {
            length = <%=(int)request.getAttribute("length")%>;
            currentPage = <%=(int)request.getAttribute("currentPage")%>;
            pages = Math.ceil(length / 10);
            $("#pagination-demo").html(
                "<li class='pag_prev'><a onclick='previous()' aria-label='Previous'><span aria-hidden='true'>&laquo;</span> </a> </li>"
                + "<li class='pag_next'> <a onclick='next()' aria-label='Next'> <span aria-hidden='true'>&raquo;</span> </a> </li>"
            );
            if (currentPage >= 5) {
                for (i = (currentPage - 4); i < pages + (currentPage - 5); i++) {
                    if (i < 5 + (currentPage - 4)) {
                        if (i < pages) {
                            $("#pagination-demo").append("<li><a id='" + (i + 1) + "' onclick='transition(this)'><b>" + (i + 1) + "</b></a></li>");
                        }
                    } else {
                        if (i == pages - 1) {
                            $("#pagination-demo").append("<li><a><b>...</b></a></li>");
                            $("#pagination-demo").append("<li><a id='" + (i + 1) + "' onclick='transition(this)'><b>" + (i + 1) + "</b></a></li>");
                        }
                    }
                }
            } else {
                for (i = 0; i < pages; i++) {
                    if (i < 5) {
                        $("#pagination-demo").append("<li><a id='" + (i + 1) + "' onclick='transition(this)'><b>" + (i + 1) + "</b></a></li>");
                    } else {
                        if (i == pages - 1) {
                            $("#pagination-demo").append("<li><a><b>...</b></a></li>");
                            $("#pagination-demo").append("<li><a id='" + (i + 1) + "' onclick='transition(this)'><b>" + (i + 1) + "</b></a></li>");
                        }
                    }
                }
            }
            document.getElementById('' + currentPage).style.color = '#FF0000';
            document.getElementById("pageDetail").innerHTML = "<b>Page " + currentPage + " of " + pages + "</b>";
        }

        function transition(pageNumber) {
            currentPage = pageNumber.innerHTML.replace("<b>", "").replace("</b>", "");
            redirect();
        }

        function redirect() {
            window.location = "allQues?currentPage=" + currentPage;
            document.getElementById('' + currentPage).style.color = '#FF0000';
        }

        function next() {
            if (currentPage < pages) {
                currentPage++;
                redirect();
            }
        }

        function previous() {
            if (currentPage > 1) {
                currentPage--;
                redirect();
            }
        }

        function readMore(questionNumber) {
            if (newWindow != null) {
                newWindow.close();
            }
            newWindow = window.open('/viewQues?quesNo=' + questionNumber, 'Question No ' + questionNumber,
                'width=' + window.innerWidth * 0.8 + ',height=' + window.innerHeight * 0.8 + ',directories=0,toolbar=0,location=0,status=0,scrollbars=0,resizable=1,left=' + window.innerWidth * 0.1 + ',top=' + window.innerHeight * 0.2 + '');

        }

    </script>

</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body onload="init()">

<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1>සියලුම ප්‍රශ්න</h1>
        </div>
        <table id="services" class="table table-striped table-hover table-users">
            <thead>
            <tr>
                <th>ප්‍රශ්නය</th>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<QueAuther> quesList = (ArrayList<QueAuther>) request.getAttribute("quesList");
                int length = quesList.size();
                for (int i = 0; i < length; i++) {
                    QueAuther question = quesList.get(i);
            %>
            <input type="hidden" id="length" value="<%=length%>"/>

            <tr class="add-row">
                    <%
                    String q = question.getQuesNo();
                    StringBuilder questionWithAuthor = new StringBuilder(question.getQues());
                    questionWithAuthor.append("\n").append("- ").
                    append(question.getDesig()).append(".").append(question.getAutherName()).append(" -");
                    %>
                <td class="ques"><% out.print(questionWithAuthor); %></td>
                <td>
                    <button class="btn btn-info" onclick="readMore(<%=q%>)">Read More</button>
                </td>
                    <%}%>
            </tbody>
        </table>
        <hr>
        &nbsp;
        &nbsp;

        <ul class="pagination" id="pagination-demo"></ul>

        &nbsp;
        &nbsp;
        <span class="form-control" id="pageDetail"></span>
    </div>
</div>

</body>

<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>

</html>