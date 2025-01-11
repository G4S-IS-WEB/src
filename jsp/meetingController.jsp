<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="6;url=scheduleMeeting.jsp" />
    <title>Meeting</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8"); 
    String meeting_date = request.getParameter("meeting-date");
    String meeting_time = request.getParameter("meeting-time");
    String[] participants = request.getParameterValues("participants");
    String meeting_subject = request.getParameter("meeting-subject");
    if (meeting_subject.trim().isEmpty()) {
        request.setAttribute("null-subject", "Your meeting subject has no body. Please try to send your meeting request again!");
%>      <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
             <p><%=(String)request.getAttribute("null-subject") %></p>
        </div>
<% }
    if (participants == null) {
        request.setAttribute("null-participants", "You did not select any meeting participants. Please try to send your meeting request again!");
%>      <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
             <p><%=(String)request.getAttribute("null-participants") %></p>
        </div>
<% }
    Employee employee = (Employee)session.getAttribute("Employee_obj") ;  
    try {
        if (!meeting_subject.trim().isEmpty() && participants != null) {
            Request meeting = new Request(meeting_date, meeting_time, participants, meeting_subject);
            if (!meeting.isTimeAfterOrNow(meeting_time) && meeting.isDateToday(meeting_date)) {
                request.setAttribute("wrong-time", "The meeting time cannot be before the current time. Please select a valid meeting time.");
%>              <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
                    <p><%=(String)request.getAttribute("wrong-time") %></p>
                </div>
<%
            }
            if (!(meeting.isDateAfterToday(meeting_date) || meeting.isDateToday(meeting_date))) {
                request.setAttribute("wrong-date", "The meeting date cannot be before the today's date. Please select a valid meeting date.");
%>              <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
                    <p><%=(String)request.getAttribute("wrong-date") %></p>
                </div>
<%
            }
            if (meeting.isDateAfterToday(meeting_date)) {
                RequestService rq = new RequestService();
                rq.newMeeting(meeting, employee);
                request.setAttribute("success-meeting", "Submitted successfully!");
%>                  <div class="success-message">
                        <p><%=(String)request.getAttribute("success-meeting") %></p>
                    </div>
<%          }else if(meeting.isTimeAfterOrNow(meeting_time) && meeting.isDateToday(meeting_date)) {
                RequestService rq = new RequestService();
                rq.newMeeting(meeting, employee);
                request.setAttribute("success-meeting", "Submitted successfully!");
%>                  <div class="success-message">
                        <p><%=(String)request.getAttribute("success-meeting") %></p>
                    </div>
<%            }
        }
    } catch(Exception e) {
        request.setAttribute("error_message", e.getMessage());
%>      
      <jsp:forward page="scheduleMeeting.jsp" />
<%
    }
%>