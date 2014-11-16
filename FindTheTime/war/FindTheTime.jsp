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
    <a class="navbar-brand" href="#">Find The Time</a>
  </div>
  <div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav">
<<<<<<< HEAD
      <li class="active"><a href="/FindTheTime.jsp">Home</a></li>
      <li><a href="/about.jsp">About</a></li>
      <li><a href="/createGroup.jsp">Create a Group</a></li>
      <li><a href="/joinGroup.jsp">Join a Group</a></li>
=======
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">About</a></li>
      <li><a href="#">Create a Group</a></li>
>>>>>>> parent of d721851... Create a group form
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/myAccount.jsp">My Account Settings</a></li>
      <li><a href="#">My Groups</a></li>
      <li><a href="#">My Calendar</a></li>
      <li><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign
			Out</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<p>Content of the home page. -a signed in user</p>
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
      <li class="active"><a href="#">Home</a></li>
      <li><a href="/about.jsp">About Find The Time</a></li>
      <li><a href="#">FAQs</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign In</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<p>CONTENT FOR NON-SIGNED IN USERS!</a></p>
	</div>
	<%
		}
	%>
</body>   
</html>