<%-- 
    Document   : JsonExample
    Author     : suvradip saha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.google.gson.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loading Data from a JSON String Generated from an Array - Fusioncharts.com</title>
<!-- Step 1: Include the `fusioncharts.js` file. This file is needed to
        render the chart. Ensure that the path to this JS file is correct.
        Otherwise, it may lead to JavaScript errors.
-->
        <script src="../scripts/fusioncharts.js"></script>
        <!-- End -->
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
        /* 
            google-gson
    
            Gson is a Java library that can be used to convert Java Objects 
            into their JSON representation. It can also be used to convert a
            JSON string to an equivalent Java object. Gson can work with 
            arbitrary Java objects including
            pre-existing objects that you do not have source-code of.
            link : https://github.com/google/gson  
            
         */
            Gson gson = new Gson();
            
            // The 'chartobj' map object holds the chart attributes and data.
            Map<String, String> chartobj = new HashMap<String, String>();
            
            chartobj.put("caption", "Split of Visitors by Age Group");
            chartobj.put("subCaption" , "Last year");
            chartobj.put("paletteColors" , "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000");
            chartobj.put("bgColor" , "#ffffff");
            chartobj.put("showBorder" , "0");
            chartobj.put("use3DLighting" , "0");
            chartobj.put("showShadow" , "0");
            chartobj.put("enableSmartLabels" , "0");
            chartobj.put("startingAngle" , "0");
            chartobj.put("showPercentValues" , "1");
            chartobj.put("showPercentInTooltip" , "0");
            chartobj.put("decimals" , "1");
            chartobj.put("captionFontSize" , "14");
            chartobj.put("subcaptionFontSize" , "14");
            chartobj.put("subcaptionFontBold" , "0");
            chartobj.put("toolTipColor" , "#ffffff");
            chartobj.put( "toolTipBorderThickness" , "0");
            chartobj.put("toolTipBgColor" , "#000000");
            chartobj.put("toolTipBgAlpha" , "80");
            chartobj.put("toolTipBorderRadius" , "2");
            chartobj.put("toolTipPadding" , "5");
            chartobj.put("showHoverEffect" , "1");
            chartobj.put("showLegend" , "1");
            chartobj.put("legendBgColor" , "#ffffff");
            chartobj.put("legendBorderAlpha" , "0");
            chartobj.put("legendShadow" , "0");
            chartobj.put("legendItemFontSize" , "10");
            chartobj.put("legendItemFontColor" , "#666666");
            chartobj.put("useDataPlotColorForLabels" , "1");
            
        /*
             The data to be plotted on the chart is stored in the 
            'actualData' map object  in the key-value form.
        */
            Map<String, String> actualData = new HashMap<String, String>();
            
            actualData.put("Teenage" , "1250400");
            actualData.put("Adult" , "1463300");
            actualData.put("Mid-age" , "1050700");
            actualData.put("Senior" , "491000");
           
        /*
            Convert the data in the `actualData` object into a format that can
            be consumed by FusionCharts. The data for the chart should be in an 
            array wherein each element of the array is a JSON object having the
            "label" and “value” as keys.
        */   
            
            ArrayList arrData = new ArrayList();
        /*
            Iterate through the data in `actualData` and insert in
            to the `$arrData` array.
        */ 
            for(Map.Entry m:actualData.entrySet()){
                 
                Map<String, String> lv = new HashMap<String, String>();
                lv.put("label", (String) m.getKey());
                lv.put("value", (String) m.getValue());
                arrData.add(lv);
            }    
            
            //create 'dataMap' map object to make a complete FC datasource.
             Map<String, String> dataMap = new LinkedHashMap<String, String>();  
        /*
            gson.toJson() the data to retrieve the string containing the
            JSON representation of the data in the array.
        */  
             dataMap.put("chart", gson.toJson(chartobj));
             dataMap.put("data", gson.toJson(arrData));

            FusionCharts columnChart= new FusionCharts(
            "pie2d",// chartType
                        "chart1",// chartId
                        "600","400",// chartWidth, chartHeight
                        "chart",// chartContainer
                        "json",// dataFormat
                        gson.toJson(dataMap) //dataSource
                    );
           
            %>
<!--    Step 5: Render the chart    -->            
            <%=columnChart.render()%>
            
            
    </body>
</html>
