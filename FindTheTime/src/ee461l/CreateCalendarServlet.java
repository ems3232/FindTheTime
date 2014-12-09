package ee461l;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.calendar.Calendar;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.Collections;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateCalendarServlet extends HttpServlet{
	  static final String APP_NAME = "Google Calendar Data API Sample Web Client";

	  static final String GWT_MODULE_NAME = "calendar";


	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try { 
			HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
		    JacksonFactory jsonFactory = JacksonFactory.getDefaultInstance();
		    PrintWriter writer = resp.getWriter();
		    writer.println("Entering Authorization Servlet (CreateCalendarServlet)");
		    writer.println("<!doctype html><html><head>");
		    writer.println("<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">");
		    writer.println("<title>" + APP_NAME + "</title>");
		    writer.println(
		        "<link type=\"text/css\" rel=\"stylesheet\" href=\"" + GWT_MODULE_NAME + ".css\">");
		    writer.println("<script type=\"text/javascript\" language=\"javascript\" " + "src=\""
		        + GWT_MODULE_NAME + "/" + GWT_MODULE_NAME + ".nocache.js\"></script>");
		    writer.println("</head><body>");
		    UserService userService = UserServiceFactory.getUserService();
		    writer.println("<div class=\"header\"><b>" + "</b> | "
		        + "<a href=\"" 
		        + "\">Log out</a> | "
		        + "<a href=\"http://code.google.com/p/google-api-java-client/source/browse"
		        + "/calendar-appengine-sample?repo=samples\">See source code for "
		        + "this sample</a></div>");
		    writer.println("<div id=\"main\"/>");
		    writer.println("</body></html>");

		//   The clientId and clientSecret can be found in Google Developers Console
		    String clientId = "20631931335-bttt0p0mgca6rc7e3akbr35td21cb94a.apps.googleusercontent.com";
		    String clientSecret = "cV7UmLl_HE10QwRqJmGpLxt5";

		    // Or your redirect URL for web based applications.
		 //   GenericUrl url = new GenericUrl(req.getRequestURL().toString());
		  

	     //   url.setRawPath("/oauth2callback");
	        String redirectUrl = "http://kellyfindthetime67.appspot.com/createCal";
	        String scope = "https://www.googleapis.com/auth/calendar";
	        
		    GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow(
		        httpTransport, jsonFactory, clientId, clientSecret, Collections.singleton(scope));
		    // Step 1: Authorize
		    String authorizationUrl = flow.newAuthorizationUrl().setRedirectUri(redirectUrl).setAccessType("offline").build();

		    // Point or redirect your user to the authorizationUrl.
		 //   System.out.println("Go to the following link in your browser:");
		   writer.println(authorizationUrl);

		   //Read the authorization code from the standard input stream.
		//  BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		//   System.out.println("What is the authorization code?");
		//    try{
		//    String code = in.readLine();
		    // End of Step 1
		//    System.out.println("code = " + code);

		    // Step 2: Exchange
		//    GoogleTokenResponse response = flow.newTokenRequest(code).setRedirectUri(redirectUrl)
		//        .execute();
		    // End of Step 2
		    }
		    catch (IOException | GeneralSecurityException e){
		    	e.printStackTrace();
		    }
		    /*
		    Credential credential = new GoogleCredential.Builder()
		        .setTransport(httpTransport)
		        .setJsonFactory(jsonFactory)
		        .setClientSecrets(clientId, clientSecret)
		        .build().setFromTokenResponse(response);

		    Calendar service = new Calendar.Builder(httpTransport, jsonFactory, credential)
		        .setApplicationName("Find The Time").build();
       */
     //   resp.sendRedirect("/FindTheTime.jsp");	
		   
			// TODO Auto-generated catch block
			
		}
		

	  protected void doGet(HttpServletRequest request, HttpServletResponse response)
		      throws IOException {
		  PrintWriter writer = response.getWriter();
		  BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		   System.out.println("What is the authorization code?");
		    
		    String code = in.readLine();
		    // End of Step 1
		    writer.println("code = " + code);
		      response.setContentType("text/html");
		      response.setCharacterEncoding("UTF-8");
		   
		    writer.println("<!doctype html><html><head>");
		    writer.println("<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">");
		    writer.println("<title>" + APP_NAME + "</title>");
		    writer.println(
		        "<link type=\"text/css\" rel=\"stylesheet\" href=\"" + GWT_MODULE_NAME + ".css\">");
		    writer.println("<script type=\"text/javascript\" language=\"javascript\" " + "src=\""
		        + GWT_MODULE_NAME + "/" + GWT_MODULE_NAME + ".nocache.js\"></script>");
		    writer.println("</head><body>");
		    UserService userService = UserServiceFactory.getUserService();
		    writer.println("<div class=\"header\"><b>"  + "</b> | "
		        + "<a href=\"" + userService.createLogoutURL(request.getRequestURL().toString())
		        + "\">Log out</a> | "
		        + "<a href=\"http://code.google.com/p/google-api-java-client/source/browse"
		        + "/calendar-appengine-sample?repo=samples\">See source code for "
		        + "this sample</a></div>");
		    writer.println("<div id=\"main\"/>");
		    writer.println("</body></html>");
}
}