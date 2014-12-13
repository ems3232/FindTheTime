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
<script>
function myCreateFunction() {
    var table = document.getElementById("addEventTable");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
	document.getElementById("rowNumber").value = rowCount;
    
    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
    element1.type = "text";
    element1.name = "Event" + rowCount + "Name";
    cell1.appendChild(element1);
    
var option0 = document.createElement("option");
option0.innerHTML = "00";
option0.value = "00";
var option1 = document.createElement("option");
option1.innerHTML = "01";
option1.value = "01";
var option2 = document.createElement("option");
option2.innerHTML = "02";
option2.value = "02";	
var option3 = document.createElement("option");
option3.innerHTML = "03";
option3.value = "03";
var option4 = document.createElement("option");
option4.innerHTML = "04";
option4.value = "04";
var option5 = document.createElement("option");
option5.innerHTML = "05";
option5.value = "05";
var option6 = document.createElement("option");
option6.innerHTML = "06";
option6.value = "06";
var option7 = document.createElement("option");
option7.innerHTML = "07";
option7.value = "07";
var option8 = document.createElement("option");
option8.innerHTML = "08";
option8.value = "08";
var option9 = document.createElement("option");
option9.innerHTML = "09";
option9.value = "09";
var option10 = document.createElement("option");
option10.innerHTML = "10";
option10.value = "10";
var option11 = document.createElement("option");
option11.innerHTML = "11";
option11.value = "11";
var option12 = document.createElement("option");
option12.innerHTML = "12";
option12.value = "12";
var option13 = document.createElement("option");
option13.innerHTML = "13";
option13.value = "13";
var option14 = document.createElement("option");
option14.innerHTML = "14";
option14.value = "14";
var option15 = document.createElement("option");
option15.innerHTML = "15";
option15.value = "15";
var option16 = document.createElement("option");
option16.innerHTML = "16";
option16.value = "16";
var option17 = document.createElement("option");
option17.innerHTML = "17";
option17.value = "17";
var option18 = document.createElement("option");
option18.innerHTML = "18";
option18.value = "18";
var option19 = document.createElement("option");
option19.innerHTML = "19";
option19.value = "19";
var option20 = document.createElement("option");
option20.innerHTML = "20";
option20.value = "20";
var option21 = document.createElement("option");
option21.innerHTML = "21";
option21.value = "21";
var option22 = document.createElement("option");
option22.innerHTML = "22";
option22.value = "22";
var option23 = document.createElement("option");
option23.innerHTML = "23";
option23.value = "23";
var optiona = document.createElement("option");
optiona.innerHTML = "00";
optiona.value = "00";
var optiond = document.createElement("option");
optiond.innerHTML = "15";
optiond.value = "15";
var optiong = document.createElement("option");
optiong.innerHTML = "30";
optiong.value = "30";
var optionj = document.createElement("option");
optionj.innerHTML = "45";
optionj.value = "45";

    var element2 = document.createElement("select");
    element2.name = "Event" + rowCount + "StartHour";
    element2.add(option0, null);
    element2.add(option1, null);
    element2.add(option2, null);
    element2.add(option3, null);
    element2.add(option4, null);
    element2.add(option5, null);
    element2.add(option6, null);
    element2.add(option7, null);
    element2.add(option8, null);
    element2.add(option9, null);
    element2.add(option10, null);
    element2.add(option11, null);
    element2.add(option12, null);
    element2.add(option13, null);
    element2.add(option14, null);
    element2.add(option15, null);
    element2.add(option16, null);
    element2.add(option17, null);
    element2.add(option18, null);
    element2.add(option19, null);
    element2.add(option20, null);
    element2.add(option21, null);
    element2.add(option22, null);
    element2.add(option23, null);
 
    var text = document.createTextNode(' : ');
    var element3 = document.createElement("select");
    element3.name = "Event" + rowCount + "StartMin";
    element3.add(optiona, null);
    element3.add(optiond, null);
    element3.add(optiong, null);
    element3.add(optionj, null);
    
    var cell2 = row.insertCell(1);
    cell2.appendChild(element2);
    cell2.appendChild(text);
    cell2.appendChild(element3);
    
    var cell3 = row.insertCell(2);
	var temp2 = element2.cloneNode(true);
	temp2.name = "Event" + rowCount + "EndHour";
	var temp3 = element3.cloneNode(true);
	temp3.name = "Event" + rowCount + "EndMin";
    cell3.appendChild(temp2);
    cell3.appendChild(text.cloneNode(true));
    cell3.appendChild(temp3);
    
    var cell4 = row.insertCell(3);
    var radioHtml = '<input type="radio" name="Event' + rowCount + 'Reoccur" checked="checked" > Yes <input type="radio" name="Event' + rowCount + 'Reoccur"> No';
    var radioDivHtml = document.createElement("div");
    radioDivHtml.innerHTML = radioHtml;
    cell4.appendChild(radioDivHtml);
    
    var cell5 = row.insertCell(4);
	var chkBoxHtml1 = '<INPUT TYPE="Checkbox" VALUE="sun" NAME="Event' + rowCount + 'Sun" onClick=""> Sun ';
	var chkBoxHtml2 = '<INPUT TYPE="Checkbox" VALUE="mon" NAME="Event' + rowCount + 'Mon" onClick=""> Mon ';
	var chkBoxHtml3 = '<INPUT TYPE="Checkbox" VALUE="tue" NAME="Event' + rowCount + 'Tue" onClick=""> Tue ';
	var chkBoxHtml4 = '<INPUT TYPE="Checkbox" VALUE="wed" NAME="Event' + rowCount + 'Wed" onClick=""> Wed ';
	var chkBoxHtml5 = '<INPUT TYPE="Checkbox" VALUE="thu" NAME="Event' + rowCount + 'Thu" onClick=""> Thu ';
	var chkBoxHtml6 = '<INPUT TYPE="Checkbox" VALUE="fri" NAME="Event' + rowCount + 'Fri" onClick=""> Fri ';
	var chkBoxHtml7 = '<INPUT TYPE="Checkbox" VALUE="sat" NAME="Event' + rowCount + 'Sat" onClick=""> Sat ';
	var chkBoxDivHtml = document.createElement("div");
	chkBoxDivHtml.innerHTML = chkBoxHtml1 + chkBoxHtml2 + chkBoxHtml3 + chkBoxHtml4 + chkBoxHtml5 + chkBoxHtml6 + chkBoxHtml7;
	cell5.appendChild(chkBoxDivHtml);
}
</script>
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
		<h2>This is the Add Events to My Calendar Page.</h2>
		<p>Click <a href="/viewCalendar.jsp">here</a> if you need to view your calendar or remove events.</p>
		<button onClick="myCreateFunction()" class="btn btn-info">Add Another Event</button><p id="testOut"></p>
		<form action="createCal" method="post">
		<input type="hidden" name="rowNumber" id="rowNumber" value="1"></input>
		<table id="addEventTable">
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
		<input type="submit" class="btn btn-success">
		</form>
		</br>
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