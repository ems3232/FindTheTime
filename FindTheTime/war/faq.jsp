<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
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
      <li class="active"><a href="/faq.jsp">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/myGroups.jsp">My Groups</a></li>
      <li><a href="/myCalendar.jsp">My Calendar</a></li>
      <li class="active"><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign Out</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<h2>Frequently Asked Questions</h2>
		</br>
	</div>
		
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">What is Find The Time?</h3>
  </div>
  <div class="panel-body">
    Find The Time is a web application designed for college students involved in semester-long group projects.  The application assists students finding time to meet as a group by analyzing each group member's Google Calendar to find a time slot where everyone is mutually available.  Unlike most scheduling assistance applications online today, Find The Time will perform its analysis of your schedule every week to allow for students' varying and changing schedules.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I make an account?</h3>
  </div>
  <div class="panel-body">
	You don't need to worry about creating an account.  Simply sign in with a gmail account, or a gmail-based account (such as a @utexas.edu address)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I create a group?</h3>
  </div>
  <div class="panel-body">
	Sign in and navigate to the "Create a Group" page.  Enter your chosen team name (which must be unique from every other group using the application) and the email addresses of the rest of your team.  Then hit submit.  Be sure these addresses are gmail or gmail-based, otherwise the application will fail to import their Google Calendar for analysis.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I join a group?</h3>
  </div>
  <div class="panel-body">
	After your team leader has created a group and provided the rest of the team's email addresses, you will receive an email that includes the name of the group and a link to the web application.  Sign in and navigate to the "Join a Group" page and enter the team name you saw in the email. (Make sure that it is exact, it IS case-sensitive.)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I leave a group?</h3>
  </div>
  <div class="panel-body">
	Sign in and navigate to "My Groups" and click the button that says "Leave Group" next to the group you want to leave.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">My team leader is dropping the class/project, how do we make a new team leader?</h3>
  </div>
  <div class="panel-body">
	The original team leader will need to sign in to their account and choose one of the other team members to become the leader.  After this, they can leave the group.  The application will not allow a team leader to leave the group without assigning a replacement first.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">What makes the team leader different than the rest of the team?</h3>
  </div>
  <div class="panel-body">
A team leader has a few extra abilities within the application that normal group members do not have:</br>
- Set the duration of the weekly meeting (e.g. - 1 hour, 30 minutes, etc.)</br>
- Add and remove members from the group (up to 5 other members)</br>
- Choose the team name</br>
- Select earliest and latest meeting times (i.e. - no meetings after 10pm and no meetings earlier than 9am)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Can I sign in using my "@utexas.edu" email address?</h3>
  </div>
  <div class="panel-body">
	Yes.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How does it know when I'm free to work with my group?</h3>
  </div>
  <div class="panel-body">
	The application will request you to input all the times you have a conflict and then search through the schedules of all members and find time slots that all members can meet.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Will I have to put my schedule in every week?</h3>
  </div>
  <div class="panel-body">
	No. You can set an event as a recurring conflict and it will carry over to the next week. However, if you have a one time event, you will have to go back in and update your schedule.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How will we know what our top meeting times are?</h3>
  </div>
  <div class="panel-body">
	We will send an email to the leader of your group with the top three meeting times where they can then decide which time works best for your team.
  </div>
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
    <a class="navbar-brand" href="/FindTheTime.jsp">Find The Time</a>
  </div>
  <div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav">
      <li><a href="/FindTheTime.jsp">Home</a></li>
      <li class="active"><a href="/faq.jsp">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li class="active"><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign In</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<h2>Frequently Asked Questions</h2>
		</br>
	</div>
	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">What is Find The Time?</h3>
  </div>
  <div class="panel-body">
    Find The Time is a web application designed for college students involved in semester-long group projects.  The application assists students finding time to meet as a group by analyzing each group member's Google Calendar to find a time slot where everyone is mutually available.  Unlike most scheduling assistance applications online today, Find The Time will perform its analysis of your schedule every week to allow for students' varying and changing schedules.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I make an account?</h3>
  </div>
  <div class="panel-body">
	You don't need to worry about creating an account.  Simply sign in with a gmail account, or a gmail-based account (such as a @utexas.edu address)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I create a group?</h3>
  </div>
  <div class="panel-body">
	Sign in and navigate to the "Create a Group" page.  Enter your chosen team name (which must be unique from every other group using the application) and the email addresses of the rest of your team.  Then hit submit.  Be sure these addresses are gmail or gmail-based, otherwise the application will fail to import their Google Calendar for analysis.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I join a group?</h3>
  </div>
  <div class="panel-body">
	After your team leader has created a group and provided the rest of the team's email addresses, you will receive an email that includes the name of the group and a link to the web application.  Sign in and navigate to the "Join a Group" page and enter the team name you saw in the email. (Make sure that it is exact, it IS case-sensitive.)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How do I leave a group?</h3>
  </div>
  <div class="panel-body">
	Sign in and navigate to "My Groups" and click the button that says "Leave Group" next to the group you want to leave.
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">My team leader is dropping the class/project, how do we make a new team leader?</h3>
  </div>
  <div class="panel-body">
	The original team leader will need to sign in to their account and choose one of the other team members to become the leader.  After this, they can leave the group.  The application will not allow a team leader to leave the group without assigning a replacement first.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">What makes the team leader different than the rest of the team?</h3>
  </div>
  <div class="panel-body">
A team leader has a few extra abilities within the application that normal group members do not have:</br>
- Set the duration of the weekly meeting (e.g. - 1 hour, 30 minutes, etc.)</br>
- Add and remove members from the group (up to 5 other members)</br>
- Choose the team name</br>
- Select earliest and latest meeting times (i.e. - no meetings after 10pm and no meetings earlier than 9am)
  </div>
</div>
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Can I sign in using my "@utexas.edu" email address?</h3>
  </div>
  <div class="panel-body">
	Yes.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How does it know when I'm free to work with my group?</h3>
  </div>
  <div class="panel-body">
	The application will request you to input all the times you have a conflict and then search through the schedules of all members and find time slots that all members can meet.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Will I have to put my schedule in every week?</h3>
  </div>
  <div class="panel-body">
	No. You can set an event as a recurring conflict and it will carry over to the next week. However, if you have a one time event, you will have to go back in and update your schedule.
  </div>
</div>	
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">How will we know what our top meeting times are?</h3>
  </div>
  <div class="panel-body">
	We will send an email to the leader of your group with the top three meeting times where they can then decide which time works best for your team.
  </div>
</div>

	<%
		}
	%>
</body>   
</html>