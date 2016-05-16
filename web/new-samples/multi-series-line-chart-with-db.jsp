<%@page import="javax.swing.JOptionPane"%>
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
    
            Gson gson = new Gson();
            
            
            // Form the SQL query that returns the top 10 most populous countries
            String sql="SELECT * FROM `number_of_visitor` ORDER BY `number_of_visitor`.`id` ASC";

            // Execute the query.
            PreparedStatement pt=con.prepareStatement(sql);    
            ResultSet result=pt.executeQuery();
            
            // The 'chartobj' map object holds the chart attributes and data.
            Map<String, String> chartobj = new HashMap<String, String>();
            
            chartobj.put("caption", "Number of visitors last week");
            chartobj.put("subCaption", "Bakersfield Central vs Los Angeles Topanga");
            chartobj.put("captionFontSize", "14");
            chartobj.put("subcaptionFontSize", "14");
            chartobj.put("subcaptionFontBold", "0");
            chartobj.put("paletteColors", "#0075c2,#1aaf5d");
            chartobj.put("bgcolor", "#ffffff");
            chartobj.put("showBorder", "0");
            chartobj.put("showShadow", "0");
            chartobj.put("showCanvasBorder", "0");
            chartobj.put("usePlotGradientColor", "0");
            chartobj.put("legendBorderAlpha", "0");
            chartobj.put("legendShadow", "0");
            chartobj.put("showAxisLines", "0");
            chartobj.put("showAlternateHGridColor", "0");
            chartobj.put("divlineThickness", "1");
            chartobj.put("divLineDashed", "1");
            chartobj.put("divLineDashLen", "1");
            chartobj.put("divLineGapLen", "1");
            chartobj.put("xAxisName", "Day");
            chartobj.put("showValues", "0");
            
            //prepare vline
            Map<String, String> vline = new LinkedHashMap<String, String>();
            vline.put("vline", "true");
            vline.put("lineposition", "0");
            vline.put("color", "#6baa01");
            vline.put("labelHAlign", "center");
            vline.put("labelPosition", "0");
            vline.put("label", "National holiday");
            vline.put("dashed", "1");
            
            //prepare categorie
            ArrayList categories = new ArrayList();
            categories.add(buildCategories("label", result, vline, 2, gson));
            
            //prepare dataset
            ArrayList dataset = new ArrayList();
            dataset.add(buildDataset("Bakersfield Central","bakersfield_central", result, gson));
            dataset.add(buildDataset("Los Angeles Topanga", "los_angeles_topanga", result, gson));
            
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

            FusionCharts mslineChart= new FusionCharts(
            "msline",// chartType
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
            public Map buildCategories(String data_item, ResultSet rs, Map vline, int vline_posi, Gson gson) {
                Map<String, String> categoryinner = new HashMap<String, String>();
                ArrayList category = new ArrayList();
                int counter = -1;
                try {   
                    while(rs.next()) {
                        
                        Map<String, String> lv = new HashMap<String, String>();
                        lv.put("label", rs.getString(data_item));
                        category.add(lv);
                        
                        counter ++;
                        if(counter == vline_posi) {
                            category.add(vline);
                        }
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
                //is used to move the cursor to the first row in result set object.
                    rs.first();
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
            
        <%= mslineChart.render() %>
      
    </body>
</html>

