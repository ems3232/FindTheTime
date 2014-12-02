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

public class CreateGroupServlet extends HttpServlet {

     
    /**
	 * 
	 */
	//private static final long serialVersionUID = -1756831540924740457L;
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        String user0 =user.toString(); 
        String guestBookName ="default";
        String strCallResult="";
        int count=0;
        String failures="This email was not valid\n";
        Key timeKey = KeyFactory.createKey("Time", guestBookName);
            String teamName = req.getParameter("teamName");   
            String user1 = req.getParameter("user1");
            String user2 = req.getParameter("user2");
            String user3 = req.getParameter("user3");
            String user4 = req.getParameter("user4");
            String user5 = req.getParameter("user5");
            strCallResult= "Hello"+ "\n"+"You are invited to -"+teamName+"-"+ "\n"+
            		"Please Join this group"+"\n"+"just type in -"+teamName+"-\nIn the correct Field"
            		+"Please sign in, need to check if you all get in -Kelly"+
            		"\n go to kellyfindthetime67.appspot.com , you need to use the team name hopethisfuckingworks";
            				
          //  Date date = new Date();
            Entity group = new Entity("group", timeKey);
            group.setProperty("teamName", teamName);
            group.setProperty("user0", user0);
            group.setProperty("user0Flag", true);
            sendEmail(strCallResult, user0);
            Entity users =createUser(user,timeKey,teamName);
            
            if (isValidEmailAddress(user1)){
            group.setProperty("user1", user1);
            group.setProperty("user1Flag",false);

            sendEmail(strCallResult, user1);
            }
            else{
            	count=count+1;
            	failures=failures + user1+"\n";        	
            }
            if (isValidEmailAddress(user2)){
                group.setProperty("user2", user2);
                group.setProperty("user2Flag",false);
             sendEmail(strCallResult, user2);
                }
                else{
                	count=count+1;
                	failures=failures + user1+"\n";        	
                }  
            if (isValidEmailAddress(user3)){
                    group.setProperty("user3", user3);
                    group.setProperty("user3Flag",false);

                  sendEmail(strCallResult, user3);
                    }
                else{
                	count=count+1;
                	failures=failures + user3+"\n";        	
                }  
            if (isValidEmailAddress(user4)){
                    group.setProperty("user4", user4);
                    group.setProperty("user4Flag",false);

                   sendEmail(strCallResult, user4);
                    }
                else{
                	count=count+1;
                	failures=failures + user4+"\n";        	
                }  
            if (isValidEmailAddress(user5)){
                    group.setProperty("user5", user5);
                    group.setProperty("user5Flag",false);
                 sendEmail(strCallResult, user5);
                    }
                else{
                	count=count+1;
                	failures=failures + user5+"\n";        	
                }
         DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
         datastore.put(users);
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
  
public void sendEmail(String strCallResult,String userPerson){
    	Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
    	try{
    		MimeMessage outMessage = new MimeMessage(session);
		outMessage.setFrom(new InternetAddress("admin@kellyfindthetime67.appspotmail.com"));
		outMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(userPerson));
		outMessage.setSubject("You Are Invited!");
		outMessage.setText(strCallResult);
		Transport.send(outMessage);}
    	catch (MessagingException e) { 
			//Logger _log = null;
		//	_log.info("ERROR: Could not send out Email : " + e.getMessage());
		}
    
    }
   private Entity createUser(User user,Key timeKey,String teamName) {
		Entity newUserEntity = new Entity("users",timeKey);
		newUserEntity.setProperty("userEmail", user.getEmail());
		newUserEntity.setProperty("group1", teamName);
		newUserEntity.setProperty("group2", null);
		newUserEntity.setProperty("group3", null);
		newUserEntity.setProperty("group4", null);		
		return newUserEntity;
	}
    
}

