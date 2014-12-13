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
//tested, needs to have full on testing

public class LeaderDisbandServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
		// remember to change the package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String teamName = req.getParameter("teamName");
	String appName = "default";
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key appKey = KeyFactory.createKey("Time", appName);

    Query query = new Query("group", appKey);
    List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
    
    Query query2 = new Query("users", appKey);
    List<Entity> usersList = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
   
    for (Entity e : groups) {
    	
    	if (e.getProperty("teamName").toString().equals(teamName)) { // get the desired group from the group list
    		
    		for(Entity i : usersList) { // go through each users
    				
    			//if(i.getProperty("user" + i.toString() + "Flag").equals(true)){ // check if the user is valid
    	    		if(i.getProperty("group1")!=null){
        			if(((i.getProperty("group1").toString()).equals(teamName))){   // compare if the user is in the disband group. check for each groups
    	    			i.setProperty("group1", null);
    	    			
    	    		}}
    	    		if(i.getProperty("group2")!=null){
    	    		if((i.getProperty("group2").toString()).equals(teamName)){ 
    	    			i.setProperty("group2", null); 
    	    			
    	    		}}
    	    		if(i.getProperty("group3")!=null){
    	    		if((i.getProperty("group3").toString()).equals(teamName)){ 
    	    			i.setProperty("group3", null);
    	    			
    	    		}}
    	    		if(i.getProperty("group4")!=null){
    	    		if((i.getProperty("group4").toString()).equals(teamName)){ 
    	    			i.setProperty("group4", null);
    	    		}}
    			datastore.put(i);
    		}
    		datastore.delete(e.getKey()); // I think this is right, need to double check though
			//it deletes the entity of that group entirely 
    	}
    
    }  

    resp.sendRedirect("");
}
    
}

