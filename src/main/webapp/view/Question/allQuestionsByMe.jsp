<%@ page import="com.codex.dialog.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Questions By Me</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="//cdn.jsdelivr.net/npm/mobile-detect@1.4.1/mobile-detect.min.js"></script>
    <script type="text/javascript">
        var currentPage = 0;
        var length = 0;
        var pages = 0;
        var isMobile;

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
            clearSpan();
            var md = new MobileDetect(window.navigator.userAgent);
            var os = md.os();
            if (os == "AndroidOS" || os == "iOS")
                isMobile = true;
            else
                isMobile = false;
        }

        function transition(pageNumber) {
            currentPage = pageNumber.innerHTML.replace("<b>", "").replace("</b>", "");
            redirect();
        }

        function redirect() {
            window.location = "allQuesByMe?currentPage=" + currentPage;
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

        function clearSpan() {
            setTimeout(clearSpanNow, 1500);
        }

        function clearSpanNow() {
            document.getElementById("msg").innerHTML = "";
        }

        function editQuestion() {
            if(isMobile==true){
                alert("Not Supported on mobile devices try again using a desktop");
                return false;
            }else{
                return true;
            }
        }
    </script>

    <style type="text/css">
        form {
            display: inline;
        }

        .tile {
            border: 1px solid #cbcbcb;
            border-radius: 5px;
            padding: 5px 5px 5px 5px;
            background-color: #ffffff;
        }
    </style>

</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body onload="init()">
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h1>තමා විසින් එක්කල ප්‍රශ්න සියල්ල &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span id="msg" style="background-color: #0f0f0f">${msg}</span></h1>
        </div>
        <%
            ArrayList<Question> quesList = (ArrayList<Question>) request.getAttribute("quesList");
            if (!quesList.isEmpty()) {%>
        <div class="panel-body">


            <% for (Question question : quesList) {%>
            <%
                String q = question.getQuesNo();
            %>
            <div class="tile">
                <h4><% out.print(question.getQues()); %></h4>
            <hr>

            <form method="post" action="/viewQues">
                <input type="hidden" name="quesNo" value="<%=q%>">
                <input type="hidden" name="currentPage"
                       value="<%=(int)request.getAttribute("currentPage")%>">
                <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                <input type="hidden" name="allQuestions" value="0">
                <button class="btn btn-info" type="submit">Read More</button>
            </form>


            <form method="post" action="/searchQues" onsubmit="return editQuestion();">
                <input type="hidden" name="quesNo" value="<%=q%>">
                <input type="hidden" name="currentPage"
                       value="<%=(int)request.getAttribute("currentPage")%>">
                <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                <input type="hidden" name="allQuestions" value="0">
                <button class="btn btn-info" type="submit">Edit</button>
            </form>

            <form method="post"
                  onsubmit="return confirm('Do you really want to delete the Question ?');"
                  action="/deleteQues">
                <input type="hidden" name="quesNo" value="<%=q%>">
                <input type="hidden" name="currentPage"
                       value="<%=(int)request.getAttribute("currentPage")%>">
                <input type="hidden" name="length" value="<%=(int)request.getAttribute("length")%>">
                <input type="hidden" name="allQuestions" value="0">
                <button class="btn btn-info" type="submit">Delete</button>
            </form>
        </div>
        <br>

        <%
            }
        } else {
        %>
        <h1 style="border: 1px solid #cbcbcb;
            border-radius: 5px;
            padding: 10px 10px 10px 10px;
            background-color: #eeedef;">තවම කිසිවක් නැත.</h1>
        <%}%>
        <hr>

        &nbsp;
        &nbsp;
        <ul class="pagination" id="pagination-demo"></ul>

        &nbsp;
        &nbsp;
        <span class="form-control" id="pageDetail"></span>
    </div>
</div>
</div>
</body>

<%--<div id="footer">--%>
    <%--<%@ include file="../fragments/footer.jspf" %>--%>
<%--</div>--%>

</html>