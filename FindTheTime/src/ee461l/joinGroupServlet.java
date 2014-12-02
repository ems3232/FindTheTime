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

public class joinGroupServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String teamName = req.getParameter("teamName");
		System.out.print(teamName);
		String appName = "default";
		//System.out.print(appName);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        Key appKey = KeyFactory.createKey("Time", appName);
       
        //get the user entity
        Query query = new Query("users", appKey);
        List<Entity> usersList = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
        
        boolean found = false;
        Entity users = null;
        for (Entity e : usersList) {
        	if (e.getProperty("userEmail").toString().equals(user.getEmail())) {
        		found = true;
        		users = e;
        		break;
        	}
        }
       
        if (found == false) {
        	users = createUser(user,appKey);
        datastore.put(users);}
        //get the team entity
        query = new Query("group", appKey);
        List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
        
        Entity teamEntity = null;
        for (Entity e : groups) {
        	if (e.getProperty("teamName").toString().equals(teamName)) {
        		teamEntity = e;
        		break;
        	}
        }
     
      
     
        //add user to group
        for (Integer i = 1; i <= 5; i++) {
        	if (teamEntity.getProperty("user" + i.toString()).equals(user.getEmail())) {
        		teamEntity.setProperty("user" + i.toString() + "Flag", true);
        		break;
        	}
        }
     
        //add group to user
        for (Integer i = 1; i <= 4; i++) {
        	if(users.getProperty("group" + i.toString()) !=null) {}
        	else {
        		users.setProperty("group" + i.toString(), teamName);
        		break;
        	}
        }
       datastore.put(teamEntity);
       datastore.put(users);
        //redirect to user's group page
        resp.sendRedirect("/FindTheTime.jsp");
	}
	
	private Entity createUser(User	user,Key appKey) {
		Entity newUserEntity = new Entity("users",appKey);
		newUserEntity.setProperty("userEmail", user.getEmail().toLowerCase());
		newUserEntity.setProperty("group1", null);
		newUserEntity.setProperty("group2", null);
		newUserEntity.setProperty("group3", null);
		newUserEntity.setProperty("group4", null);		
		return newUserEntity;
	}
	
}
