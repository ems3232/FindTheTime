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
			System.out.println("Begin myGroups Embedded Java");
		String guestbookName = request.getParameter("guestbookName");
		if (guestbookName == null) {
			guestbookName = "default";
		}
		pageContext.setAttribute("guestbookName", guestbookName);
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user != null) {
			System.out.println("User isn't null");
			pageContext.setAttribute("user", user);
			
			Key appKey = KeyFactory.createKey("Time", "default");
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("users", appKey);
	        List<Entity> usersList = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
	        
	        boolean found = false;
	        Entity userEntity = null;
			for(Entity e : usersList) {
	        	if (e.getProperty("userEmail").toString().equalsIgnoreCase(user.getEmail())) {
	        		found = true;
	        		userEntity = e;
	        		break;
	        	}
	        }
			if (found) {
			System.out.println("User found");
				query = new Query("group", appKey);
				List<Entity> groupList = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5000));
				String userGroup1 = null;
				String userGroup2 = null;
				String userGroup3 = null;
				String userGroup4 = null;
				if (userEntity.getProperty("group1") != null) {
					userGroup1 = userEntity.getProperty("group1").toString();
				}
				if (userEntity.getProperty("group2") != null) {
					userGroup2 = userEntity.getProperty("group2").toString();
				}
				if (userEntity.getProperty("group3") != null) {
					userGroup3 = userEntity.getProperty("group3").toString();
				}
				if (userEntity.getProperty("group4") != null) {
					userGroup4 = userEntity.getProperty("group4").toString();
				}
				if ((userGroup1 == null) && (userGroup2 == null) && (userGroup3 == null) && (userGroup4 == null)) {
				System.out.println("user isn't in any groups");
			%>
					<!-- HTML for logged-in user that has an account, but is not apart of a group.  Something along the lines of "You are not in any groups. go join one!" -->
					
					
			<%
				} 
				else {
					System.out.println("User is in at least one group");	
					Entity userGroupEntity1 = null;
					Entity userGroupEntity2 = null;
					Entity userGroupEntity3 = null;
					Entity userGroupEntity4 = null;
					boolean isGroup1Leader = false;
					boolean isGroup2Leader = false;
					boolean isGroup3Leader = false;
					boolean isGroup4Leader = false;
					for (Entity e : groupList) {
						if (userGroup1 != null && e.getProperty("teamName").toString().equals(userGroup1)) {
							userGroupEntity1 = e;
							if (e.getProperty("user0").toString().equalsIgnoreCase(userEntity.getProperty("userEmail").toString())) {
							isGroup1Leader = true;
							}
						}
						else if (userGroup2 != null && e.getProperty("teamName").toString().equals(userGroup2)) {
							userGroupEntity2 = e;
							if (e.getProperty("user0").toString().equalsIgnoreCase(userEntity.getProperty("userEmail").toString())) {
							isGroup2Leader = true;
							}
						}
						else if (userGroup3 != null && e.getProperty("teamName").toString().equals(userGroup3)) {
							userGroupEntity3 = e;
							if (e.getProperty("user0").toString().equalsIgnoreCase(userEntity.getProperty("userEmail").toString())) {
							isGroup3Leader = true;
							}
						}
						else if (userGroup4 != null && e.getProperty("teamName").toString().equals(userGroup4)) {
							userGroupEntity4 = e;
							if (e.getProperty("user0").toString().equalsIgnoreCase(userEntity.getProperty("userEmail").toString())) {
							isGroup4Leader = true;
							}
						}
					}
					System.out.println("Begin displaying table");
			%>
		<!-- HTML for logged-in user who is in at least 1 group.  Displays group table -->
		
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
      <li class="active"><a href="/myGroups.jsp">My Groups</a></li>
      <li><a href="/myCalendar.jsp">My Calendar</a></li>
      <li class="active"><a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign Out</a></li>
    </ul>
  </div>
</div>
	<div id="content">
		<h2>This is the My Groups Page.</h2>
		
		<table >
			<tr>
				<th>Group Name</th>
				<th>Member 1</th>
				<th>Member 2</th>
				<th>Member 3</th>
				<th>Member 4</th>
				<th>Member 5</th>
				<th>Member 6</th>
				<th>Function</th>
			</tr>
			<%
				if (userGroup1 != null && userGroupEntity1 != null) {
				System.out.println("Begin Displaying Group1's row");
					if (isGroup1Leader) {
			%>
			<!-- Row for group 1 if not null and is leader -->
			<tr>
				<td><p><%= userGroupEntity1.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user1") %></p> 
				<% if(!userGroupEntity1.getProperty("user1").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity1.getProperty("user1") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity1.getProperty("user1") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity1.getProperty("user2") %></p> 
				<% if(!userGroupEntity1.getProperty("user2").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity1.getProperty("user2") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity1.getProperty("user2") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity1.getProperty("user3") %></p> 
				<% if(!userGroupEntity1.getProperty("user3").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity1.getProperty("user3") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity1.getProperty("user3") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity1.getProperty("user4") %></p> 
				<% if(!userGroupEntity1.getProperty("user4").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity1.getProperty("user4") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity1.getProperty("user4") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity1.getProperty("user5") %></p>
				<% if(!userGroupEntity1.getProperty("user5").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity1.getProperty("user5") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity1.getProperty("user5") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td>
					<form action="disbandGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="submit" value="Disband Group"/>
					</form>
					<form action="runAlgorithm" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="submit" value="Run Algorithm"/>
					</form> 
				</td>
			</tr>
			<%
				} else {
			%>
			<!-- Row for group 1 if not null and is not leader -->
			<tr>
				<td><p><%= userGroupEntity1.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user1") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user2") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user3") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user4") %></p></td>
				<td><p><%= userGroupEntity1.getProperty("user5") %></p></td>
				<td>
					<form action="leaveGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity1.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= user.getEmail() %>"/>
						<input type="submit" value="Leave Group"/>
					</form> 
				</td>
			</tr>
			<%
				}}
				if (userGroup2 != null && userGroupEntity2 != null) {
				System.out.println("Begin Displaying Group2's row");
					if (isGroup2Leader) {
			%>
			<!-- Row for group 2 if not null and is leader -->
			<tr>
				<td><p><%= userGroupEntity2.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user1") %></p>
				<% if(!userGroupEntity2.getProperty("user1").toString().equals("N/A")){ %>  
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity2.getProperty("user1") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity2.getProperty("user1") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity2.getProperty("user2") %></p>
				<% if(!userGroupEntity2.getProperty("user2").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity2.getProperty("user2") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity2.getProperty("user2") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity2.getProperty("user3") %></p> 
				<% if(!userGroupEntity2.getProperty("user3").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity2.getProperty("user3") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity2.getProperty("user3") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity2.getProperty("user4") %></p> 
				<% if(!userGroupEntity2.getProperty("user4").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity2.getProperty("user4") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity2.getProperty("user4") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity2.getProperty("user5") %></p>
				<% if(!userGroupEntity2.getProperty("user5").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity2.getProperty("user5") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity2.getProperty("user5") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td>
					<form action="disbandGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="submit" value="Disband Group"/>
					</form>
					<form action="runAlgorithm" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="submit" value="Run Algorithm"/>
					</form> 
				</td>
			</tr>
			<%
				} else {
			%>
			<!-- Row for group 2 if not null and is not leader -->
			<tr>
				<td><p><%= userGroupEntity2.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user1") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user2") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user3") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user4") %></p></td>
				<td><p><%= userGroupEntity2.getProperty("user5") %></p></td>
				<td>
					<form action="leaveGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity2.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= user.getEmail() %>"/>
						<input type="submit" value="Leave Group"/>
					</form> 
				</td>
			</tr>
			<%
				}}
				if (userGroup3 != null && userGroupEntity3 != null) {
				System.out.println("Begin Displaying Group3's row");
					if (isGroup3Leader) {
			%>
			<!-- Row for group 3 if not null and is leader -->
			<tr>
				<td><p><%= userGroupEntity3.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user1") %></p> 
				<% if(!userGroupEntity3.getProperty("user1").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity3.getProperty("user1") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity3.getProperty("user1") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity3.getProperty("user2") %></p> 
				<% if(!userGroupEntity3.getProperty("user2").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity3.getProperty("user2") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity3.getProperty("user2") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity3.getProperty("user3") %></p>
				<% if(!userGroupEntity3.getProperty("user3").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity3.getProperty("user3") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity3.getProperty("user3") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity3.getProperty("user4") %></p> 
				<% if(!userGroupEntity3.getProperty("user4").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity3.getProperty("user4") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity3.getProperty("user4") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form>
					<% } %> 
				</td>
				<td><p><%= userGroupEntity3.getProperty("user5") %></p> 
				<% if(!userGroupEntity3.getProperty("user5").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity3.getProperty("user5") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity3.getProperty("user5") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td>
					<form action="disbandGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="submit" value="Disband Group"/>
					</form>
					<form action="runAlgorithm" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="submit" value="Run Algorithm"/>
					</form> 
					
				</td>
			</tr>
			<%
				} else {
			%>
			<!-- Row for group 3 if not null and is not leader -->
			<tr>
				<td><p><%= userGroupEntity3.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user1") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user2") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user3") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user4") %></p></td>
				<td><p><%= userGroupEntity3.getProperty("user5") %></p></td>
				<td>
					<form action="leaveGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity3.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= user.getEmail() %>"/>
						<input type="submit" value="Leave Group"/>
					</form> 
				</td>
			</tr>
			<%
				}}
				if (userGroup4 != null && userGroupEntity4 != null) {
				System.out.println("Begin Displaying Group4's row");
					if (isGroup4Leader) {
			%>
			<!-- Row for group 4 if not null and is leader -->
			<tr>
				<td><p><%= userGroupEntity4.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user1") %></p> 
				<% if(!userGroupEntity4.getProperty("user1").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity4.getProperty("user1") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity4.getProperty("user1") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity4.getProperty("user2") %></p> 
				<% if(!userGroupEntity4.getProperty("user2").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity4.getProperty("user2") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity4.getProperty("user2") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity4.getProperty("user3") %></p> 
				<% if(!userGroupEntity4.getProperty("user3").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity4.getProperty("user3") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity4.getProperty("user3") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form>
					<% } %> 
				</td>
				<td><p><%= userGroupEntity4.getProperty("user4") %></p>
				<% if(!userGroupEntity4.getProperty("user4").toString().equals("N/A")){ %> 
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity4.getProperty("user4") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity4.getProperty("user4") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td><p><%= userGroupEntity4.getProperty("user5") %></p>
				<% if(!userGroupEntity4.getProperty("user5").toString().equals("N/A")){ %>
					<form action="kickMember" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= userGroupEntity4.getProperty("user5") %>"/>
						<input type="submit" value="Kick"/>
					</form>
					<form action="delegateLeader" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="newLeader" value="<%= userGroupEntity4.getProperty("user5") %>"/>
						<input type="submit" value="Delegate Leader"/>
					</form> 
					<% } %>
				</td>
				<td>
					<form action="disbandGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="submit" value="Disband Group"/>
					</form>
					<form action="runAlgorithm" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="submit" value="Run Algorithm"/>
					</form> 
				</td>
			</tr>
			<%
				} else {
			%>
			<!-- Row for group 4 if not null and is not leader -->
			<tr>
				<td><p><%= userGroupEntity4.getProperty("teamName") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user0") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user1") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user2") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user3") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user4") %></p></td>
				<td><p><%= userGroupEntity4.getProperty("user5") %></p></td>
				<td>
					<form action="leaveGroup" method="post">
						<input type="hidden" name="teamName" value="<%= userGroupEntity4.getProperty("teamName") %>"/>
						<input type="hidden" name="kickMember" value="<%= user.getEmail() %>"/>
						<input type="submit" value="Leave Group"/>
					</form> 
				</td>
			</tr>
			<%
				}
			}
			%>
		</table>
		
		</div>
			<%	
				}
				}
				}	
				else {	
				System.out.println("User isn't signed in. Displaying not-signed-in page");
			%>
			<!-- User isn't signed in -->
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