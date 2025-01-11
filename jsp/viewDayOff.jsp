<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*,java.util.List" %>

<%
String hrSession = (String) session.getAttribute("HR");
if (hrSession == null || !"logged_in".equals(hrSession)) {
    request.setAttribute("error_message", "You are not authorized to view this page!");
    %>
    <jsp:forward page="login.jsp" />
    <%
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>HR Requests</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/hrRequest.css">
</head>
<body>
    <div class="sidebar">
            <a href="<%=request.getContextPath() %>/jsp/logout.jsp">
                <button class="logout">Logout</button>
            </a>
            <a href="<%=request.getContextPath() %>/jsp/viewComplaint.jsp">
                <button class="menu">Complaint</button>
            </a>
            <a href="<%=request.getContextPath() %>/jsp/viewDayOff.jsp">
                <button class="menu">Day-Off</button>
            </a>
            <a href="<%=request.getContextPath() %>/jsp/viewMeeting.jsp">
                <button class="menu">Meeting</button>
            </a>
        <div class="HR-text">HR</div>
    </div>    
<%	
    RequestService rq = new RequestService();
	List<Request> daysOff = rq.getDaysOff();
%>
    <div class="request-list">
<%
    int i = 0;
    boolean replied = false;
    for (Request d : daysOff) {
    ++i; 
%>	

        <a href="#request<%=i%>"> 
            <div class="subject">DayOff request by <%=rq.findEmployeeNamebyDayoffId(d)%></div>
            <div class="user-info">
                <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Photo">
                <div class="user-name"><%=rq.findEmployeeIdbyDayoffId(d)%></div>
                <% if (rq.getAnswerDayoffbyDayoffId(d.getRequestId()) != null) { 
                    replied = true; 
%>                	<div style="color: green; font-size: 14px; font-weight: bold; margin-top: 20px; margin-left: 70%;" >Replied</div> 
                <% } %>  
            </div>
<%  } %>
        </a>   
   </div>

    <div class="email-content">

<%	
    int j = 0;
    for (Request de : daysOff) {
    ++j; 
%>

        <div id="request<%=j%>" class="request-body">
            <h2>Dayoff request by <%=rq.findEmployeeNamebyDayoffId(de)%></h2>
            <div class="user-info">
                <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Photo">
                <div class="user-name"><%=rq.findEmployeeIdbyDayoffId(de)%></div>
            </div>
            <br>
            <ul>
            <li>Start Date: <strong> <%=de.getStartDateSql()%></strong></li>
            <br>
            <li>End Date: <strong> <%=de.getEndDateSql()%></strong></li>
            <br>
            <li>Reason: <strong> <%=de.getRequestBody()%></strong></li>
            </br>
            </ul>

            <form method="post" action="responseDayoffController.jsp">
                <input type="hidden" name="dayoffid" value="<%=de.getRequestId()%>" />
                <input type="hidden" name="replied" value="<%=replied %>" />
		        <button type="submit" name="response" class="accept-btn" value="accept">Accept</button>
                <button type="submit" name="response" class="deny-btn" value="deny">Deny</button>
            </form>
        </div>
<% }
%>   
</body>
</html>