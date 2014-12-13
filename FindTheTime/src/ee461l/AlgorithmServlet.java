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
import java.util.ArrayList;
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
//i.getProperty("calendar")
public class AlgorithmServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
		// remember to change the package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String teamName = req.getParameter("teamName");
		
		ArrayList<Boolean> each_row = new ArrayList<Boolean>();
		ArrayList<ArrayList<Boolean>> matrix = new ArrayList<ArrayList<Boolean>>();   // we can change this if we want to
		for(int i = 0; i < 6; i++){
			matrix.add(new ArrayList<Boolean>());
		}
		
		String appName = "default";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key appKey = KeyFactory.createKey("Time", appName);
		
	    Query query = new Query("group", appKey);
	    List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));	    
	    Query query2 = new Query("users", appKey);
	    List<Entity> usersList = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
	    Entity e;
	    FTTCalendar plz=new FTTCalendar();
	    for(Entity s: groups) {
	    	if (s.getProperty("teamName").toString().equals(teamName)) {
	    		e = s;
	    		if(e.getProperty("user0Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",0);
	    			plz.getgroupConflicts().set(0,each_row);
	    		}
	    		if(e.getProperty("user1Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",1);;
	    			plz.getgroupConflicts().set(1,each_row);
	    		}
	    		if(e.getProperty("user2Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",2);;
	    			plz.getgroupConflicts().set(2,each_row);
	    		}
	    		if(e.getProperty("user3Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",3);;
	    			plz.getgroupConflicts().set(3,each_row);
	    		}
	    		if(e.getProperty("user4Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",4);;
	    			plz.getgroupConflicts().set(4,each_row);
	    		}
	    		if(e.getProperty("user5Flag").equals(false)){
	    			each_row = plz.setUserCalendar("false",5);;
	    			plz.getgroupConflicts().set(5,each_row);
	    		}	    	
	    	}
	    }
	   
	    for(Entity t: groups) {
	    	if (t.getProperty("teamName").toString().equals(teamName)) {
	    		
		for(Entity i : usersList) { // go through each users
			
		
				if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user0").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),0);
					plz.getgroupConflicts().set(0,each_row);
				}
				if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user1").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),1);
					plz.getgroupConflicts().set(1,each_row);		
				}
			    if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user2").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),2);
					plz.getgroupConflicts().set(2,each_row);
				}    				
			    if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user3").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),3);
					plz.getgroupConflicts().set(3,each_row);			
				}
			    if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user4").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),4);
					plz.getgroupConflicts().set(4,each_row);				
				}
			    if(i.getProperty("userEmail").toString().equalsIgnoreCase(t.getProperty("user5").toString())){
					each_row = plz.setUserCalendar(i.getProperty("calendar").toString(),5);
					plz.getgroupConflicts().set(5,each_row);				
				}		
		}	
		
		
		
		FTTAlgorithm alg = FTTAlgorithm.getAlgorithmInstance();
		
		int endHours=Integer.parseInt(t.getProperty("endTimeHours").toString());
		     endHours=endHours*100;
		int endMinutes=Integer.parseInt(t.getProperty("endTimeMinutes").toString());
			endHours=endHours+endMinutes;
		int startHours=Integer.parseInt(t.getProperty("startTimeHours").toString());
	     	startHours=startHours*100;
	    int startMinutes=Integer.parseInt(t.getProperty("startTimeMinutes").toString());
				startHours=startHours+startMinutes;
		int meetingTime=Integer.parseInt(t.getProperty("meetingLength").toString());
		
		ArrayList<String> result = alg.runAlgorithm (plz, meetingTime,startHours,endHours);
		for(int p=0;p<result.size();p++){
			String times="optimalTime"+(p+1);
			t.setProperty(times, result.get(p));
			datastore.put(t);
				}
	    }
		//e.getProperty("startTime"),e.getProperty("endTime")
		// not sure after this @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
		
		
	    }
		resp.sendRedirect("/myGroups.jsp");   	
	 

	
 
	
}
}