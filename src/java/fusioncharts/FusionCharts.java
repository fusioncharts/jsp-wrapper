/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fusioncharts;
import java.util.*;

public class FusionCharts {
    private String constructorTemplate = "<script type=\"text/javascript\">FusionCharts.ready(function () {new FusionCharts(__constructorOptions__);});</script>";
    private String renderTemplate = "<script type=\"text/javascript\">FusionCharts.ready(function () {FusionCharts(\"__chartId__\").render();});</script>";
    private String chartDataSource = "";
    private Map<String, String> chartOptions = new HashMap<String, String>();
    
    public FusionCharts(String type, String id, String width, String height, String renderAt, String dataFormat, String dataSource) {
        this.chartOptions.put("id", id);
        this.chartOptions.put("width", width);
        this.chartOptions.put("height", height);
        this.chartOptions.put("renderAt", renderAt);
        this.chartOptions.put("type", type);
        this.chartOptions.put("dataFormat", dataFormat);
        
        if(dataFormat.contains("url")) {
            this.chartOptions.put("dataSource", "\""+dataSource+"\"");
        } else {
            this.chartOptions.put("dataSource", "__dataSource__");
            this.chartDataSource = this.addSlashes(dataSource.replaceAll("\n", ""));
        }
    }
    private String addSlashes(String str) {
        str = str.replaceAll("\\\\", "\\\\\\\\");
        str = str.replaceAll("\\n", "\\\\n");
        str = str.replaceAll("\\r", "\\\\r");
        str = str.replaceAll("\\00", "\\\\0");
        str = str.replaceAll("u003d", "=");
        str = str.replaceAll("'", "\\\\'");
        str = str.replaceAll("\\\\", "");
        str = str.replaceAll("\"\\{", "{");
        str = str.replaceAll("\"\\[", "[");
        str = str.replaceAll("\\}\\]\"", "}]");
        str = str.replaceAll("\"\\}\"", "\"}");
        str = str.replaceAll("\\}\"\\}", "}}");
        return str;
    }
    private String jsonEncode(){
        String json = 
                "{type: \""+this.chartOptions.get("type")+
                "\",renderAt: \""+this.chartOptions.get("renderAt")+
                "\",width: \""+this.chartOptions.get("width")+
                "\",height: \""+this.chartOptions.get("height")+
                "\",dataFormat: \""+this.chartOptions.get("dataFormat")+
                "\",id: \""+this.chartOptions.get("id")+
                "\",dataSource: "+this.chartOptions.get("dataSource")+
                "}";
        return json;
    }
    public String render() {
        String outputHTML;
        if(this.chartOptions.get("dataFormat").contains("url")) {
            outputHTML = this.constructorTemplate.replace("__constructorOptions__", 
                this.jsonEncode())+this.renderTemplate.replace("__chartId__", 
                this.chartOptions.get("id"));
        } else {
            if("json".equals(this.chartOptions.get("dataFormat"))) {
                outputHTML = this.constructorTemplate.replace("__constructorOptions__",
                    this.jsonEncode().replace("__dataSource__",
                    this.chartDataSource))+this.renderTemplate.replace("__chartId__",
                    this.chartOptions.get("id"));
            } else {
                outputHTML = this.constructorTemplate.replace("__constructorOptions__", 
                    this.jsonEncode().replace("__dataSource__","\'"+
                    this.chartDataSource+"\'"))+
                    this.renderTemplate.replace("__chartId__", this.chartOptions.get("id"));
            }
        }
        return outputHTML;
    }
    
    public void setChartParameter(String param_key, String param_value){
        if(param_key.equals("dataSource")){
            if(param_value.contains("url")) {
                this.chartOptions.put("dataSource", param_value);
            } else {
                this.chartOptions.put("dataSource", "__dataSource__");
                this.chartDataSource = this.addSlashes(param_value.replaceAll("\n", ""));
            }
        } else {
            this.chartOptions.put(param_key, param_value);
        } 
    }
}
