<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>

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
        <script src="../scripts/themes/fusioncharts.theme.fint.js"></script>
    </head>
    <body>
        
        <div id="chart"></div>
<!--    Step 2: Include the `FusionCharts.java` file as a package in your 
        project.
    
        Step 3:Include the package in the file where you want to show 
        FusionCharts.

-->
        <%@page import="fusioncharts.FusionCharts" %>

  

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
       
        <%
           
            /*
            Set up templates for the XML data. 
            To create an XML string, using templates is an easier option 
            than manual string concatenation.
        */
            
            String chartXML = "<chart __attributes__>__set__</chart>";
            String attributeTemplate = "__key__=\"__value__\" ";
            String setXMLTemplate = "<set label=\"__label__\" value=\"__value__\" />";

           
             String sql="SELECT * FROM top_5_stores";
             PreparedStatement pt=con.prepareStatement(sql);    
            ResultSet rs=pt.executeQuery();
            
             /* chartobj is the map object that is initialized to store the chart attributes. */
            Map<String, String> chartobj = new HashMap<String, String>();
            chartobj.put("caption", "Top 5 stores by sales");
            chartobj.put("subCaption" , "Last month");
            chartobj.put("yAxisName" , "Sales");
            chartobj.put("numberPrefix","RS.");
            chartobj.put("axisLineAlpha", "25");
            chartobj.put("divLineAlpha", "10");
            chartobj.put("alignCaptionWithCanvas", "0");
            chartobj.put("theme","fint");
                      
            
            // The data to be plotted on the chart is stored in the 'dataobj' object.
                Map<String, Integer> dataobj = new HashMap<String, Integer>();
            while(rs.next()){
            dataobj.put(rs.getString("label") ,rs.getInt("value"));

            }
            rs.close();
            /*
            To convert the chart attributes map object, 'chartobj', to XML, 
            we will use the templates instead of manipulating the strings. 
            Individual attribute strings will be stored in the array; they will then 
            be combined into one string.
        */
            
            ArrayList<String> chartAttributeList = new ArrayList<String>();
             // Iterate over each chart attribute and convert it into an attribute string
            for(Map.Entry cobj:chartobj.entrySet())
            {
                System.out.println("--");
                System.out.println(cobj);
                String tempAttributeTemplate = attributeTemplate;
                tempAttributeTemplate = tempAttributeTemplate.replaceAll("__key__", (String) cobj.getKey());
                tempAttributeTemplate = tempAttributeTemplate.replaceAll("__value__",(String)  cobj.getValue()); 
                chartAttributeList.add(tempAttributeTemplate);
            }
            
            System.out.println("1--");
            /*
            We again use the template to convert the chart data into the XML format. 
            */
            
            ArrayList<String> setList = new ArrayList<String>();
            // Iterate over each data and convert it into XML set
            for(Map.Entry dobj:dataobj.entrySet())
            {                
                String tempSetTemplate = setXMLTemplate;
                tempSetTemplate = tempSetTemplate.replaceAll("__label__", (String) dobj.getKey());
                tempSetTemplate = tempSetTemplate.replaceAll("__value__", (String) dobj.getValue().toString()); 
                setList.add(tempSetTemplate);
            }   
            
         /*
            //Using Java 8 you can do this in a very clean way:
              String.join(delimiter, elements);
        */
            
            // Join the array using a single space as the delimiter.
            StringBuilder chartAttributeString = new StringBuilder();
            for(String s: chartAttributeList)
            chartAttributeString.append(" " +  s);
            
      
            // Join the array.
            StringBuilder setAttributeString = new StringBuilder();
            for(String s: setList)
            setAttributeString.append(s);
            
            // Replace the chart attributes
            chartXML = chartXML.replaceAll("__attributes__",  chartAttributeString.toString());
            // Replace the data sets
            chartXML = chartXML.replaceAll("__set__",  setAttributeString.toString());

            FusionCharts barChart= new FusionCharts(
                        //type of chart
                        "bar2d",    
                        //unique chart ID
                        "chart1",   
                        //width and height of the chart
                        "500","300",
                        //div ID of the chart container
                        "chart",    
                        //data format
                        "xml",      
                        //data source
                       chartXML     
                    );
           
            %>
<!--    Step 5: Render the chart    -->              
         <%=barChart.render()%>

            
            
    </body>
</html>