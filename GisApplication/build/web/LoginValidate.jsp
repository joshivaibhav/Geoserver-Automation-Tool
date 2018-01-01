<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Validate</title>
    </head>
    <body>
       <%
    try{
        String username = request.getParameter("uname");   
        String password = request.getParameter("pass");
        Class.forName("org.postgresql.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5436/postgres", "postgres","root");
        conn.setAutoCommit(false);
        Statement stat = conn.createStatement();
       
        String qry = "SELECT * FROM login where id='"+username+"'and password='"+password+"'";
      
        ResultSet rs = stat.executeQuery(qry);
           
                if(rs.next())
                {         
                    
                        response.sendRedirect("main.jsp");
                }
                else{
                       out.println("Invalid login credentials");            
                }
        stat.close();
        conn.close();
        
    }
           
   catch(Exception e){       
       out.println("Something went wrong !! Please try again "+e.getMessage());       
   }      
%>
    </body>
</html>
