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

public class TimeServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	
	//change the parameters
	String teamName = req.getParameter("teamName");
	String starthour = req.getParameter("start1");
	String startmin = req.getParameter("start2");
	int start = Integer.parseInt(starthour) * 100 + Integer.parseInt(startmin);
	
	String endhour = req.getParameter("end1");
	String endmin = req.getParameter("end2");
	int end = Integer.parseInt(endhour) * 100 + Integer.parseInt(endmin);
	
	String meetinghour = req.getParameter("meeting1");
	String meetingmin = req.getParameter("meeting2");
	int meeting = Integer.parseInt(meetinghour) * 60 + Integer.parseInt(meetingmin);

	
	String appName = "default";
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key appKey = KeyFactory.createKey("Time", appName);

    Query query = new Query("group", appKey);
    List<Entity> groups = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
    
    
    for (Entity e : groups) {
    	
    	if (e.getProperty("teamName").toString().equals(teamName)) { 
    		e.setProperty("starttime", start);
    		e.setProperty("endtime", end);
    		e.setProperty("meetingtime", meeting);
    	}
    }  

 
    resp.sendRedirect("");
}
    
}

