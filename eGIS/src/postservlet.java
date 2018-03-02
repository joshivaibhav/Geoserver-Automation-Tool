

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class postservlet
 */
@WebServlet("/postservlet")
public class postservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public postservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		  final String USER_AGENT = "Mozilla/5.0";
	 
		 // HTTP Post request
		 
		  String value = request.getParameter("wkspace");
		 
		  String url = "http://localhost:7000/geoserver/rest/workspaces/"+value+"?recurse=true";
		  URL obj = new URL(url);
		  HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		 
		        // Setting basic post request
		  
		  con.setRequestMethod("DELETE");
		  con.setRequestProperty("User-Agent", USER_AGENT);
		  con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		  con.setRequestProperty("Content-Type","application/json");
		  
		  //String postJsonData = "{\"\":5,\"countryName\":\"USA\",\"population\":8000}";
		  
		  // Send post request
		  con.setDoOutput(true);
		  DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		  
		  wr.flush();
		  wr.close();
		 
		  int responseCode = con.getResponseCode();
		  System.out.println("Sending 'E' request to URL : " + url);
		  //System.out.println("Post Data : " + postJsonData);
		  System.out.println("Response Code : " + responseCode);
		 
		  BufferedReader in = new BufferedReader(
		          new InputStreamReader(con.getInputStream()));
		  String output;
		  StringBuffer res = new StringBuffer();
		 
		  while ((output = in.readLine()) != null) {
		   res.append(output);
		  }
		  in.close();
		  
		  //printing result from response
		  System.out.println(res.toString());
		 
		}
		
		
		


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
