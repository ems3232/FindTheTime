<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<link type="text/css" rel="stylesheet" href="/FindTheTime.css" />
<script type="text/javascript" src="Scripts/bootstrap.js" charset="UTF-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js" charset="UTF-8"></script>
<title>Find The Time - A WebApp for Group Projects</title>
</head>

<body>

	<div id="header">
		<h1><a href="/FindTheTime.jsp">Find The Time</a></h1>
	</div>
	
	<div id="menu">
	<%
		String guestbookName = request.getParameter("guestbookName");
		if (guestbookName == null) {
			guestbookName = "default";
		}
		pageContext.setAttribute("guestbookName", guestbookName);
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user != null) {
			pageContext.setAttribute("user", user);
	%>
		<div class="navbar navbar-default">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/FindTheTime.jsp">Find The Time</a>
  </div>
  <div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav">
      <li><a href="/FindTheTime.jsp">Home</a></li>
      <li><a href="/createGroup.jsp">Create a Group</a></li>
      <li><a href="/joinGroup.jsp">Join a Group</a></li>
      <li><a href="/faq.jsp">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/myGroups.jsp">My Groups</a></li>
      <li class="active"><a href="/myCalendar.jsp">My Calendar</a></li>
      <li class="active"><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign Out</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<h2>This is the View Calendar and Remove Events Page.</h2>
		<p>Click <a href="/addEvents.jsp">here</a> if you need to add events to your calendar.</p>
		</br></br>
		
		
		
		
		
		<%
		String appName = "default";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key appKey = KeyFactory.createKey("Time", appName);
		Query queue = new Query("users", appKey);
	        List<Entity> usersList = datastore.prepare(queue).asList(FetchOptions.Builder.withLimit(5000));
	        boolean found = false;
	        Entity users = null;
	       for(Entity e : usersList) {
	        	if (e.getProperty("userEmail").toString().equalsIgnoreCase(user.getEmail())) {
	        		found = true;
	        		users = e;
	        		break;
	        	}
	        }
	   //users is the entity
	   if(found) {
	   	   if(users.getProperty("calendar").equals("false")){
	   	   		%><p>You have no events in your calendar. Please go and <a href="/addEvents.jsp">add events</a>.</p><%
	   	   } else {                                     
		   //events look like: EventName1_Repeating?_00:00(start)_00:00(end)_day1_..._day7&EventName2...
			%>
			<table>
				<tr>
					<th>Event</th>
					<th>Sunday</th>
					<th>Monday</th>
					<th>Tuesday</th>
					<th>Wednesday</th>
					<th>Thursday</th>
					<th>Friday</th>
					<th>Saturday</th>
				</tr>
			<%//create a new row for the first event in the list.
			//Need to know the name, times and which days
			String name;
			String start;
			String end;
			  String calendar=users.getProperty("calendar").toString();
			ArrayList<String> days;
			String[] events = calendar.split("&");
			for(String s : events){ // s should look like: EventName1_Repeating?_00:00(start)_00:00(end)_day1_..._day7
				String[] eventPieces = s.split("_");
				name = eventPieces[0];
				start = eventPieces[2];
				end = eventPieces[3];
				days = new ArrayList<String>();
				for(int i = 4; i < eventPieces.length; i++){
					days.add(eventPieces[i]);
				}
			%>
				<tr>
					<td><%out.print(name);%></td>
					<td><%
						int counter = 0;
						if(counter < days.size()){
							if(days.get(counter).equals("sun")){
								out.print(start+"-"+end);
								counter++;
							}
						}
					%></td>
					<td><%
						if(counter < days.size()){
						if(days.get(counter).equals("mon")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
					<td><%
						if(counter < days.size()){
						if(days.get(counter).equals("tue")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
					<td><%
						if(counter < days.size()){
						if(days.get(counter).equals("wed")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
					<td><%
					  	if(counter < days.size()){
						if(days.get(counter).equals("thu")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
					<td><%
						if(counter < days.size()){
						if(days.get(counter).equals("fri")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
					<td><%
						if(counter < days.size()){
						if(days.get(counter).equals("sat")){
							out.print(start+"-"+end);
							counter++;
							}
						}
					%></td>
				</tr>
				</table>
				</br>
				<div id="content">
				<h3>Delete an Event</h3>
				<p>Be sure to use the <i>exact</i> event name from the time sheet above.</p>				
				
<form action="/deleteEvent" method="post" class="form-horizontal">
  <fieldset>
    <div class="form-group">
      <label for="inputEvent" class="col-lg-2 control-label">Event Name:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="eventName" required>
      </div>
    </div>
    
    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
    <input type="submit" value="Delete Event in My Calendar" class="btn btn-danger">
    </div></div>
  </fieldset>
</form>			
				
				</br>
				<h3>Update Calendar!</h3>
	
		<form action="updateCal" method="post">
		<input type="hidden" name="rowNumber" id="rowNumber" value="1"></input>
		<table id="updateEventTable">
			<tr>
				<td><b>Event Name</b></td>
				<td><b>Start Time</b></td>
				<td><b>End Time</b></td>
				<td><b>Weekly Repeating Event?</b></td> <%//2 radio buttons - 1) One time only 2) Recurring Event%>
				<td><b>Days It Repeats On</b></td> <%//7 checkboxes - Su,M,T,W,Th,F,S%>
			<tr>
					<td><input type="text" name="Event1Name"></td>
					<td><select name="Event1StartHour">
					<option value="00">00</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					</select> : <select name="Event1StartMin">
								<option value="00">00</option>
								<option value="15">15</option>
								<option value="30">30</option>
								<option value="45">45</option>
					</select></td>
					<td><select name="Event1EndHour">
					<option value="00">00</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					</select> : <select name="Event1EndMin">
								<option value="00">00</option>
								<option value="15">15</option>
								<option value="30">30</option>
								<option value="45">45</option>
					</select></td>
							  
					<TD><INPUT TYPE="radio" NAME="Event1Reoccur" VALUE="true" onClick=""  CHECKED> Yes
  					<INPUT TYPE="radio" NAME="Event1Reoccur" VALUE="false" onClick="" > No</TD>
  					
					<TD><INPUT TYPE="Checkbox" VALUE="sun" NAME="Event1Sun" onClick=""> Sun   
					<INPUT TYPE="Checkbox" VALUE="mon" NAME="Event1Mon" onClick=""> Mon   
  					<INPUT TYPE="Checkbox" VALUE="tue" NAME="Event1Tue" onClick=""> Tue   
				  	<INPUT TYPE="Checkbox" VALUE="wed" NAME="Event1Wed" onClick=""> Wed   
				  	<INPUT TYPE="Checkbox" VALUE="thu" NAME="Event1Thu" onClick=""> Thu   
				  	<INPUT TYPE="Checkbox" VALUE="fri" NAME="Event1Fri" onClick=""> Fri   
				  	<INPUT TYPE="Checkbox" VALUE="sat" NAME="Event1Sat" onClick=""> Sat</TD>
					</tr>
					</table>
					</br>
					<input type="submit" value="Update" class="btn btn-success"/>
		
			
			
					</div>
			<%
			}
			%>
					
			
		<%
			}
		}	%>
		
		</br></br>
		<p><a href="/myCalendar.jsp">Go Back</a> to the main My Calendar page.</p>
	</div>
	<%
		} else {
	%>
	<div class="navbar navbar-default">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/FindTheTime.jsp#">Find The Time</a>
  </div>
  <div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav">
      <li><a href="/FindTheTime.jsp">Home</a></li>
      <li><a href="/faq.jsp">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li class="active"><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign In</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<p>You have signed out. Please sign in again to see your account information. <a href="/FindTheTime.jsp">Home</a></p>
	</div>
	<%
		}
	%>
</body>
</html>