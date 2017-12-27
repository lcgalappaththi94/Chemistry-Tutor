<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script type="text/javascript">

        $.fn.superScript = function() {
            var chars = '+−=()0123456789AaÆᴂɐɑɒBbcɕDdðEeƎəɛɜɜfGgɡɣhHɦIiɪɨᵻɩjJʝɟKklLʟᶅɭMmɱNnɴɲɳŋOoɔᴖᴗɵȢPpɸrRɹɻʁsʂʃTtƫUuᴜᴝʉɥɯɰʊvVʋʌwWxyzʐʑʒꝯᴥβγδθφχнნʕⵡ',
                sup   = '⁺⁻⁼⁽⁾⁰¹²³⁴⁵⁶⁷⁸⁹ᴬᵃᴭᵆᵄᵅᶛᴮᵇᶜᶝᴰᵈᶞᴱᵉᴲᵊᵋᶟᵌᶠᴳᵍᶢˠʰᴴʱᴵⁱᶦᶤᶧᶥʲᴶᶨᶡᴷᵏˡᴸᶫᶪᶩᴹᵐᶬᴺⁿᶰᶮᶯᵑᴼᵒᵓᵔᵕᶱᴽᴾᵖᶲʳᴿʴʵʶˢᶳᶴᵀᵗᶵᵁᵘᶸᵙᶶᶣᵚᶭᶷᵛⱽᶹᶺʷᵂˣʸᶻᶼᶽᶾꝰᵜᵝᵞᵟᶿᵠᵡᵸჼˤⵯ';

            return this.each(function() {
                this.value = this.value.replace(/<sup[^>]*>(.*?)<\/sup>/g, function(x) {
                    var str = '',
                        txt = $.trim($(x).unwrap().text());

                    for (var i=0; i<txt.length; i++) {
                        var n = chars.indexOf(txt[i]);
                        str += (n!=-1 ? sup[n] : txt[i]);
                    }
                    return str;
                });
            });
        }
        $('input').superScript();

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

        function sendRequest() {
            var url = "allTopics";

            var request = createXMLHttpRequest();
            request.open("GET", url, true);
            request.send(null);
            request.onreadystatechange = function () {
                if (request.readyState == 4) {
                    if (request.status == 200) {
                        var output = request.responseText;
                        document.getElementById('combo').innerHTML = output;
                    }
                }
            }
        }
        function validate(form) {
            if (form.getElementById("combo")!=null){
                return true;
            }else{
                alert('Subject is empty ..!');
                return false;
            }

        }

    </script>
    <title>New Question</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<div id="header">
    <%@ include file="../fragments/header.jspf" %>
</div>

<body onload="sendRequest();">
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>නව ප්‍රශ්නයක්</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/questionAdd" onsubmit="return validate(this);" name="addQuestion">
                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්ණයට අදාළ මාතෘකාව:</label>
                    <div id="combo" class="col-sm-6">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">ප්‍රශ්නය අතුලත් කරන්න</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" rows="4" cols="50" name="ques"
                                  placeholder="ඔබගේ ප්‍රශ්නය ඇතුලත් කරන්න" required></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 1:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw1" placeholder="පලවන පිළිතුර" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 2:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw2" placeholder="දෙවන පිළිතුර" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 3:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw3" placeholder="තෙවන පිළිතුර" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 4:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw4" placeholder="හතරවන පිළිතුර" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">පිළිතුර 5:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="anw5" placeholder="පස්වන පිළිතුර" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">වෙනත් මාධ්‍ය:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="media"
                               placeholder="ප්‍රශ්නයට අදාල video, Gif, පින්තුර , වෙනත්  මාධ්‍යය "/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">නිවරදි පිළිතුරේ අංකය :</label>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" name="corAnw"
                               placeholder="නිවරදි පිළිතුරට අදාල  අංකය" min="1" max="5" required/>
                    </div>
                </div>
                <div class="selectpicker">
                    <label class="control-label col-sm-2">ප්‍රශ්නයේ අපහසුතාවය:</label>
                    <div class="col-sm-3">
                        <select name="diff">
                            <option selected value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                        </select>

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