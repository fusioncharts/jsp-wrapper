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
            FusionCharts ganttChart= new FusionCharts(
            "gantt",// chartType
            "chart1",// chartId
            "600","400",// chartWidth, chartHeight
            "chart",// chartContainer
            "json",// dataFormat
            " {\"chart\": {\"caption\": \"Acme Industries - Mailer campaign launch\", \"subcaption\": \"Typical steps involved\", \"dateformat\": \"mm/dd/yyyy\", \"theme\": \"fint\", \"canvasBorderAlpha\": \"40\", \"showcanvasborder\": \"1\", \"plottooltext\": \"<div>Start Date : <b>$start</b><br/>End Date : <b>$end</b></div>\"}, \"categories\": [{\"category\": [{\"start\": \"08/01/2015\", \"end\": \"08/31/2015\", \"label\": \"Aug \'15\"}, {\"start\": \"09/01/2015\", \"end\": \"09/30/2015\", \"label\": \"Sep \'15\"}, {\"start\": \"10/01/2015\", \"end\": \"10/31/2015\", \"label\": \"Oct \'15\"}, {\"start\": \"11/01/2015\", \"end\": \"11/30/2015\", \"label\": \"Nov \'15\"}, {\"start\": \"12/01/2015\", \"end\": \"12/31/2015\", \"label\": \"Dec \'15\"}, {\"start\": \"01/01/2016\", \"end\": \"01/31/2016\", \"label\": \"Jan \'16\"}, {\"start\": \"02/01/2016\", \"end\": \"02/28/2016\", \"label\": \"Feb \'16\"}, {\"start\": \"03/01/2016\", \"end\": \"03/31/2016\", \"label\": \"Mar \'16\"}] }], \"processes\": {\"fontsize\": \"12\", \"isbold\": \"1\", \"align\": \"right\", \"process\": [{\"label\": \"Identify Customers\"}, {\"label\": \"Survey 500 Customers\"}, {\"label\": \"Interpret Requirements\"}, {\"label\": \"Market Analysis\"}, {\"label\": \"Brainstorm concepts\"}, {\"label\": \"Define Ad Requirements\"}, {\"label\": \"Design & Develop\"}, {\"label\": \"Mock test\"}, {\"label\": \"Documentation\"}, {\"label\": \"Start Campaign\"}] }, \"tasks\": {\"task\": [{\"start\": \"08/04/2015\", \"end\": \"08/10/2015\"}, {\"start\": \"08/08/2015\", \"end\": \"08/19/2015\"}, {\"start\": \"08/19/2015\", \"end\": \"09/02/2015\"}, {\"start\": \"08/24/2015\", \"end\": \"09/02/2015\"}, {\"start\": \"09/02/2015\", \"end\": \"09/21/2015\"}, {\"start\": \"09/21/2015\", \"end\": \"10/06/2015\"}, {\"start\": \"10/06/2015\", \"end\": \"01/21/2016\"}, {\"start\": \"01/21/2016\", \"end\": \"02/19/2016\"}, {\"start\": \"01/28/2016\", \"end\": \"02/24/2016\"}, {\"start\": \"02/24/2016\", \"end\": \"03/27/2016\"}] } }"
            );
           
            %>
            
            <%=ganttChart.render()%>
    </body>
</html>
