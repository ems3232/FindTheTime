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

public class LeaderKickServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
		// remember to change the package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String teamName = req.getParameter("teamName");
	String kickmember = req.getParameter("kickMember");
	
	String appName = "default";
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key appKey = KeyFactory.createKey("Time", appName);
	
    Query query = new Query("group", appKey);
    List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
    Query query2 = new Query("users", appKey);
    List<Entity> usersList = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
   
    Entity test=new Entity("test",appKey);
    test.setProperty("MemberKick",kickmember);
    test.setProperty("teamName", teamName);
    test.setProperty("user", user.getEmail());
    datastore.put(test);
    for (Entity e : groups) {
    	if (e.getProperty("teamName").toString().equals(teamName)) { 
    		
    		if(e.getProperty("user1") !=null){		//not sure about .equal, need to double check @@@@@@@@@@@@@@@@
	    		if(e.getProperty("user1").toString().equals(kickmember)){
	    			e.setProperty("user1", "N/A");
	                e.setProperty("user1Flag",false);
	               // e.setProperty("Cal1Flag", false);
	    		}
    		}
    		 if(e.getProperty("user2")!=null){
	    		if(e.getProperty("user2").toString().equals(kickmember)){
	    			e.setProperty("user2", "N/A");
	                e.setProperty("user2Flag",false);
	             //   e.setProperty("Cal2Flag", false);
	    		}
    		}
    		 if(e.getProperty("user3")!=null){
	    		if(e.getProperty("user3").toString().equals(kickmember)){
	    			e.setProperty("user3", "N/A");
	                e.setProperty("user3Flag",false);
	             //   e.setProperty("Cal3Flag", false);
	    		}
    		}
    		 if(e.getProperty("user4")!=null){
	    		if(e.getProperty("user4").toString().equals(kickmember)){
	    			e.setProperty("user4", "N/A");
	                e.setProperty("user4Flag",false);
	             //   e.setProperty("Cal4Flag", false);
	    		}
    		}
    		 if(e.getProperty("user5")!=null){
	    		if(e.getProperty("user5").toString().equals(kickmember)){
	    			e.setProperty("user5", "N/A");
	                e.setProperty("user5Flag",false);
	              //  e.setProperty("Cal5Flag", false);
	    		}
    		}
    		datastore.put(e);
    		for(Entity i : usersList) { // go through each users
			  if(i.getProperty("userEmail").toString().equalsIgnoreCase(kickmember)){	
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
    		}//IN THE CORRECT USER ENTITY
    	}//Entity for USER FOR LOOP
    }//INSIDE THE GROUP ENITY IF, AKA THE CORRECT GROUP ENTITY  
    }//Entity for Group FOR LOOP
	
    
    resp.sendRedirect("");
	}//do Post
    
}

