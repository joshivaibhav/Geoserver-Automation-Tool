<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Roboto:300" rel="stylesheet">
<link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">

	
<style>

html{
	font-family: 'Roboto' ,sans-serif;
}

body{

background-color:#9bddd7;


}
#cftr{
		padding-bottom:10px;
}

#card{
		margin-top:70px;
		

}
</style>
</head>
<body>
	<div class="container-fluid">
	    <nav id="nav" style="background-color:#fbfbfb" class="z-depth-4">
			<div class="nav-wrapper">
			  <a href="#" class="brand-logo center" style="color:black; font-weight:200">eMap</a>
			  <ul id="nav-mobile" class="left hide-on-med-and-down">
				<li><a href="#"style="color:black; font-weight:300">Get Started</a></li>
				<li><a href="#"style="color:black; font-weight:300">About</a></li>
				<li><a href="#"style="color:black; font-weight:300">Extra</a></li>
			  </ul>
			</div>
		</nav>
		<div class="row">
			<div class="col s4"></div>
				<div class="col s4" id="card">
					<div class="card z-depth-2 hoverable col s12 center-align" style="padding-top:40px; background-color:#fbfbfb;">
						<span class="card-title" style="font-size:2em;">Login</span>
        					<form method="post" action="LoginValidate.jsp">
        				<br><br>
								<div class="row">
									<div class="col s1"></div>
			        				<div class="input-field col s10" id="frm">
			          						<input placeholder="Username" id="first_name" type="text" class="validate" name="uname">
			          						<label for="first_name">Enter Username</label>
			        				</div>
									<div class="col s1"></div>
								</div>
								<div class="row">
									<div class="col s1"></div>
			        				<div class="input-field col s10">
			          						<input placeholder="Password" id="passwd" type="password" class="validate" name="pass">
			          						<label for="passwd">Enter Password</label>
			        				</div>
									<div class="col s1"></div>
								</div>
			        	<br><br>
								<div class="row">
									<div class="col s1"></div>
			        				<div class="col s10 center-align">
									  <button class="btn waves-effect waves-light" type="submit" name="action">Submit
									  </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                      <button class="btn waves-effect waves-light" type="reset">Reset
									  </button>
									 </div>
					  			   <div class="col s1"></div>
					  			</div>
					   <br>
                             <div id = "cftr">Already Registered? -><a href="reg.jsp">Register Here</a></div>
						
				</form>
				</div>
        </div>
        <div class="col s4"></div>
        </div>
        </div>
        
                	<%
                        HttpSession session2 = request.getSession(false);
                        String str = (String)session2.getAttribute("error");
                        if(str!= null){
                            out.println(str);
                        }
                        session2.invalidate();
                                       
               		 %>
				<script src="jquery.min.js"    type="text/javascript"></script>
				<script src="materialize.min.js" type="text/javascript"></script>        
    </body>
</html>
