<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
    
    <link rel="stylesheet" href="bootstrap.min.css" type="text/css" >
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.12.0/semantic.min.css" />
    <link rel="stylesheet" href="https://openlayers.org/en/v4.6.4/css/ol.css" type="text/css">
    <script src= "https://openlayers.org/en/v4.6.4/build/ol.js" type="text/javascript"></script>
	<style type="text/css">
			
			.ol-dragbox{
			
				background-color:rgba(255,255,255,0.4);
				border-color:rgba(100,150,0,1);
			}
			.row.vdivide [class*='col-']:not(:last-child):after {
			    background: #e0e0e0;
			    width: 1px;
			    content: "";
			    display:block;
			    position: absolute;
			    top:0;
			    bottom: 0;
			    right: 0;
				height : 700px;
			}

			
	</style>		
    </head>
    <body>
       <h4>Welcome 
       
       <%
        HttpSession session1=request.getSession(false);  
        if(session1.getAttribute("username")!=null)
        {  
            String name=(String)session1.getAttribute("username");   
            out.print(name);
        }  
        else
        {  
            response.sendRedirect("Login.jsp");  
        }
                 
       %></h4>
       
<div class="container-fluid">
 <div class ="row vdivide">
   <div class="col-sm-3"> 
            <div class="form-group">
                    <label for="state">Select State:</label>
                    <select name="state" class="form-control" id="state" >
                        <option value="0">Select State</option>
                                <%
                                   try
                                   {
                                           Class.forName("org.postgresql.Driver"); 
                                           Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgis_24_sample", "postgres","admin123");
                                           //conn.setAutoCommit(false);
                                           Statement stat = conn.createStatement();
                                           ResultSet rs = stat.executeQuery("Select distinct state from india_ds order by state");          
                                           while (rs.next())
                                           {
                                               %>
                                                    <option value="<%=rs.getString("state")%>"><%=rs.getString("state")%></option>
                                               <%
                                            }
                                           rs.close();
                                           stat.close();
                                           conn.close();
                                          
                                           
                                    }
                                    catch(Exception e)
                                    {       
                                            out.println("Something went wrong !! Please try again "+e.getMessage());       
                                    }
                                
                                	
                                    
                                    %>
                            
                        </select>
            </div> 
            <div>
                    <label for="sel2">Select District:</label>
                        <select name="district" id="district" class="form-control"  onchange = zoom_districts(this.value)>  
                            <option value="0">Select District</option>
                            
                        </select>
                        <div id="test"></div>
            </div>
			<br><br>
			<b>Generate PDF:</b>
			<br><br>
            <div>
                    <label for="sel3">Select Size</label>
                        <select name="pgsize" id="pgsize" class="form-control">  
                            <option value="0">Select Size</option>
                            <option value="a0">A0 (slow)</option>
					        <option value="a1">A1</option>
					        <option value="a2">A2</option>
					        <option value="a3">A3</option>
					        <option value="a4">A4</option>
					        <option value="a5">A5 (fast)</option>   
					      </select>
            </div>
            <div>
                    <label for="sel4">Select Resolution</label>
                        <select name="pgres" id="pgres" class="form-control">  
                            <option value="0">Select Resolution</option>
                            <option value="72">72 dpi (fast)</option>
                            <option value="150">150 dpi</option>
                            <option value="300">300 dpi (slow)</option>   
                        </select>
            </div>
            <br><br>
            <button type="button" class="btn btn-default" id="create_pdf"><span class="glyphicon glyphicon-edit"></span> Generate PDF</button>
            <br><br>
            <a href="Logout.jsp" class="btn btn-default" role="button">Logout</a>
            
            
  </div>
  <div class="col-sm-9">  
  <div id="map">
  	<table class="table table-responsive" id="details_table">
    <thead>
      <tr>
        <th>District ID</th>
        <th>District Name</th>
        <th>State Name</th>
        <th>Latitude</th>
        <th>Longitude</th>
      </tr>
    </thead>
     <tbody>
    </tbody>
  </table>
  </div>
  <div id="editor">
  </div>                                             
  </div>
 </div>
 
<div class="row">


<div class="col-sm-3"></div>
<div class="col-sm-9">


  </div>

</div>
 </div>
 
 	<script src="jquery.min.js"    type="text/javascript"></script>
    <script src="bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.debug.js"></script>
    <script type="text/javascript" src="//cdn.rawgit.com/niklasvh/html2canvas/0.5.0-alpha2/dist/html2canvas.min.js"></script>
    
    

 	<script type="text/javascript">
 			document.getElementById('details_table').style.display= 'none';
    		var wmsSource = new ol.source.TileWMS({
    			
    			url:'http://localhost:7000/geoserver/DistrictsOfIndia/wms',
    			params : {'LAYERS': 'DistrictsOfIndia:india_ds','TILED': true},
    			serverType : 'geoserver',
    		});
    		var wmsLayer = new ol.layer.Tile({
    			source : wmsSource
    			
    		});
    		var center = ol.proj.transform([80,30],'EPSG:4326','EPSG:3857');
    		var view = new ol.View({
    			
    			center:center,
    			zoom: 4
    		});
    		
    		 	
    		var map = new ol.Map({
    		
    			layers:[wmsLayer],
    			target:'map',
    		    view : view
    			
    		});
    		
    		  		
		    var maxx;
		    var maxy;
		    var minx;
		    var miny;

   			function zoom_districts(value){
   				
   				$.get("zoomServlet?districts="+value, function(data, status){
   	               
                     var json = JSON.parse(data);
                                                
                     maxx=parseFloat(json.maxx);
                     maxy=parseFloat(json.maxy);
                     minx=parseFloat(json.minx);
                     miny=parseFloat(json.miny); 
 
                     
                                        
                                            
                       var extent = ol.proj.transformExtent([minx,miny,maxx,maxy],"EPSG:4326", "EPSG:3857");


                       map.setView(new ol.View({
                             extent: map.getView().calculateExtent(map.getSize()),
                             zoom : 8
                             
                       }));
                       
                                             
                       map.getView().fit(extent, map.getSize());
                       
                       
                       document.getElementById('details_table').style.display= '';
                       var table=document.getElementById("details_table");
                      
                       var row=table.insertRow(1);
                                 
                       var cell1 = row.insertCell(0);
                       var cell2 = row.insertCell(1);
                       var cell3 = row.insertCell(2);
                       var cell4 = row.insertCell(3);
                       var cell5 = row.insertCell(4);
                       
                       cell1.innerHTML = json.dist_id;
                       cell2.innerHTML = json.district;
                       cell3.innerHTML = json.state;
                       cell4.innerHTML = json.maxx;
                       cell5.innerHTML = json.miny;
                       table.deleteRow(2);
                     
                });	
   				
   				export_pdf(map,wmsLayer,wmsSource);
   				
   			}
    </script>
    
   <script type="text/javascript">
   
	$(document).ready(function() {
	$('#state').change(function(event) {
	        var state = $("select#state").val();
	        
		                         	$.get('Myservice', {
		                         		
		                         		statename : state
		                         	},
		                         			function(response) {
		                         		
				        var select = $('#district');
				        select.find('option').remove();
				        $('<option>').val('null').text('Select One').appendTo(select);
				          $.each(response, function(index, value) {
				          
				          $('<option>').val(value).text(value).appendTo(select);
				          
	      });
	        });
	        });
	
	})
	
	</script>
	
	<script>

		function export_pdf(map,wmsLayer,wmsSource) {
			
			
			
			var dims = {
	    	        a0: [1189, 841],
	    	        a1: [841, 594],
	    	        a2: [594, 420],
	    	        a3: [420, 297],
	    	        a4: [297, 210],
	    	        a5: [210, 148]
	    	      };

	    	      var loading = 0;
	    	      var loaded = 0;


		    $('#create_pdf').click(function () {

		    	
		    	        $('#create_pdf').disabled = true;
		    	        document.body.style.cursor = 'progress';

		    	        var format = document.getElementById('pgsize').value;
		    	        var resolution = document.getElementById('pgres').value;
		    	        var dim = dims[format];
		    	        var width = Math.round(dim[0] * resolution / 25.4);
		    	        var height = Math.round(dim[1] * resolution / 25.4);
		    	        var size = /** @type {ol.Size} */ (map.getSize());
		    	        var extent = map.getView().calculateExtent(size);

		    	        var source = wmsLayer.getSource();
		    	        
		    	            var canvas = this;
		    	            alert(""+canvas)
		    	            console.log(canvas);
		    	              canvas.crossOrigin = "anonymous";
		    	              var data = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream"); 
		    	              var pdf = new jsPDF('landscape', undefined, format);
		    	              pdf.addImage(data, 'JPEG', 0, 0, dim[0], dim[1]);
		    	              pdf.save('map.pdf');
		    	          });
		    	        }
		

		   /* var doc = new jsPDF();

		    var specialElementHandlers = {
		        '#editor': function (element, renderer) {
		            console.log(1);
		            return true;
		        }
		    };*/
		    
		    		  
	</script>
</body>
</html>

