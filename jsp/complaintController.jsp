<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="3;url=expressComplaint.jsp" />
    <title>Express Complaint</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8"); 
    String complaint_text = request.getParameter("complaint");
    if (complaint_text.trim().isEmpty()) {
        request.setAttribute("null-response", "Your complaint has no body.Please try to send your complaint again!");
%>      <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
             <p><%=(String)request.getAttribute("null-response") %></p>
        </div>
<% }
    Employee employee = (Employee)session.getAttribute("Employee_obj") ;  
    try {
        if (!complaint_text.trim().isEmpty()) {
            Request complaint = new Request(complaint_text);
            RequestService rq = new RequestService();
            rq.newComplaint(complaint, employee);
            request.setAttribute("success-complaint", "Submitted successfully!");
%>          <div class="success-message">
                <p><%=(String)request.getAttribute("success-complaint") %></p>
            </div>
<%      } 
    } catch(Exception e) {
        request.setAttribute("error_complaint", e.getMessage());
%>
      <jsp:forward page="expressComplaint.jsp" />
<%
    }
%>