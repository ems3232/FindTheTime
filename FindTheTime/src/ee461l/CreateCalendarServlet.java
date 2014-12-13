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
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateCalendarServlet extends HttpServlet{
	

		
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String appName = "default";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        Key appKey = KeyFactory.createKey("Time", appName);
        Query query = new Query("users", appKey);
        List<Entity> usersList = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
        Entity users=null;
        String cal="";
        String event="";
        for(Entity e : usersList) {
         	if (e.getProperty("userEmail").toString().equalsIgnoreCase(user.getEmail())) {
         		users = e;
         		break;
         	}
         }
        if(!users.getProperty("calendar").toString().equals("false")){
        	cal=users.getProperty("calendar").toString()+"&";
        	users.setProperty("calendar",cal);
        	datastore.put(users);
        }
      
        String sizeRow= req.getParameter("rowNumber");
        int rowSize=Integer.parseInt(sizeRow);
        for(int i=1; i<=rowSize;i++){
        	String name="Event"+i+"Name";
        	String eventName= req.getParameter(name);
        	
        	String srtHour="Event"+i+"StartHour";
        	String startHour= req.getParameter(srtHour);
        	
        	String srtMin="Event"+i+"StartMin";
        	String startMin= req.getParameter(srtMin);
        	
        	String edHour="Event"+i+"EndHour";
        	String endHour= req.getParameter(edHour);
        	
        	String edMin="Event"+i+"EndMin";
        	String endMin= req.getParameter(edMin);
        	
        	String reOccur="Event"+i+"Reoccur";
        	String REOCCUR= req.getParameter(reOccur);
        	
        	ArrayList<String> dayValues=new ArrayList<String>();
        	String day0="Event"+i+"Sun";
        	String sun= req.getParameter(day0);
        	if(sun !=null){dayValues.add("sun");}
        	
        	String day1="Event"+i+"Mon";
        	String mon= req.getParameter(day1);
        	if(mon !=null){dayValues.add("mon");}

        	String day2="Event"+i+"Tue";
        	String tue= req.getParameter(day2);
        	if(tue !=null){dayValues.add("tue");}

        	String day3="Event"+i+"Wed";
        	String wed= req.getParameter(day3);
        	if(wed !=null){dayValues.add("wed");}

        	String day4="Event"+i+"Thu";
        	String thu= req.getParameter(day4);
        	if(thu !=null){dayValues.add("thu");}

        	String day5="Event"+i+"Fri";
        	String fri= req.getParameter(day5);
        	if(fri !=null){dayValues.add("fri");}

        	String day6="Event"+i+"Sat";
        	String sat= req.getParameter(day6);
        	if(sat !=null){dayValues.add("sat");}
        	
        	String days="";
        	for(int j=0;j<dayValues.size();j++)
        	{
        	if((j+1==dayValues.size()) && (i==rowSize))
        		{days=days+dayValues.get(j);}
        	
        	else if(j+1==dayValues.size())
       	     	{days=days+dayValues.get(j)+"&";}
  
        	else
        	{days=days+dayValues.get(j)+"_";}
        	}
        	
      event=event+eventName+"_"+REOCCUR+"_"+startHour+":"+startMin+"_"+
       endHour+":"+endMin+"_"+days;
        }
        
        if(users.getProperty("calendar").toString().equals("false"))
        {
        	users.setProperty("calendar", event);
        	datastore.put(users);
        }
        else{
        String oldCalendar=users.getProperty("calendar").toString();
        oldCalendar=oldCalendar+event;
    
        users.setProperty("calendar",oldCalendar);
        datastore.put(users);
        }
        resp.sendRedirect("/viewCalendar.jsp");
	}
	 
}