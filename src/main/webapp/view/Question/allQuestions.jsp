<%@ page import="com.codex.dialog.model.QueAuther" %>
<%@ page import="java.util.ArrayList" %>
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
                    String author = question.getAuthId();
                    StringBuilder questionWithAuthor = new StringBuilder(question.getQues());
                    questionWithAuthor.append("<br><i style='color:blue'>- ").
                            append(question.getDesig()).append(".").append(question.getAutherName()).append(" -</i>");
                    if (author.equals(request.getSession().getAttribute("authId"))) {
                        questionWithAuthor.append("<i style='color:blue'> (You) -<i>");
                    }
                %>
                <td class="ques"><% out.print(questionWithAuthor); %></td>
                <td>
                    <form method="post" action="/viewQues">
                        <input type="hidden" name="quesNo" value="<%=q%>">
                        <input type="hidden" name="currentPage" value="<%=(int)request.getAttribute("currentPage")%>">
                        <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                        <input type="hidden" name="allQuestions" value="1">
                        <button class="btn btn-info" type="submit">Read More</button>
                    </form>
                </td>
                <% if (author.equals(request.getSession().getAttribute("authId"))) {%>
                <td>
                    <form method="post" action="/searchQues">
                        <input type="hidden" name="quesNo" value="<%=q%>">
                        <input type="hidden" name="currentPage" value="<%=(int)request.getAttribute("currentPage")%>">
                        <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                        <input type="hidden" name="allQuestions" value="1">
                        <button class="btn btn-info" type="submit">Edit</button>
                    </form>
                </td>
                <td>
                    <form method="post" onsubmit="return confirm('Do you really want to delete the Question ?');"
                          action="/deleteQues">
                        <input type="hidden" name="quesNo" value="<%=q%>">
                        <input type="hidden" name="currentPage" value="<%=(int)request.getAttribute("currentPage")%>">
                        <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                        <input type="hidden" name="allQuestions" value="1">
                        <button class="btn btn-info" type="submit">Delete</button>
                    </form>
                </td>
                <%
                        }
                    }
                %>
            </tr>
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