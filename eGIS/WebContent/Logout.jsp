<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
            <%
                HttpSession session1=request.getSession();  
                session1.invalidate();
                response.sendRedirect("Login.jsp");
            %>     
    </body>
</html>
