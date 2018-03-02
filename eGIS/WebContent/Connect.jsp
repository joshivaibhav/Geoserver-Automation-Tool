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
<title>Test DB</title>
</head>
<body>

<%

try {
		Class.forName("org.postgresql.Driver");
	}catch(ClassNotFoundException e){
		out.println(e.getMessage());
	}
	out.println("HELLO HELLO");
	try{
    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgis_24_sample", "postgres","admin123");
    conn.setAutoCommit(false);
    Statement stat = conn.createStatement();
    ResultSet rs = stat.executeQuery("Select distinct state from india_ds order by state");          
    while (rs.next())
    {
        
    	out.println(rs.getString("state"));
        
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
</body>
</html>