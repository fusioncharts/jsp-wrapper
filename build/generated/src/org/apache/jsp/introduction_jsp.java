package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import fusioncharts.FusionCharts;

public final class introduction_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Introduction JSP </title>\n");
      out.write("<!-- Step 1: Include the `fusioncharts.js` file. This file is needed to\n");
      out.write("        render the chart. Ensure that the path to this JS file is correct.\n");
      out.write("        Otherwise, it may lead to JavaScript errors.\n");
      out.write("-->        \n");
      out.write("        <script src=\"scripts/fusioncharts.js\"></script>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <div id=\"chart\"></div>\n");
      out.write("        \n");
      out.write("<!--    Step 2: Include the `FusionCharts.java` file as a package in your \n");
      out.write("        project.\n");
      out.write("-->\n");
      out.write("        \n");
      out.write("        \n");
      out.write("<!--    Step 3:Include the package in the file where you want to show \n");
      out.write("        FusionCharts as follows.\n");
      out.write("        \n");
      out.write("        Step 4: Create a chart object using the FusionCharts JAVA class \n");
      out.write("        constructor. Syntax for the constructor: \n");
      out.write("        `FusionCharts(\"type of chart\", \"unique chart id\", \"width of chart\",\n");
      out.write("                        \"height of chart\", \"div id to render the chart\", \n");
      out.write("                        \"data format\", \"data source\")`   \n");
      out.write("-->        \n");
      out.write("        ");

            FusionCharts columnChart= new FusionCharts(
            "column2d",// chartType
                        "chart1",// chartId
                        "600","400",// chartWidth, chartHeight
                        "chart",// chartContainer
                        "json",// dataFormat
                        "{   \"chart\": {  \"caption\": \"Monthly revenue for last year\",                   \"subCaption\": \"Harry’s SuperMart\",                   \"xAxisName\": \"Month\",                   \"yAxisName\": \"Revenues (In USD)\",                   \"numberPrefix\": \"$\",                   \"paletteColors\": \"#0075c2\",                   \"bgColor\": \"#ffffff\",                   \"borderAlpha\": \"20\",                   \"canvasBorderAlpha\": \"0\",                   \"usePlotGradientColor\": \"0\",                   \"plotBorderAlpha\": \"10\",                   \"placeValuesInside\": \"1\",                   \"rotatevalues\": \"1\",                   \"valueFontColor\": \"#ffffff\",                   \"showXAxisLine\": \"1\",                   \"xAxisLineColor\": \"#999999\",                   \"divlineColor\": \"#999999\",                   \"divLineIsDashed\": \"1\",                   \"showAlternateHGridColor\": \"0\",                   \"subcaptionFontSize\": \"14\",                   \"subcaptionFontBold\": \"0\"               },               \"data\": [{                   \"label\": \"Jan\",                   \"value\": \"420000\"               }, {                   \"label\": \"Feb\",                   \"value\": \"810000\"               }, {                   \"label\": \"Mar\",                   \"value\": \"720000\"               }, {                   \"label\": \"Apr\",                   \"value\": \"550000\"               }, {                   \"label\": \"May\",                   \"value\": \"910000\"               }, {                   \"label\": \"Jun\",                   \"value\": \"510000\"               }, {                   \"label\": \"Jul\",                   \"value\": \"680000\"               }, {                   \"label\": \"Aug\",                   \"value\": \"620000\"               }, {                   \"label\": \"Sep\",                   \"value\": \"610000\"               }, {                   \"label\": \"Oct\",                   \"value\": \"490000\"               }, {                   \"label\": \"Nov\",                   \"value\": \"900000\"               }, {                   \"label\": \"Dec\",                   \"value\": \"730000\"               }]           }"
                    );
           
            
      out.write("\n");
      out.write("<!--    Step 5: Render the chart    -->            \n");
      out.write("            ");
      out.print(columnChart.render());
      out.write("\n");
      out.write("        \n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
