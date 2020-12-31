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
 ** Download the **[fusioncharts-suite-xt](http://www.fusioncharts.com/)**
 * Unzip the archive and move to "fusioncharts-suite-xt > integrations > java > fusioncharts-wrapper" to get the "fusioncharts.java" file.
 * Copy this file to your project folder.
 * Start using the methods and classes available under the **FusionCharts** namespace to generate charts in your project.
 
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

###### **AddEvent**
This is a public method used to generate the html code to attach an event to a chart. This function assumes that you’ve already included the FusionCharts JavaScript class in your page. The following parameters have to be passed in order to attach event through addEvent function.

| Parameter | Type | Description |
|:-------|:----------:| :------|
| eventName | `String` | which event you want to bind. e.g. `dataLoaded`.|
|funcName | `String` | javascript function, which is written in your client side code|

chartObj.AddEvent("dataLoaded", "onDataLoaded");

###### **AddMessage**
This is a public method used to generate the html code to  customize chart messages. This function assumes that you've already included the FusionCharts JavaScript class in your page. The following parameters have to be passed in this method.

| Parameter | Type | Description |
|:-------|:----------:| :------|
| messageName | `String` |  parameter want to customize. e.g. `loadMessage`.|
|messageText | `String` | Your custom message|

chartObj.AddMessage("loadMessage", "please wait data is being loaded");

### **FusionTime:**

**Create the chart object with TimeSeries chart with the required parameters as shown below.**

```JSP
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);

    FusionCharts.TimeSeries timeSeries = new FusionCharts.TimeSeries((fusionTable);

    // Wrapper constructor parameters
    // charttype, chartID, width, height, renderAt, data format, TimeSeries object

    FusionCharts fcChart = new FusionCharts("timeseries", "MyFirstChart" , "700", "450", "chart-container", "json", timeSeries);

%>

// Render the chart
<%=fcChart.render()%>
```
There are two classes that you need to use in order to create a TimeSeries chart, `FusionTable` and `TimeSeries`.

### **Constructor parameters of FusionTable :**
This class creates `timeseries` compatible `FusionTable` object which later passed to the TimeSeries class constructor.

```JSP
// Creating FusionTable
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);
%>
```

Let you set the following parameters in FusionTable constructor.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|schema | `String` | The schema which defines the properties of the columns|
|data | `String` | The actual values for each row and column of the DataTable|

### **Data operation:**

FusionTable also supports following DataTable operations:

* Select
* Sort
* Filter
* Pipe

**`Select`** operation should be used only when you want to see few specific columns of the DataTable.

```JSP
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);

    // Column names as parameter
    fusionTable.Select("Country", "Sales");
%>
```

| Parameter | Type | Description |
|:-------|:----------:| :------|
|columnName | `String` | Define multiple columns name.|

**`Sort`** one of the major requirements while working with large sets of data is to sort the data in a specific order - most commonly, ascending or descending.

```JSP
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);

    //column name and orderby
    fusionTable.Sort("Sales", FusionCharts.FusionTable.OrderBy.ASC);
%>
```

| Parameter | Type | Description |
|:-------|:----------:| :------|
|columnName | `String` | Define column name on which sorting will be applied.|
|columnOrderBy | `Enum` | To sort the column in descending or ascending order. e.g. `FusionTable.OrderBy.ASC, FusionTable.OrderBy.DESC`|

**`Filter`** comes with a set of operations that you can use to filter data values from a large dataset, based on one or more conditions. Supported filter operations are:

* Equals
* Greater
* GreaterEquals
* Less
* LessEquals
* Between

```JSP
// Filter - Equal

<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Equals, "Country", "United States");

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

```JSP
// Filter - Greater
<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Greater, "Quantity", 100);

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

```JSP
// Filter - GreaterEquals

<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.GreaterEquals, "Quantity", 100);

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

```JSP
// Filter - Less
<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Less, "Quantity", 100);

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

```JSP
// Filter - LessEquals
<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.LessEquals, "Quantity", 100);

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

```JSP
// Filter - Between
<%
    // Creating filter statement by passing the filter type, column
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Between, "Quantity", 100, 1000);

    //Applying the filter on fusion table
    fusionTable.ApplyFilter(filter1);
%>
```

let you set the following parameter of `CreateFilter` method for creating filter statement.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filterType | `Enum` | Define the filter type. e.g. `FusionCharts.FusionTable.FilterType.Equals`, `FusionCharts.FusionTable.FilterType.Greater` etc.|
|columnName | `String` | Define column name on which the filter will be applied.|
|values | `Object` | Define filter value(s). e.g. `String`, `Integer` values.|

let you set the following parameter of `ApplyFilter` method for applying the filter on fusion table.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filter | `String` | Define the `Filter statement`|

```JSP
// Filter - Apply conditional filter
<%
    // Define anonymous function to filter
    fusionTable.ApplyFilterByCondition("(row, columns) => {"
                + "return row[columns.Country] === 'United States' ||" 
                + "(row[columns.Sales] > 100 && row[columns.Shipping_Cost] < 10);"
            	+ "}");
%>
```

**`Pipe`**  is an operation which lets you run two or more data operations in a sequence. Instead of applying multiple filters one by one to a DataTable which creates multiple DataTable(s), you can combine them in one single step using pipe and apply to the DataTable. This creates only one DataTable.

```JSP
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);

    // Creating first filter statement by passing the filter type, column name and filter value
    String filter1 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Equals, "Country", "India");

    // Creating second filter statement by passing the filter type, column name and filter value
    String filter2 = fusionTable.CreateFilter(FusionCharts.FusionTable.FilterType.Greater, "Quantity", 100);

    //Applying multiple filters one by one to a DataTable
    fusionTable.Pipe(filter1, filter2);
%>
```

| Parameter | Type | Description |
|:-------|:----------:| :------|
|filters | `String` | Define multiple filters.|

### **Constructor parameter of TimeSeries :**
This class creates `timeseries` compatible `TimeSeries` object which later passed to the chart object.

```JSP
// Creating TimeSeries object
FusionCharts.TimeSeries timeSeries = new FusionCharts.TimeSeries(fusionTable);
```

let you set the following parameter in TimeSeries constructor.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|fusionTable | `FusionTable` | The Datatable which defines the schema and actual data (FusionTable).|

#### Methods ####

**`AddAttribute`** is a public method to accept data as a form of JSON string to configure the chart attributes. e.g. `caption`, `subCaption`, `xAxis` etc.

```JSP
<%
    FusionCharts.FusionTable fusionTable = new FusionCharts.FusionTable(schema, data);

    FusionCharts.TimeSeries timeSeries = new FusionCharts.TimeSeries(fusionTable);
    
    timeSeries.AddAttribute("caption", "{"
                                        +	"text: ' Online Sales'"
                                        + "}");
%>                                      
```

let you set the following parameter in `AddAttribute` method.

| Parameter | Type | Description |
|:-------|:----------:| :------|
|key | `String` | The attribute name.|
|value | `String` | Define json formatted value.|

### License

The FusionCharts JSP integration component is open-source and distributed under the terms of the MIT/X11 License. However, you will need to download and include FusionCharts library in your page separately, which has a [separate license](https://www.fusioncharts.com/buy).


