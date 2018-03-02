import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


/**
 * Servlet implementation class Myservice
 */
@WebServlet("/Myservice")
public class Myservice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Myservice() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
				List <String> list = new ArrayList<String>();
				String json = null;
				String val = request.getParameter("statename");
				Class.forName("org.postgresql.Driver");
	            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgis_24_sample", "postgres","admin123");
	            conn.setAutoCommit(false);
	            Statement stat = conn.createStatement();
	            System.out.println(val);
	            ResultSet rs = stat.executeQuery("Select district from india_ds where state = '"+val+"'");
	            
	            while (rs.next())
	            {
                
	            	list.add(rs.getString("district"));
            	//response.getWriter().println(rs.getString("district"));
            	
	            }
            
	            json = new Gson().toJson(list);
	            response.setContentType("application/json");
	            response.getWriter().write(json);

	            rs.close();
	            stat.close();
	            conn.close();
        }
        catch(Exception e)
        {       
             response.getWriter().println("Something went wrong !! Please try again "+e.getMessage());       
        }
    
		
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
