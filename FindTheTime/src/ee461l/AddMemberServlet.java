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
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddMemberServlet extends HttpServlet {

	protected void doPost (HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		String teamName= req.getParameter("teamName");
		 String strCallResult= "Hello"+ "\n"+"You are invited to "+teamName+""+ "\n"+
          		"Please Join this group"+"\n"+"\nJust Type in "+
          		teamName+"In the correct Field"+"\nhttp://kellyfindthetime67.appspot.com/FindTheTime.jsp"+
          		"\nPlease sign in and Go to the Join Group Tab. Thank you and Enjoy";
	    UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        Key timeKey = KeyFactory.createKey("Time", "default");
        
        Query query2 = new Query("group", timeKey);
        List<Entity> groups = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
        boolean founded=false;
        Entity teamEntity = null;
        for (Entity e : groups) {
        	if (e.getProperty("teamName").toString().equals(teamName)) {
        		teamEntity = e;
        		founded=true;
        		break;
        	}
           }
		int slotNumber=Integer.parseInt(req.getParameter("slotNumber").toString());
		String userAdd="user"+slotNumber;
		String newMember=req.getParameter("newMember").toString().toLowerCase();
		teamEntity.setProperty(userAdd,newMember);
		datastore.put(teamEntity);
		sendEmail(strCallResult,userAdd);
		resp.sendRedirect("/myGroups.jsp");
		
	}
	public void sendEmail(String strCallResult,String userPerson){
    	Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
    	try{
    		MimeMessage outMessage = new MimeMessage(session);
		outMessage.setFrom(new InternetAddress("admin@findthetimeteamlegit67.appspotmail.com"));
		outMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(userPerson));
		outMessage.setSubject("You Are Invited!");
		outMessage.setText(strCallResult);
		Transport.send(outMessage);}
    	catch (MessagingException e) { 
			//Logger _log = null;
		//	_log.info("ERROR: Could not send out Email : " + e.getMessage());
		}
    
    }	
}
