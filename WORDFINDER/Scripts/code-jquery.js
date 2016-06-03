$(document).ready(function () {

    initWebRequest();

    $('#txFilter,#txRequest').keyup(function () {
        var text = $('#txRequest').val();
        var filter = $('#txFilter').val();
        text = text.replace(/(\r\n|\n|\r)/gm, " ");
        filter = filter.replace(/(\r\n|\n|\r)/gm, " ");
        text = text.replace(/'/g, "\\'");
        callWebRequest(text, filter);
    });
});




function initWebRequest() {

  
        var urlRequest = "WebServiceStatistics.asmx/GetZorkText";

        $.ajax({
            url: urlRequest,
            type: "POST",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: "{}",
            success: function (result) {
                var data = result.d;             
                $('#txRequest').text(data.payload);
                var starttext = $('#txRequest').text();
                var startfilter = $('#txFilter').text();
                starttext = starttext.replace(/(\r\n|\n|\r)/gm, " ");
                starttext = starttext.replace(/'/g, "\\'");
                startfilter = startfilter.replace(/(\r\n|\n|\r)/gm, " ");
                callWebRequest(starttext, startfilter);
            },

            error: function (xhr, status, error) {
                alert('error');
                var err = eval("(" + xhr.responseText + ")");
                $("#divResult").html(err.Message)
            }
        });
 




}

function callWebRequest(requestdata, filterdata) {

    var urlRequest = "WebServiceStatistics.asmx/GetTextStatistics";

    $.ajax({
        url: urlRequest,
        type: "POST",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",

        data: "{" +
              "  paragraph : '" + requestdata + "' , " +
              "  filter    : '" + filterdata + "'  " +
              "}",

        success: function (result) {
            var data = result.d;
            var text = makeTable(data);
            $("#divResultInner").html(text);
            $("#divResultInner").css('width', '100%');
        },

        error: function (xhr, status, error) {
            var err = eval("(" + xhr.responseText + ")");
            $("#divResult").html(err.Message)
        }
    });
}

function makeTable(obj) {
    var html = '<table>';
    for (var i = 0; i < obj.length ; i++) {
        html += '<tr>';
        html += '<td>' + obj[i].key + '</td>';
        html += '<td>' + obj[i].payload + '</td>';
        html += '</tr>';
    }
    html += '</table>';
    return html;
}