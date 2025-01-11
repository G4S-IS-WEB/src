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
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/viewComplaint.css">
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
	List<Request> complaints = rq.getComplaints();
%>

    <div class="request-list">

    <%
    int i = 0;
    boolean replied = false;
    for (Request c : complaints) {
    ++i; 
%>	
        <a href="#request<%=i%>"> 
            <div class="subject">Complaint by <%=rq.findEmployeeNamebyComplaintId(c)%> </div>
               <div class="user-info">
                <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Photo">
                <div class="user-name"><%=rq.findEmployeeIdbyComplaintId(c)%></div>
                <% if (rq.getAnswerComplaintbyComplaintId(c.getRequestId()) != null) { 
                    replied = true; 
%>
                	<div style="color: green; font-size: 14px; font-weight: bold; margin-top: 20px; margin-left: 70%;" >Replied</div> 
                <% } %>                
            </div> 
<%  }  %>  
        </a> 
   </div>

    <div class="email-content">

<%	
    int j = 0;
    for (Request co : complaints) {
    ++j; 
%>
        <div id="request<%=j%>" class="request-body">
            <h2>Complaint by <%=rq.findEmployeeNamebyComplaintId(co)%></h2>
            <div class="user-info">
                <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Photo">
                <div class="user-name"><%=rq.findEmployeeIdbyComplaintId(co)%></div>
            </div>
            <p><%=co.getRequestBody()%><br><br></p>
            <label for="reply<%=j%>-toggle" class="reply-btn">Reply</label>
            <input type="checkbox" id="reply<%=j%>-toggle">
            <div class="reply-section">
            <form method="post" action="responseComplaintController.jsp">
                <textarea id="response" name="response" placeholder="Write your reply here..." required></textarea>
                <input type="hidden" name="complaintid" value="<%=co.getRequestId()%>" />
                <input type="hidden" name="replied" value="<%=replied %>" />
                <button class="send-btn">Send</button>
            </form>
            </div>
        </div>
<% }
%>  
      
</body>
</html>