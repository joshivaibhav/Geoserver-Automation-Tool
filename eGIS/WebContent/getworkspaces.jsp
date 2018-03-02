<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Geoserver Workspaces</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="toast.css">

<style>


#test{

	margin-top:1px;

}
</style>
</head>
<body>
<nav class="navbar navbar-default navbar-center">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">GeoServer Manager</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">View Workspace</a></li>
      <li><a href="#">Create Workspace</a></li>
      <li><a href="#">P</a></li>
      <li><a href="#">Page 3</a></li>
    </ul>   
  </div>
</nav>
<div class="container">
	<div class="row">
		<div class = "col-sm-9" id="wkspace">
			
			<div class="list-group" id="wdiv">
	               
	         </div>
   		</div>
   		<div class = "col-sm-1">
			<div class="test" id="wdel">
			
										
			</div>   		
   		
   		
   		</div>
   	</div>
   	<div class="row">
   	
   	<div class = "col-sm-9" id="test">  	
   	
   	<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-md">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Create Workspace</h4>
        </div>
        <div class="modal-body">
                <label for="email">Enter Name for Workspace</label>
			      <input type="text" class="form-control" id="wname" placeholder="Workspace Name" name="wname">
			      <br>
			    <button type="button" id="wkspname" class="btn btn-default" data-dismiss="modal">Create</button>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
   	
   	</div>
   		<div class = "col-sm-3">
   		
   			<div id="toast"><div id="img"><span class="glyphicon glyphicon-ok"></span></div><div id="desc">Workspace deleted!</div>
   			</div>
   			
   			<br><br><br>
   			
			<button type="button" class="btn btn-default btn-lg" id="createwksp"> <span class="glyphicon glyphicon-plus"></span></button>
   	</div> 
   	
</div>
</div>
</body>

<script
			  src="https://code.jquery.com/jquery-3.3.1.min.js"
			  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
			  crossorigin="anonymous"></script>
			  
<script src="bootstrap.min.js" type="text/javascript"></script>    

<script>

$(document).ready(function() {
		        
	        
		                         	$.get('Myrestservlet',
		                         			
		                         			function(response) {
		                         			var wdiv = $("#wdiv");
		                         			var wsdel = $("#wdel");
		                     		    	var wname = Object.keys(response);
		                     		    	var x = 0;
								        	$.each(response, function(index, value) {
								          
								    
								        	wdiv.append("<a class=\"list-group-item clearfix\" href=\""+value+"\">"+
								        			wname[x]+							      	
							                "</a>");
								        	
								        	
								        	
								        	 wsdel.append("<button type=\"button\" id=\""+wname[x]+"\"= class=\"btn btn-default btn-lg\" onclick=delwkspace(this.id)>"+
								              "<span id=\"test\" class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>"+
								            "</button>");
								        	
								        	 x++;
								           								        	      	
								        	
								    });
								  			        
	        });
	       
	})
	
</script>


<script>

function delwkspace(value){
	
	$.get('postservlet',{
		
			wkspace : value	
		},
        
       function(response) {
        	
		
				location.reload();
			    eee();
            
        }
    );
	
}
		
</script>
<script>
function eee()
{
	
		var x = document.getElementById("toast")
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 5000);
	
}

</script>
<script>


$(document).ready(function() {
  
		$("#createwksp").click(function(){
			
			 $("#myModal").modal();			
			
	})
		
	
	$("#wkspname").click(function(){
			
			 var wname = $("#wname").val();
			 
			 	$.get('createwksp_servlet', {wkspacename: wname}, function(response){
			        
				 
			 		window.location.href = "getworkspaces.jsp";
			 		
				 
			    });
			 
			 
			
			
	})
		
	
		
	
})

</script>
</html>