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
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateCalendarServlet extends HttpServlet{
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String appName = "default";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        Key appKey = KeyFactory.createKey("Time", appName);
        Query query = new Query("group", appKey);
        List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
        
     
        for (Entity e : groups) {
        	for (Integer i = 0; i <= 5; i++) {
            	if (e.getProperty("user" + i.toString())!=null){
        		if (e.getProperty("user" + i.toString()).toString().equalsIgnoreCase(user.getEmail())) {
            		e.setProperty("Cal" + i.toString() + "Flag", true);
            		datastore.put(e);
            		break;
            	}
            }
        	}
        }
       
        resp.sendRedirect("/FindTheTime.jsp");
}
}