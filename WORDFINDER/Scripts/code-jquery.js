$(document).ready(function () {
    initWebRequest();
    $('#txFilter,#txRequest').keyup(function () {
        var text = $('#txRequest').val();
        var filter = $('#txFilter').val();
        callWebRequest(text, filter);
    });
});


function initWebRequest() {
    var filter = 'ZORK ADVENTURE';
    $("#txFilter").val(filter);
    var urlRequest = "WEBSERVICE/WebServiceStatistics.asmx/GetZorkText";
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
            var startfilter = filter;
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

    requestdata = requestdata.replace(/(\r\n|\n|\r)/gm, " ");
    requestdata = requestdata.replace(/'/g, "\\'");
    filterdata = filterdata.replace(/(\r\n|\n|\r)/gm, " ");


    var urlRequest = "WEBSERVICE/WebServiceStatistics.asmx/GetTextStatistics";
    $.ajax({
        url: urlRequest,
        type: "POST",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        data: "{" +
              "  paragraph : '" + escape(requestdata) + "' , " +
              "  filter    : '" + escape(filterdata) + "'  " +
              "}",
        success: function (result) {
            var data = result.d;
            var text = makeTable(data);
            $("#divResponse").html(text);
            $("#divResponse").css('width', '100%');
        },
        error: function (xhr, status, error) {
            var err = eval("(" + xhr.responseText + ")");
            $("#divResponse").html(err.Message)
        }
    });
}

function makeTable(objArray) {
    var html = '<table>';
    html += '<tr><td>STARTING LETTER</td><td>WORD COUNT</td></tr>';
    $.each(objArray, function (index, value) { html += '<tr><td>' + value.key + '</td><td>' + value.payload + '</td></tr>'; });
    html += '</table>';
    return html;
}