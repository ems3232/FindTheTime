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

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateGroupServlet extends HttpServlet {

     
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        String user0 =user.toString(); 
        String guestBookName ="default";
        int count=0;
        String failures="This email was not valid\n";
        Key timeKey = KeyFactory.createKey("blog", guestBookName);
            String teamName = req.getParameter("teamName");   
            String user1 = req.getParameter("user1");
            String user2 = req.getParameter("user2");
            String user3 = req.getParameter("user3");
            String user4 = req.getParameter("user4");
            String user5 = req.getParameter("user5");
     
          //  Date date = new Date();
            Entity group = new Entity(teamName, timeKey);
          
            group.setProperty("user0", user0);
            if (isValidEmailAddress(user1)){
            group.setProperty("user1", user1);}
            else{
            	count=count+1;
            	failures=failures + user1+"\n";        	
            }
            if (isValidEmailAddress(user2)){
                group.setProperty("user2", user2);}
                else{
                	count=count+1;
                	failures=failures + user1+"\n";        	
                }  
            if (isValidEmailAddress(user3)){
                    group.setProperty("user3", user3);}
                else{
                	count=count+1;
                	failures=failures + user3+"\n";        	
                }  
            if (isValidEmailAddress(user4)){
                    group.setProperty("user4", user4);}
                else{
                	count=count+1;
                	failures=failures + user4+"\n";        	
                }  
            if (isValidEmailAddress(user5)){
                    group.setProperty("user5", user5);}
                else{
                	count=count+1;
                	failures=failures + user5+"\n";        	
                }
         DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
         datastore.put(group);
         if(count !=0){
        	 resp.sendRedirect("/FindTheTime.jsp?blogName=" + guestBookName);
             return;}
             else{
          resp.sendRedirect("/FindTheTime.jsp?blogName=" + failures);
         return;}
    }    
    public static boolean isValidEmailAddress(String email) {
    	   boolean result = true;
    	   try {
    	      InternetAddress emailAddr = new InternetAddress(email);
    	      emailAddr.validate();
    	   } catch (AddressException ex) {
    	      result = false;
    	   }
    	   return result;
    	}
    
}

