<%-- 
    Document   : countryDrillDown
    Author     : suvradip saha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.example.FusionCharts" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="com.google.gson.*" %>

<%
    
/* 
    The following 4 code lines contain the database connection information.
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
        <!--  Include the `fusioncharts.js` file. This file is needed to render the chart. Ensure that the path to this JS file is correct. Otherwise, it may lead to JavaScript errors. -->
        <script src="../scripts/fusioncharts.js"></script>
        <!-- End -->
    </head>
    <body>
         <div id="chart"></div>
        <%
        /*
            google-gson
    
            Gson is a Java library that can be used to convert Java Objects into 
            their JSON representation. It can also be used to convert a JSON string to 
            an equivalent Java object. Gson can work with arbitrary Java objects including
            pre-existing objects that you do not have source-code of.
            link : https://github.com/google/gson    
        */
    
            Gson gson = new Gson();
            
            // Get the country code from the GET parameter
            String countryCode = request.getParameter("Country");
            
            // Form the SQL query that returns the top 10 most populous countries
            String sql="SELECT Name, Population FROM City WHERE CountryCode = ? ORDER BY Population DESC LIMIT 10";

            // Prepare the query statement.
            PreparedStatement pt=con.prepareStatement(sql);  
            pt.setString(1, countryCode);
            // Execute the query.
            ResultSet rs=pt.executeQuery();
            
        /* 
           Form the SQL query that will return the country name based on 
           the country code. The result of the above query contains only the 
           country code. The country name is needed to be rendered as a
           caption for the chart that shows the 10 most populous cities 
        */
            String countryNameQuery = "SELECT Name FROM Country WHERE Code = ?";
            
            // Prepare the query statement.
            PreparedStatement countryPrepStmt=con.prepareStatement(countryNameQuery); 
            countryPrepStmt.setString(1, countryCode); 
            // Execute the query.
            ResultSet rs_1=countryPrepStmt.executeQuery();
            String countryName = "";
            if(rs_1.next())
            countryName = rs_1.getString("Name");    
            
            // The 'chartobj' map object holds the chart attributes and data.
            Map<String, String> chartobj = new HashMap<String, String>();
            
                chartobj.put("caption","Top 10 Most Populous Cities in " + countryName);
                chartobj.put("paletteColors" , "#0075c2");
                chartobj.put("bgColor" , "#ffffff");
                chartobj.put("borderAlpha", "20");
                chartobj.put("canvasBorderAlpha", "0");
                chartobj.put("usePlotGradientColor", "0");
                chartobj.put("plotBorderAlpha", "10");
                chartobj.put("showXAxisLine", "1");
                chartobj.put("xAxisLineColor" , "#999999");
                chartobj.put("showValues", "0");
                chartobj.put("divlineColor" , "#999999");
                chartobj.put("divLineIsDashed" , "1");
                chartobj.put("showAlternateHGridColor" , "0");
 
            // Push the data into the array using map object.
            ArrayList arrData = new ArrayList();
            while(rs.next())
            {
                Map<String, String> lv = new HashMap<String, String>();
                lv.put("label", rs.getString("Name"));
                lv.put("value", rs.getString("Population"));
                arrData.add(lv);             
            }
            
            //close the connection.
            rs.close();
 
            //create 'dataMap' map object to make a complete FC datasource.
             Map<String, String> dataMap = new LinkedHashMap<String, String>();  
        /*
            gson.toJson() the data to retrieve the string containing the
            JSON representation of the data in the array.
        */
             dataMap.put("chart", gson.toJson(chartobj));
             dataMap.put("data", gson.toJson(arrData));
 
            FusionCharts columnChart= new FusionCharts(
            "column2d",// chartType
                        "chart1",// chartId
                        600,400,// chartWidth, chartHeight
                        "chart",// chartContainer
                        "json",// dataFormat
                        gson.toJson(dataMap) //dataSource
                    );
           
            %>
            
            <%=columnChart.render()%>
        
    </body>
</html>
