<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add New Topic</title>
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

        function sendRequest(form) {
            var url = "isTopic?topic="+form.value;
            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        if (output === "0"){
                            window.alert("Topic already exists. please re-enter ....");
                            document.getElementById("topic").value = "";
                        }
                    }
                }
            }
        }
    </script>
</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body>

<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>නව මාතෘකාවක්</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/add">

                <div class="form-group">
                    <label class="control-label col-sm-2">මාතෘකාව : </label>
                    <div class="col-sm-6">
                        <input id="topic" type="text" class="form-control" name="topic" placeholder="ඔබගේ ප්‍රශ්නයට අදාල මාතෘකාව" required onblur="sendRequest(this);">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-success">Submit</button>
                        <button type="reset" class="btn btn-primary">Clear</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>

<div id="footer">
    <%@ include file="../fragments/footer.jspf" %>
</div>

</html>
