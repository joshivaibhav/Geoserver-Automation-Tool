<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%ResultSet rs = null;%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="materialize.min.css"  media="screen,projection"/>

    </head>
    <body>
        
       <%
           try{
                   Class.forName("org.postgresql.Driver"); 
                   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5436/postgis_24_sample", "postgres","root");
                   conn.setAutoCommit(false);
                   Statement stat = conn.createStatement();

                
                    rs = stat.executeQuery("Select * from india_ds");

                        
            }
            catch(Exception e){       
                    out.println("Something went wrong !! Please try again "+e.getMessage());       
            }      
       %>
       <nav>
    <div class="nav-wrapper">
      <a href="#" class="brand-logo center">GIS</a>
      <ul id="nav-mobile" class="right hide-on-med-and-down">
        <li><a href="#">Maps</a></li>
        <li><a href="#">Visuals</a></li>
        <li><a href="#">About</a></li>
      </ul>
    </div>
           
           
  </nav>
        
   <div class="row">
    <div class="col s3"><p>This is a side menu with drop downs</p>
    <div class="input-field col s9">
    <select>
      <option value="" disabled selected>Choose your option</option>
      <%
          while(rs.next()){ %>
          <option value=""><% rs.getString("state"); %></option>
          <%}
           rs.close();
      %>
      
    </select>
    <label>State</label>
  </div>
</div>    
    <div class="col s9" style="background-color:gray"><p>This will contain the map</p></div>
	</div>  
      <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="materialize.min.js"></script>  
    </body>
</html>
