<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
                String user = request.getParameter("uname");    
                String pwd = request.getParameter("pass");
               
                Connection c = null;
                Statement stmt = null;
                try
                {
                        Class.forName("org.postgresql.Driver");
                        out.println("<h4>Succcess</h4>");
                        c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/GisApplication","postgres", "root");
                        stmt = c.createStatement();
 
                        String sql = "INSERT INTO Login (ID,Password)"+ "VALUES('"+user+"','"+pwd+"')";
                        int i = stmt.executeUpdate(sql);
                        
                        stmt.close();
                        c.commit();
                        c.close();
                         
                   if (i > 0){
        
                          out.print("Registration Successfull!"+"<a href='Login.jsp'>Go to Login</a>");
                    } 
                   else {
                          response.sendRedirect("Login.jsp");
                    }
                
                }
                catch (Exception e) 
                {
                    e.printStackTrace();
                    System.err.println(e.getClass().getName()+": "+e.getMessage());
                    System.exit(0);
                }
    
        %>
 