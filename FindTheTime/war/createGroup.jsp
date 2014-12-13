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
      <li class="active"><a href="/createGroup.jsp">Create a Group</a></li>
      <li><a href="/joinGroup.jsp">Join a Group</a></li>
      <li><a href="/faq.jsp">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/myGroups.jsp">My Groups</a></li>
      <li><a href="/myCalendar.jsp">My Calendar</a></li>
      <li class="active"><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign Out</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<h2>Create a group below!</h2>
		


<form action="/createGroup" method="post" class="form-horizontal">
  <fieldset>
    <legend></legend>
    <div class="form-group">
      <label for="inputTeam" class="col-lg-2 control-label">Team Name:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="teamName" required>
      </div>
    </div>
    
    <legend>Meeting Duration</legend>
    <div class="form-group">
      <label for="inputTeam" class="col-lg-2 control-label"></label>
      <div class="col-lg-10">
        <select class="form-control" name="meetingLength" required>
        	<option value="15">15 minutes</option>
        	<option value="30">30 minutes</option>
        	<option value="45">45 minutes</option>
        	<option value="60">1 hour</option>
        	<option value="75">1 hour, 15 minutes</option>
        	<option value="90">1 hour, 30 minutes</option>
        	<option value="105">1 hour, 45 minutes</option>
        	<option value="120">2 hours</option>
        </select>
      </div>
    </div>
    
     <legend>Earliest & Latest Meeting Start Time</legend>
    <div class="form-group">
      <label for="inputTeam" class="col-lg-2 control-label">Earliest Meeting Start Time: </label>
      <div class="col-lg-10">
    <select name="startTimeHours">
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
					</select> : <select name="startTimeMinutes">
								<option value="00">00</option>
								<option value="15">15</option>
								<option value="30">30</option>
								<option value="45">45</option>
					</select>
		      </div>
	    </div>
	     <div class="form-group">
      <label for="inputTeam" class="col-lg-2 control-label">Latest Meeting Start Time: </label>
      <div class="col-lg-10">
    <select name="endTimeHours">
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
					</select> : <select name="endTimeMinutes">
								<option value="00">00</option>
								<option value="15">15</option>
								<option value="30">30</option>
								<option value="45">45</option>
					</select>
		      </div>
	    </div>
    
    <legend>Team Members' Email Addresses</legend>
    
    <div class="form-group">
      <label for="emailAddresses" class="col-lg-2 control-label">Member 1:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="user1">
      </div>
    </div>
    
    <div class="form-group">
      <label for="emailAddresses" class="col-lg-2 control-label">Member 2:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="user2">
      </div>
    </div>
    
    <div class="form-group">
      <label for="emailAddresses" class="col-lg-2 control-label">Member 3:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="user3">
      </div>
    </div>
    
    <div class="form-group">
      <label for="emailAddresses" class="col-lg-2 control-label">Member 4:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="user4">
      </div>
    </div>
   
    <div class="form-group">
      <label for="emailAddresses" class="col-lg-2 control-label">Member 5:</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" name="user5">
      </div>
    </div>
    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
    <input type="submit" value="Submit" class="btn btn-success">
	<input type="reset" value="Clear All" class="btn btn-danger">
	</div></div>
  </fieldset>
</form>

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
    <a class="navbar-brand" href="#">Find The Time</a>
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
		<p>You cannot create a group unless you sign in. <a href="/FindTheTime.jsp">Home</a></p>
	</div>
	<%
		}
	%>
</body>   
</html>