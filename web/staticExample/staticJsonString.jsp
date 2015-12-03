<%-- 
    Document   : staticJsonString
    Author     : suvradip saha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <title>Loading Data from a Static JSON String - fusioncharts.com</title>
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
        FusionCharts area2dChart = new FusionCharts(
                    "Area2D",// chartType
                    "myFirstChart",// chartId
                    "600","400",// chartWidth, chartHeight
                    "chart",// chartContainer
                    "json",// dataFormat
                    "{  \"chart\": {  \"caption\": \"Sales of Liquor\",  \"subCaption\": \"Last week\", \"xAxisName\": \"Day\",  \"yAxisName\": \"Sales (In USD)\",    \"numberPrefix\": \"$\",   \"paletteColors\": \"#0075c2\",  \"bgColor\": \"#ffffff\",    \"showBorder\": \"0\",    \"showCanvasBorder\": \"0\",    \"plotBorderAlpha\": \"10\",    \"usePlotGradientColor\": \"0\",    \"plotFillAlpha\": \"50\",    \"showXAxisLine\": \"1\",    \"axisLineAlpha\": \"25\",    \"divLineAlpha\": \"10\",    \"showValues\": \"1\",    \"showAlternateHGridColor\": \"0\",    \"captionFontSize\": \" 14\",    \"subcaptionFontSize\": \"14\",    \"subcaptionFontBold\": \"0\",    \"toolTipColor\": \"#ffffff\",    \"toolTipBorderThickness\": \"0\",    \"toolTipBgColor\": \"#000000\",    \" toolTipBgAlpha\": \"80\",    \"toolTipBorderRadius\": \"2\",    \"toolTipPadding\": \"5\"                                                },                                                \"data\": [{    \"label\": \" Mon\",    \" value\": \"4123\"                                                }, {    \"label\": \"Tue\",    \"value\": \"  4633\"  }, {    \"label\": \"Wed\",    \"value\": \"5507\"                                                }, {    \"label\": \"Thu\",    \"value\": \"4910\"                                                }, {    \"label\": \"Fri\",    \"value\": \"5529\"                                                }, {    \"label\": \"Sat\",    \"value\": \"5803\"                                                }, {    \"label\": \"Sun\",    \"value\": \"6202\"   }]  }"
                );
        
        %>
<!--    Step 5: Render the chart    -->          
        <%=area2dChart.render()%>
        
    </body>
</html>

