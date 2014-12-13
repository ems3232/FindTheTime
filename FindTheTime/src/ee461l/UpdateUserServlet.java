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

public class UpdateUserServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
		// remember to change the package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String member = user.getEmail();
	String check_event = req.getParameter("eventName");
	
	String appName = "default";
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key appKey = KeyFactory.createKey("Time", appName);

    Query query2 = new Query("users", appKey);
    List<Entity> usersList = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
    
    for (Entity i : usersList) {
    	if (i.getProperty("userEmail").toString().equalsIgnoreCase(member)) {
    		
    		String calendar = i.getProperty("calendar").toString();   		
    		String[] eventList = calendar.split("&");
    		boolean check = false;
    		
    		if(!calendar.contains("&"))
    		{
    			String[] eventSingle =calendar.split("_");
    			if(eventSingle[0].equals(check_event))
    			{
    				i.setProperty("calendar", "false");
    				datastore.put(i);
    			}
    		}
    		else{
    		
 		    for(int j = 0; j < eventList.length; j++){
 		    	
 		    	String[] event = eventList[j].split("_");
 		    	
 		    	if(event[0].equals(check_event)){
 		    		
 		    		check = true;
 		    		//String newString = check_event;      		// first index
 		    		//for(int a = 1; a < event.length; a++){		//re-combine everything else together
 		    		//	newString = newString + "_" + event[a];
 		    		//}
 		    		eventList[j] = "DELETE";
 		    	}
 		    }
 		    
 		    if(check == true){
    	
 		    	int index = 1;
 		    	String result = "";
 		    	if(eventList[0].equals("DELETE")){
 		    		result = eventList[1];
 		    		index = 2;
 		    	}
 		    	else{
 		    		result = eventList[0];
 		    	}
 		    	
	 		    for (int a = index; a < eventList.length; a++){
	 		    	if(!eventList[a].equals("DELETE")){
	 		    		result = result + "&" + eventList[a];
	 		    	}
	 		    }
	 		  
	 		    i.setProperty("calendar", result);
	 		    datastore.put(i);
	 		    check = false;
 		    }
    	
    		}
    	}// IF FOUND USER
    } //user ENTITY 

    
    resp.sendRedirect("/viewCalendar.jsp");
}
    
}

