<%-- 
    Document   : introduction
    Author     : suvradip saha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Introduction JSP </title>
<!-- Step 1: Include the `fusioncharts.js` file. This file is needed to
        render the chart. Ensure that the path to this JS file is correct.
        Otherwise, it may lead to JavaScript errors.
-->        
        <script src="scripts/fusioncharts.js"></script>
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
            FusionCharts columnChart= new FusionCharts(
            "column2d",// chartType
                        "chart1",// chartId
                        "600","400",// chartWidth, chartHeight
                        "chart",// chartContainer
                        "json",// dataFormat
                        "{   \"chart\": {  \"caption\": \"Monthly revenue for last year\",                   \"subCaption\": \"Harry’s SuperMart\",                   \"xAxisName\": \"Month\",                   \"yAxisName\": \"Revenues (In USD)\",                   \"numberPrefix\": \"$\",                   \"paletteColors\": \"#0075c2\",                   \"bgColor\": \"#ffffff\",                   \"borderAlpha\": \"20\",                   \"canvasBorderAlpha\": \"0\",                   \"usePlotGradientColor\": \"0\",                   \"plotBorderAlpha\": \"10\",                   \"placeValuesInside\": \"1\",                   \"rotatevalues\": \"1\",                   \"valueFontColor\": \"#ffffff\",                   \"showXAxisLine\": \"1\",                   \"xAxisLineColor\": \"#999999\",                   \"divlineColor\": \"#999999\",                   \"divLineIsDashed\": \"1\",                   \"showAlternateHGridColor\": \"0\",                   \"subcaptionFontSize\": \"14\",                   \"subcaptionFontBold\": \"0\"               },               \"data\": [{                   \"label\": \"Jan\",                   \"value\": \"420000\"               }, {                   \"label\": \"Feb\",                   \"value\": \"810000\"               }, {                   \"label\": \"Mar\",                   \"value\": \"720000\"               }, {                   \"label\": \"Apr\",                   \"value\": \"550000\"               }, {                   \"label\": \"May\",                   \"value\": \"910000\"               }, {                   \"label\": \"Jun\",                   \"value\": \"510000\"               }, {                   \"label\": \"Jul\",                   \"value\": \"680000\"               }, {                   \"label\": \"Aug\",                   \"value\": \"620000\"               }, {                   \"label\": \"Sep\",                   \"value\": \"610000\"               }, {                   \"label\": \"Oct\",                   \"value\": \"490000\"               }, {                   \"label\": \"Nov\",                   \"value\": \"900000\"               }, {                   \"label\": \"Dec\",                   \"value\": \"730000\"               }]           }"
                    );
           
            %>
<!--    Step 5: Render the chart    -->            
            <%=columnChart.render()%>
        
    </body>
</html>
