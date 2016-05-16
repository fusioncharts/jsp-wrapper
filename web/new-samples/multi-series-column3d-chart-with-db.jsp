<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

   String hostdb = "localhost:3309";  // MySQl host
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
         /*
            google-gson
    
            Gson is a Java library that can be used to convert Java Objects into 
            their JSON representation. It can also be used to convert a JSON string to 
            an equivalent Java object. Gson can work with arbitrary Java objects including
            pre-existing objects that you do not have source-code of.
            link : https://github.com/google/gson    
         */
            GsonBuilder builder = new GsonBuilder();
            //By default, gson Unicode escapes certain characters, of which ' is one.
            //To disable this, do
            builder.disableHtmlEscaping();
            Gson gson = builder.create();
            
            
            
            // Form the SQL query that returns the top 10 most populous countries
            String sql="SELECT * FROM `harry_supermart` ORDER BY `harry_supermart`.`current_year` ASC";

            // Execute the query.
            PreparedStatement pt=con.prepareStatement(sql);    
            ResultSet result=pt.executeQuery();
            
            // The 'chartobj' map object holds the chart attributes and data.
            Map<String, String> chartobj = new HashMap<String, String>();
            
            chartobj.put("caption", "Harry's SuperMart");
            chartobj.put("subCaption", "Sales by quarter");
            chartobj.put("xAxisName", "Quarter");
            chartobj.put("yAxisName", "Sales (In USD)");
            chartobj.put("numberPrefix", "$");
            chartobj.put("paletteColors", "#0075c2,#1aaf5d,#f2c500");
            chartobj.put("bgColor", "#ffffff");
            chartobj.put("showBorder", "0");
            chartobj.put("showCanvasBorder", "0");
            chartobj.put("usePlotGradientColor", "0");
            chartobj.put("plotBorderAlpha", "10");
            chartobj.put("legendBorderAlpha", "0");
            chartobj.put("legendBgAlpha", "0");
            chartobj.put("legendShadow", "0");
            chartobj.put("showHoverEffect", "1");
            chartobj.put("valueFontColor", "#ffffff");
            chartobj.put("rotateValues", "1");
            chartobj.put("placeValuesInside", "1");
            chartobj.put("divlineColor", "#999999");
            chartobj.put("divLineDashed", "1");
            chartobj.put("divLineDashLen", "1");
            chartobj.put("divLineGapLen", "1");
            chartobj.put("canvasBgColor", "#ffffff");
            chartobj.put("captionFontSize", "14");
            chartobj.put("subcaptionFontSize", "14");
            chartobj.put("subcaptionFontBold", "0");
            
            //prepare categorie
            ArrayList categories = new ArrayList();
            categories.add(buildCategories("label", result, gson));
            
            //prepare dataset
            ArrayList dataset = new ArrayList();
            dataset.add(buildDataset("Previous Year","previous_year", result, gson));
            dataset.add(buildDataset("Current Year", "current_year", result, gson));
            
            //close the connection.
            result.close();
 
            //create 'dataMap' map object to make a complete FusionCharts datasource.
             Map<String, String> dataMap = new LinkedHashMap<String, String>();  
        /*
            gson.toJson() the data to retrieve the string containing the
            JSON representation of the data in the array.
        */
             dataMap.put("chart", gson.toJson(chartobj));
             dataMap.put("categories", gson.toJson(categories));
             dataMap.put("dataset", gson.toJson(dataset));

            FusionCharts mscolumnChart= new FusionCharts(
            "mscolumn3d",// chartType
                        "chart1",// chartId
                        "600","400",// chartWidth, chartHeight
                        "chart",// chartContainer
                        "json",// dataFormat
                        gson.toJson(dataMap) //dataSource
                    );
           
            %>
            
            
            <%!
            /**
             * @description - Build the Json for the categories
             * @param {String} data_item - Name of the column from table
             * @param {ResultSet} rs - The object of ResultSet maintains a 
             *      cursor pointing to a particular row of data.
             * @param {Gson}  gson - Gson is a Java library that can be used 
             *      to convert Java Objects into their JSON representation.
             * @return {Map Object} 
             */
            public Map buildCategories(String data_item, ResultSet rs, Gson gson) {
                Map<String, String> categoryinner = new HashMap<String, String>();
                ArrayList category = new ArrayList();
                try {
                //Retrieves whether the cursor is before the first row in this ResultSet object.    
                    rs.beforeFirst();
                    while(rs.next()) {
                        Map<String, String> lv = new HashMap<String, String>();
                        lv.put("label", rs.getString(data_item));
                        category.add(lv);             
                    }
                    categoryinner.put("category", gson.toJson(category));
                }catch(Exception ex) {/* if any error occure */}
                
                return categoryinner;
            }
            
            
            /**
             * @description - Build the Json for datasets
             * @param {String} seriesname - Lets you specify the series 
             *      name for a particular dataset.
             * @param {String} seriescolumnname - Name of the column from table
             * @param {ResultSet} - The object of ResultSet maintains a 
             *      cursor pointing to a particular row of data.
             * @param {Gson} gson - Gson is a Java library that can be used 
             *      to convert Java Objects into their JSON representation.
             * @return {Map Object}
-            */
            public Map buildDataset(String seriesname, String seriescolumnname, ResultSet rs, Gson gson ) {
            
                Map<String, String> datasetinner = new HashMap<String, String>();
                datasetinner.put("seriesname", seriesname); 
                
                ArrayList makedata = new ArrayList();
                try {
                //Retrieves whether the cursor is before the first row in this ResultSet object.
                    rs.beforeFirst();
                    while(rs.next()) {
                      Map<String, String> preparedata = new HashMap<String, String>();  
                      preparedata.put("value", rs.getString(seriescolumnname));

                      makedata.add(preparedata);  
                    }
                    datasetinner.put("data", gson.toJson(makedata));

                } catch(Exception err) {/* if any error occure */}

                return datasetinner;
            }
            
            %>
            
<!--    Step 5: Render the chart    -->                
            
        <%= mscolumnChart.render() %>
      
    </body>
</html>
