<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="3;url=viewComplaint.jsp" />
    <title>Express Complaint</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8");
    String hrSession = (String) session.getAttribute("HR");
    if (hrSession == null || !"logged_in".equals(hrSession)) {
        response.sendRedirect("hrLogin.jsp");
        return;
}
    String response_text = request.getParameter("response");
    String replied = request.getParameter("replied");
    boolean reply = Boolean.parseBoolean(replied);

    if (response_text.trim().isEmpty()) {
        request.setAttribute("null-response", "Your response has no body.Please try to answer again!");
%>      <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px;">
             <p><%=(String)request.getAttribute("null-response") %></p>
        </div>
<%
    }
    String complaint_id = request.getParameter("complaintid");

    try{
        if (!response_text.trim().isEmpty() && reply == false) {
            Answer answer = new Answer(response_text);
            AnswerService as = new AnswerService();
            as.newAnswerComplaint(answer, complaint_id);
            request.setAttribute("success-response", "Replied successfully!");
%>              <div class="success-message">
                    <p><%=(String)request.getAttribute("success-response") %></p>
                </div>
         
<%      } else if (!response_text.trim().isEmpty() && reply == true) {
            Answer answer = new Answer(response_text);
            AnswerService as = new AnswerService();
            as.deleteAnswerComplaint(complaint_id);
            as.newAnswerComplaint(answer, complaint_id);
            request.setAttribute("success-response", "Replied successfully!");
%>              <div class="success-message">
                    <p><%=(String)request.getAttribute("success-response") %></p>
                </div>
         
<%        }
    } catch(Exception e) {
        request.setAttribute("error_complaint", e.getMessage());
%>      <jsp:forward page="viewComplaint.jsp"/>
<%
    }
%>