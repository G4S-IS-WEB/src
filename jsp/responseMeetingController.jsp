<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="3;url=viewMeeting.jsp" />
    <title>Meeting Controller</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8");
    String hrSession = (String) session.getAttribute("HR");
    if (hrSession == null || !"logged_in".equals(hrSession)) {
        response.sendRedirect("hrLogin.jsp");
        return;
}
    String response_button = request.getParameter("response");
    String meeting_id = request.getParameter("meetingid");
    String replied = request.getParameter("replied");
    boolean reply = Boolean.parseBoolean(replied);


    try{
        if (reply == false) {
            Answer answer = new Answer(response_button);
            AnswerService as = new AnswerService();
            as.newAnswerMeeting(answer, meeting_id);
            request.setAttribute("success-response", "Replied successfully!");
%>              <div class="success-message">
                    <p><%=(String)request.getAttribute("success-response") %></p>
                </div>
         
<%     } else {
            Answer answer = new Answer(response_button);
            AnswerService as = new AnswerService();
            as.deleteAnswerMeeting(meeting_id);
            as.newAnswerMeeting(answer, meeting_id);
            request.setAttribute("success-response", "Replied successfully!");
%>              <div class="success-message">
                    <p><%=(String)request.getAttribute("success-response") %></p>
                </div>
<%        }  
    } catch(Exception e) {
        request.setAttribute("error_meeting", e.getMessage());
%>      <jsp:forward page="viewMeeting.jsp"/>
<%
    }
%>