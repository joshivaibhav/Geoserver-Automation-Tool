<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
    	<title>Login Validate</title>
    </head>
    <body>
       <%
    try{
        String username = request.getParameter("uname");   
        String password = request.getParameter("pass");
       
        Class.forName("org.postgresql.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgis_24_sample", "postgres","admin123");
        conn.setAutoCommit(false);
        Statement stat = conn.createStatement();
       
        String qry = "SELECT * FROM user_master where id='"+username+"'and password='"+password+"'";
        
        ResultSet rs = stat.executeQuery(qry);
        HttpSession session1=request.getSession();     
                if(rs.next())
                {         
                     
                     session1.setAttribute("username",username);
                     response.sendRedirect("main.jsp");
                }
                else{
                       
                        session1.setAttribute("error","Invalid Credentials");
                        response.sendRedirect("Login.jsp");
                       
                    
                }
        rs.close();
        stat.close();
        conn.close();
        
    }
           
   catch(Exception e){       
       out.println("Something went wrong !! Please try again "+e.getMessage());       
   }      
%>
    </body>
</html>
