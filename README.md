# FusionCharts JSP Wrapper

### What is the FusionCharts JSP wrapper?

The FusionCharts Java server-side wrapper lets you create charts in your JSP website without writing any JavaScript code.

### How does this wrapper work?
Conventionally, FusionCharts Suite XT uses JavaScript and HTML to generate charts in the browser. The JSP wrapper lets you generate the required JavaScript and HTML code as a string on the server. This string is then used to render charts on a browser page.

### Version
1.0

### Requirements
JAVA 6 or higher

### Installation
 * Download the **[`JSP wrapper package`](http://www.fusioncharts.com/jsp-charts/)**
 * Unzip the archive and move its contents to the **"/jsp-wrapper-master/src/java/fusioncharts/"** to get the **"FusionCharts.java"** main class file.
 * Include **"FusionCharts.java"** in your project(Check **[the usage guide](http://www.fusioncharts.com/dev/using-with-server-side-languages/java/introduction.html)** for details).
 * Start using the methods and classes available under the **FusionCharts** namespace to generate charts in your project.. 
 
**Note : FusionCharts JS libraries should already be installed within your project in order to work with this wrapper.**

### Usage Guide

#### Installing FusionCharts JS libraries in your page where you want to display FusionCharts
There are two ways you can install the FusionCharts JS library in your project
* Using FusionCharts CDN
* Using library files placed in the folder of your project

**Using FusionCharts CDN**

Write a script tag in the <head> section of the page where you want to add the source of the FusionCharts library link from the official CDN:
```html
<script type="text/javascript" src="http://static.fusioncharts.com/code/latest/fusioncharts.js"></script>
```
**Using library files placed in a folder of your project**

You can download the **[`trial version`](http://www.fusioncharts.com/download/)** of FusionCharts.

Next, assuming you have the FusionCharts library placed inside the "fusioncharts" folder in your project, write a script tag in the <head> section of the page where you want to add the source of the FusionCharts library link from the local folder.
```html
<script type="text/javascript" src="fusioncharts/fusioncharts.js"></script>
```
Now, you are ready to prepare the chart using our JSP-wrapper.
#### Using the wrapper
#### Step 1:
**Include the wrapper file (`FusionCharts.java`) to your JSP page:**
```JSP
    <%@page import="FusionCharts" %>
```
#### Step 2:
**Create a chart object that consists of the information required to render the. For details about the constructor and it's parameters check [constructor parameters](#constructor-parameters)**
```JSP
<%
    FusionCharts area2dChart = new FusionCharts(
        "Area2D",// chartType
        "myFirstChart",// chartId
        "600","400",// chartWidth, chartHeight
        "chart",// chartContainer
        "json",// dataFormat
        "{\"chart\":{\"caption\":\"Harry\\'sSuperMart\",\"subCaption\":\"Top 5 stores in last month by revenue\",\"numberPrefix\":\"$\",\"theme\":\"ocean\"},\"data\":[{\"label\":\"Bakersfield Central\",\"value\":\"880000\"},{\"label\":\"Garden Grooveharbour\",\"value\":\"730000\"},{\"label\":\"Los Angeles Topanga\",\"value\":\"590000\"},{\"label\":\"Compton-Rancho Dom\",\"value\":\"520000\"},{\"label\":\"Daly City Serramonte\",\"value\":\"330000\"}]}"
);
%>
```

#### Step 3:
**Render the chart**
```JSP
 <%=area2dChart.render()%>
```

### **Constructor parameters:**
The following parameters can be used in a constructor in the order they are described in the table below. Some of these parameters are optional. This function assumes that you've already included the FusionCharts JavaScript library to your page.

| Parameter | Type | Description |
|:-------|:----------:| :------|
| chartType | `String` | The type of chart that you intend to plot. e.g. `Column3d`, `Column2d`, `Pie2d` etc.|
|chartId | `String` | Unique ID for the chart, using which it will be recognized in the HTML page. Each chart on the page should have a unique Id.|
|chartWidth | `String` | Intended width for the chart (in pixels). e.g. `400`|
|chartHeight | `String` | Intended height for the chart (in pixels). e.g. `300`|
|dataFormat | `String` | Type of data used to render the chart. e.g. `json`, `jsonurl`, `xml`, `xmlurl`|
|dataSource | `String` | Actual data for the chart. e.g. `"{\"chart\":{},\"data\":[{\"label\":\"Jan\",\"value\":\"420000\"}]}"`|

##### Methods under the Chart class
###### **Render**
This is a public method used to generate the HTML code for rendering a chart. This function assumes that you've already included the FusionCharts JavaScript library in your page.


### License

**FUSIONCHARTS:**

Copyright (c) FusionCharts Technologies LLP  
License Information at [http://www.fusioncharts.com/license](http://www.fusioncharts.com/license)


