

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.google.gson.Gson;
import it.geosolutions.geoserver.rest.decoder.RESTCoverage;
import it.geosolutions.geoserver.rest.decoder.RESTCoverageList;
import it.geosolutions.geoserver.rest.decoder.RESTCoverageStore;
import it.geosolutions.geoserver.rest.decoder.RESTCoverageStoreList;
import it.geosolutions.geoserver.rest.decoder.RESTDataStore;
import it.geosolutions.geoserver.rest.decoder.RESTDataStoreList;
import it.geosolutions.geoserver.rest.decoder.RESTFeatureType;
import it.geosolutions.geoserver.rest.decoder.RESTFeatureTypeList;
import it.geosolutions.geoserver.rest.decoder.RESTLayer;
import it.geosolutions.geoserver.rest.decoder.RESTLayer21;
import it.geosolutions.geoserver.rest.decoder.RESTLayerGroup;
import it.geosolutions.geoserver.rest.decoder.RESTLayerGroupList;
import it.geosolutions.geoserver.rest.decoder.RESTLayerList;
import it.geosolutions.geoserver.rest.decoder.RESTNamespace;
import it.geosolutions.geoserver.rest.decoder.RESTNamespaceList;
import it.geosolutions.geoserver.rest.decoder.RESTResource;
import it.geosolutions.geoserver.rest.decoder.RESTStructuredCoverageGranulesList;
import it.geosolutions.geoserver.rest.decoder.RESTStructuredCoverageIndexSchema;
import it.geosolutions.geoserver.rest.decoder.RESTStyle;
import it.geosolutions.geoserver.rest.decoder.RESTStyleList;
import it.geosolutions.geoserver.rest.decoder.RESTWms;
import it.geosolutions.geoserver.rest.decoder.RESTWmsList;
import it.geosolutions.geoserver.rest.decoder.RESTWmsStore;
import it.geosolutions.geoserver.rest.decoder.RESTWmsStoreList;
import it.geosolutions.geoserver.rest.decoder.RESTWorkspaceList;
import it.geosolutions.geoserver.rest.decoder.about.GSVersionDecoder;
import it.geosolutions.geoserver.rest.manager.GeoServerRESTStructuredGridCoverageReaderManager;
import it.geosolutions.geoserver.rest.manager.GeoServerRESTStyleManager;


/**
 * Servlet implementation class Myrestservlet
 */
@WebServlet("/Myrestservlet")
public class Myrestservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Myrestservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				
				List <String> list = new ArrayList<String>();
				Client client = ClientBuilder.newClient();
				WebTarget target = client.target("http://localhost:7000/geoserver/rest/workspaces");
				String json=target.request(MediaType.APPLICATION_JSON).get(String.class);
				Map<String, String> jsonmap = new HashMap<String, String>();
				
				
				JSONParser parser = new JSONParser();
		        Object obj;
				try {
					obj = parser.parse(json);
					JSONObject lev1 = (JSONObject) obj;					
					Object jObj = lev1.get("workspaces");
			        if (jObj instanceof Map) {
			            Map map = (Map) jObj;
			            Set keySet = map.keySet();
			            for (Object s : keySet) {
			                JSONObject jsonObj = (JSONObject) jObj;
			                JSONArray jarr = (JSONArray) jsonObj.get(s.toString());
			                for (int i = 0; i < jarr.size(); i++) {
			                    Object get = jarr.get(i);
			                    JSONObject job = (JSONObject) get;
			                    
			                    jsonmap.put(job.get("name").toString(),job.get("href").toString());
			        
			                }
			            }
			        }
			        
			        json = new Gson().toJson(jsonmap);
    	            response.setContentType("application/json");
    	            response.getWriter().write(json);
    				

				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
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
