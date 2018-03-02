

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
/**
 * Servlet implementation class zoomServlet
 */
@WebServlet("/zoomServlet")
public class zoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public zoomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
				String val = request.getParameter("districts");
				Class.forName("org.postgresql.Driver");
		        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgis_24_sample", "postgres","admin123");
		        conn.setAutoCommit(false);
		        Statement stat = conn.createStatement();
		        System.out.println(val);
		        ResultSet result = stat.executeQuery("Select * from india_ds where district = '"+val+"'");          
		        JSONArray array=new JSONArray();
                JSONObject obj = new JSONObject();

                while(result.next())
                {
                	obj.put("maxx",result.getString("maxx"));
                    obj.put("maxy",result.getString("maxy"));
                    obj.put("minx",result.getString("minx"));
                    obj.put("miny",result.getString("miny"));
                	obj.put("dist_id",result.getString("dst_id"));
                    obj.put("district",result.getString("district"));
                    obj.put("state",result.getString("state"));
                    //obj.put("latitude",result.getString("latitude"));
                    //obj.put("longitude",result.getString("longitude"));
                    array.add(obj.toString());                    
                }   
                //out.print(array);
                for(int i=0;i<array.size();i++)
                {
                    response.getWriter().println(array.get(i));
                }
        
			        
	}catch(Exception e){
			response.getWriter().println("Exception: "+e);
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
