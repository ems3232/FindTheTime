package ee461l;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LeaderDelegateServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
		// remember to change the package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String teamName = req.getParameter("teamName");
		String newLeader = req.getParameter("newLeader");//button needs to display new leader
		String oldposition = "user1";
		
		
		String appName = "default";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key appKey = KeyFactory.createKey("Time", appName);
		
	    Query query = new Query("group", appKey);
	    List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
	    
	    for (Entity e : groups) {
	    	if (e.getProperty("teamName").toString().equals(teamName)) { 
	    			    		
	    		if(e.getProperty("user1Flag").equals(true)){   // find the old position of the new leader
		    		if(e.getProperty("user1").toString().equalsIgnoreCase(newLeader)){
		    			oldposition = "user1";
		    		}
	    		}
	    		 if(e.getProperty("user2Flag").equals(true)){
		    		if(e.getProperty("user2").toString().equalsIgnoreCase(newLeader)){
		    			oldposition = "user2";		           
		    		}
	    		}
	    		 if(e.getProperty("user3Flag").equals(true)){
		    		if(e.getProperty("user3").toString().equalsIgnoreCase(newLeader)){
		    			oldposition = "user3";		            
		    		}
	    		}
	    		 if(e.getProperty("user4Flag").equals(true)){
		    		if(e.getProperty("user4").toString().equalsIgnoreCase(newLeader)){
		    			oldposition = "user4";
		    		}
	    		}
	    		 if(e.getProperty("user5Flag").equals(true)){
		    		if(e.getProperty("user5").toString().equalsIgnoreCase(newLeader)){
		    			oldposition = "user5";		              
		    		}
	    		}
	    		
	    		//exchange position
	    		e.setProperty(oldposition, e.getProperty("user0").toString());
	    		e.setProperty("user0", newLeader);
	    		datastore.put(e);
	    	}
	    }
	    resp.sendRedirect("");
	}
	
}