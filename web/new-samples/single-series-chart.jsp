<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="fusioncharts.FusionCharts" %>
<!DOCTYPE html>
<html>
    <head>
        <title>FusionCharts || www.fusioncharts.com</title>
        <script src="../scripts/fusioncharts.js"></script>
        <script src="../scripts/themes/fusioncharts.theme.fint.js"></script>
    </head>
    <body>
         <div id="chart"></div>
        <%
            FusionCharts columnChart= new FusionCharts(
            "column2d",// chartType
            "chart1",// chartId
            "550","350",// chartWidth, chartHeight
            "chart",// chartContainer
            "json",// dataFormat
            "{\"chart\": {\"caption\": \"Harry\'s SuperMart - Top 5 Stores' Revenue\", \"subCaption\": \"Last Quarter\", \"numberPrefix\": \"$\", \"rotatevalues\": \"0\", \"plotToolText\": \"<div><b>$label</b><br/>Sales : <b>$$value</b></div>\", \"theme\": \"fint\"}, \"data\": [{\"label\": \"Bakersfield Central\", \"value\": \"880000\"}, {\"label\": \"Garden Groove harbour\", \"value\": \"730000\"}, {\"label\": \"Los Angeles Topanga\", \"value\": \"590000\"}, {\"label\": \"Compton-Rancho Dom\", \"value\": \"520000\"}, {\"label\": \"Daly City Serramonte\", \"value\": \"330000\"}] }"
            );
           
            %>
            
            <%=columnChart.render()%>
    </body>
</html>
