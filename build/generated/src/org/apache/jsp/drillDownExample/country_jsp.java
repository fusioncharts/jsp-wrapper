package org.apache.jsp.drillDownExample;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;
import com.google.gson.*;
import fusioncharts.FusionCharts;

public final class country_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    
/* 
    The following four code lines contain the database connection information.
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
   
    
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Creating Charts with Data from a Database - fusioncharts.com</title>\n");
      out.write("<!--    Step 1: Include the `fusioncharts.js` file. This file is needed to\n");
      out.write("        render the chart. Ensure that the path to this JS file is correct.\n");
      out.write("        Otherwise, it may lead to JavaScript errors.\n");
      out.write("--> \n");
      out.write("        <script src=\"../scripts/fusioncharts.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("         <div id=\"chart\"></div>\n");
      out.write("         \n");
      out.write("<!--    Step 2: Include the `FusionCharts.java` file as a package in your \n");
      out.write("        project.\n");
      out.write("    \n");
      out.write("        Step 3:Include the package in the file where you want to show \n");
      out.write("        FusionCharts.\n");
      out.write("\n");
      out.write("-->\n");
      out.write("        \n");
      out.write("\n");
      out.write("<!--\n");
      out.write("        \n");
      out.write("        Step 4: Create a chart object using the FusionCharts JAVA class \n");
      out.write("        constructor. Syntax for the constructor: \n");
      out.write("        `FusionCharts(\"type of chart\", \"unique chart id\", \"width of chart\",\n");
      out.write("                        \"height of chart\", \"div id to render the chart\", \n");
      out.write("                        \"data format\", \"data source\")`   \n");
      out.write("-->         \n");
      out.write("        ");

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
           
            
      out.write("\n");
      out.write("<!--    Step 5: Render the chart    -->                \n");
      out.write("            ");
      out.print(columnChart.render());
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
