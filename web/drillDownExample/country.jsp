<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="com.google.gson.*" %>

<%
    
/* 
    The following four code lines contain the database connection information.
    Alternatively, you can move these code lines to a separate file and
    include the file here. You can also modify this code based on your 
    database connection. 
 */

   String hostdb = "localhost:3306";  // MySQl host
   String userdb = "root";  // MySQL username
   String passdb = "";  // MySQL password
   String namedb = "fusioncharts_jspsample";  // MySQL database name

    // Establish a connection to the database
    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    Connection con = DriverManager.getConnection("jdbc:mysql://" + hostdb + "/" + namedb , userdb , passdb);
   
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creating Charts with Data from a Database - fusioncharts.com</title>
<!--    Step 1: Include the `fusioncharts.js` file. This file is needed to
        render the chart. Ensure that the path to this JS file is correct.
        Otherwise, it may lead to JavaScript errors.
--> 
        <script src="../scripts/fusioncharts.js"></script>
    </head>
    <body>
         <div id="chart"></div>
         
<!--    Step 2: Include the `FusionCharts.java` file as a package in your 
        project.
    
        Step 3:Include the package in the file where you want to show 
        FusionCharts.

-->
        <%@page import="fusioncharts.FusionCharts" %>

<!--
        
        Step 4: Create a chart object using the FusionCharts JAVA class 
        constructor. Syntax for the constructor: 
        `FusionCharts("type of chart", "unique chart id", "width of chart",
                        "height of chart", "div id to render the chart", 
                        "data format", "data source")`   
-->         
        <%
         /* 
            google-gson
    
            Gson is a Java library facilitating conversion of Java objects 
            into their JSON representation and 
            JSON strings into their equivalant Java objects. 
            Gson can also work with arbitrary Java objects 
            including the pre-existing ones that 
            you may not have the source-code for. 
            Read the note below this code for more details on the google-gson library.           
         */
    
            Gson gson = new Gson();
            
            
            // Form the SQL query that returns the top 10 most populous countries
            String sqlQueryCountry="SELECT * FROM Country ORDER BY Population DESC LIMIT 10";

            // Prepare the query statement    
            PreparedStatement ptCountry=con.prepareStatement(sqlQueryCountry);  
            // Prepare the query statement
            ResultSet rsCountry=ptCountry.executeQuery();
            
            // The 'chart' map object holds the chart attributes and data.
            Map<String, String> chart = new HashMap<String, String>();
            
            chart.put("caption", "Top 10 Most Populous Countries");
            chart.put("paletteColors", "#0075c2");
            chart.put("bgColor", "#ffffff");
            chart.put("usePlotGradientColor", "0");
            chart.put("plotBorderAlpha", "10");
            chart.put("showXAxisLine", "1");
            chart.put("xAxisLineColor", "#999999");
            chart.put("showValues", "0");
            chart.put("divlineColor", "#999999");
            chart.put("divLineIsDashed", "1");
            chart.put("showAlternateHGridColor", "0");
            chart.put("showBorder", "0");
            chart.put("baseFont", "Helvetica Neue,Arial");
            chart.put("captionFontSize", "14");
 
            // Push the data into the array using map object.
            ArrayList data = new ArrayList();
            
            /*
                `linkeddata` array: It contains data for individual linked 
                items. The links should be defined in the format 
                `newchart-dataformat-datasource`. 
            */
            ArrayList linkeddata = new ArrayList();
            while(rsCountry.next()) {
            /*
                The `link` attribute: It defines the unique id of the linked 
                data inside the `linkeddata` array. Using this attribute 
                FusionCharts finds out the corresponding data for each linked 
                item.
                
                For the data string method, dataformat takes JSON and 
                datasource takes the value of the unique identifier that 
                refers to the data embedded inside the linkeddata array in 
                the parent data source. So the Country drill-down links will 
                get generated as newchart-json-IND, newchart-json-CHN ... 
            */    
                Map<String, String> lv = new HashMap<String, String>();
                lv.put("label", rsCountry.getString("Name"));
                lv.put("value", rsCountry.getString("Population"));
                lv.put("link", "newchart-json-" + rsCountry.getString("Code"));
                data.add(lv);
      
                // Create the linkedDataObj for cities drilldown    
                Map<String, String> linkedDataObj = new HashMap<String, String>();
                // Inititate the linkedDataObj for cities drilldown
                linkedDataObj.put("id", rsCountry.getString("Code"));
                
               // The 'linkedChartAttribute' map object holds the chart attributes .
                Map<String, String> linkedChartAttribute = new HashMap<String, String>();
                linkedChartAttribute.put("caption" , "Top 10 Most Populous Cities - " + rsCountry.getString("Name") );
                linkedChartAttribute.put("paletteColors" , "#0075c2");
                linkedChartAttribute.put("bgColor" , "#ffffff");
                linkedChartAttribute.put("borderAlpha", "20");
                linkedChartAttribute.put("canvasBorderAlpha", "0");
                linkedChartAttribute.put("usePlotGradientColor", "0");
                linkedChartAttribute.put("plotBorderAlpha", "10");
                linkedChartAttribute.put("showXAxisLine", "1");
                linkedChartAttribute.put("xAxisLineColor" , "#999999");
                linkedChartAttribute.put("showValues", "0");
                linkedChartAttribute.put("divlineColor" , "#999999");
                linkedChartAttribute.put("divLineIsDashed" , "1");
                linkedChartAttribute.put("showAlternateHGridColor" , "0");

                // Convert the data in the `City` model into a format that can be consumed by FusionCharts.     
                ArrayList linkedChartData = new ArrayList();
                
                // Filtering the data base on the Country Code
                // Form the SQL query that returns the top 10 most populous countries
                String sqlQueryCity="SELECT Name, Population FROM City WHERE CountryCode = ? ORDER BY Population DESC LIMIT 10";

                // Prepare the query statement.
                PreparedStatement ptCity=con.prepareStatement(sqlQueryCity);  
                ptCity.setString(1, rsCountry.getString("Code"));
                // Execute the query.
                ResultSet rsCity=ptCity.executeQuery();
                while(rsCity.next()) {
                  Map<String, String> arrDara = new HashMap<String, String>();
                  arrDara.put("label", rsCity.getString("Name"));
                  arrDara.put("value", rsCity.getString("Population"));
                  linkedChartData.add(arrDara);
                } 
                
                //closing the connection.
                rsCity.close();
            
            /*  create a 'linkedchart' map object to make a FC's 
                linkedchart structure.
            */    
                Map<String, String> linkedchart = new HashMap<String, String>();
            /*
                gson.toJson() the data to retrieve the string containing the
                JSON representation of the data in the array.
            */    
                linkedchart.put("chart", gson.toJson(linkedChartAttribute));
                linkedchart.put("data", gson.toJson(linkedChartData));
               
                linkedDataObj.put("linkedchart", gson.toJson(linkedchart));
                linkeddata.add(linkedDataObj);
            } //end of while loop
            
            //closing the connection.
            rsCountry.close();
 
            //create 'dataMap' map object to make a complete FC datasource.
            Map<String, String> dataMap = new LinkedHashMap<String, String>();  
        
            dataMap.put("chart", gson.toJson(chart));
            dataMap.put("data", gson.toJson(data));
            dataMap.put("linkeddata", gson.toJson(linkeddata));

            FusionCharts columnChart= new FusionCharts(
                        "column2d",             //type of chart
                        "chart1",               //unique chart ID
                        "500","300",            //width and height of the chart
                        "chart",                //div ID of the chart container
                        "json",                 //data format
                        gson.toJson(dataMap)    //data source
                    );
           
            %>
<!--    Step 5: Render the chart    -->                
            <%=columnChart.render()%>
    </body>
</html>