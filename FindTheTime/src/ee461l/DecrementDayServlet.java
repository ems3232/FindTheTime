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
public class DecrementDayServlet extends HttpServlet {
public void	doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
	
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key timeKey = KeyFactory.createKey("Time", "default");
	
    Query query2 = new Query("group",timeKey);
    List<Entity> groups = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(5000));
    boolean founded=false;
    Entity teamEntity = null;
    for (Entity e : groups) {
     int days= Integer.parseInt((e.getProperty("dayLimit").toString()));
     days=days-1;
     if(days==0){
    	 datastore.delete(e.getKey());
     }
     else{
     e.setProperty("dayLimit", days);
     datastore.put(e);
    	}
    }
   }
}
