<%-- 
    Document   : staticXmlString
    Author     : suvradip saha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Loading Data from a Static XML String - fusioncharts.com</title>  
<!-- Step 1: Include the `fusioncharts.js` file. This file is needed to
        render the chart. Ensure that the path to this JS file is correct.
        Otherwise, it may lead to JavaScript errors.
--> 
    <script src="../scripts/fusioncharts.js"></script>
    </head>
    <body>
        <div id="chart"></div>
         
<!--    Step 2: Include the `FusionCharts.java` file as a package in your 
        project.
-->
        <%@page import="fusioncharts.FusionCharts" %>
        
<!--    Step 3:Include the package in the file where you want to show 
        FusionCharts as follows.
        
        Step 4: Create a chart object using the FusionCharts JAVA class 
        constructor. Syntax for the constructor: 
        `FusionCharts("type of chart", "unique chart id", "width of chart",
                        "height of chart", "div id to render the chart", 
                        "data format", "data source")`   
-->          
    <%
            FusionCharts lineChart = new FusionCharts(
                        "line",// chartType
                        "myFirstChart",// chartId
                        "600","400",// chartWidth, chartHeight
                        "chart",// chartContainer
                        "xml",// dataFormat
                        "<chart caption=\"Total footfall in Bakersfield Central\" subcaption=\"Last week\" xaxisname=\"Day\" yaxisname=\"No. of Visitors\" linethickness=\"2\" palettecolors=\"#0075c2\" basefontcolor=\"#333333\" basefont=\"Helvetica Neue,Arial\" captionfontsize=\"14\" subcaptionfontsize=\"14\" subcaptionfontbold=\"0\" showborder=\"0\" bgcolor=\"#ffffff\" showshadow=\"0\" canvasbgcolor=\"#ffffff\" canvasborderalpha=\"0\" divlinealpha=\"100\" divlinecolor=\"#999999\" divlinethickness=\"1\" divlinedashed=\"1\" divlinedashlen=\"1\" divlinegaplen=\"1\" showxaxisline=\"1\" xaxislinethickness=\"1\" xaxislinecolor=\"#999999\" showalternatehgridcolor=\"0\">   <set label=\"Mon\" value=\"15123\" />   <set label=\"Tue\" value=\"14233\" />   <set label=\"Wed\" value=\"23507\" />   <set label=\"Thu\" value=\"9110\" />   <set label=\"Fri\" value=\"15529\" />   <set label=\"Sat\" value=\"20803\" />   <set label=\"Sun\" value=\"19202\" />  </chart>"
                    );
        
        %>
<!--    Step 5: Render the chart    -->          
        <%=lineChart.render()%>
        
    </body>
</html>

