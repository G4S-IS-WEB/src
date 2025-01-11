<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="6;url=arrangeDayOff.jsp" />
    <title>Arrange Day Off</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8"); 
    String start_date = request.getParameter("start-date");
    String end_date = request.getParameter("end-date");
    String reason = request.getParameter("reason");
    
    if (reason.trim().isEmpty()) {
        request.setAttribute("null-response", "Your reason subject has no body. Please try to send your request again!");
%>      <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
             <p><%=(String)request.getAttribute("null-response") %></p>
        </div>
<% }
    Employee employee = (Employee)session.getAttribute("Employee_obj") ;  
    try {  
        if (!reason.trim().isEmpty()) {
            String dayOffDate = start_date + " " + end_date;
            Request dayOff = new Request(dayOffDate, reason);
            if (!dayOff.checkdates(start_date, end_date)) {
                request.setAttribute("wrong-dates", "The start date cannot be later than the end date. Please select a valid date range.");
%>              <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
                    <p><%=(String)request.getAttribute("wrong-dates") %></p>
                </div>
<%
            }
            if (!(dayOff.isDateAfterToday(start_date) || dayOff.isDateToday(start_date))) {
                request.setAttribute("wrong-dates", "The start date cannot be before the today's date. Please select a valid date range.");
%>              <div class="null-message" style="color:rgb(19, 19, 19); text-align: center; background-color:rgba(228, 220, 220, 0.88); padding: 15px; font-family: 'Arial', sans-serif;">
                    <p><%=(String)request.getAttribute("wrong-dates") %></p>
                </div>
<%
            }
            if (dayOff.checkdates(start_date, end_date) && (dayOff.isDateAfterToday(start_date) || dayOff.isDateToday(start_date)) && (dayOff.isDateAfterToday(end_date) || dayOff.isDateToday(end_date))) {
                RequestService rq = new RequestService();
                rq.newDayOff(dayOff, employee);
                request.setAttribute("success-dayoff", "Submitted successfully!");
%>                  <div class="success-message">
                        <p><%=(String)request.getAttribute("success-dayoff")%></p>
                    </div>
<%             }
     }
    } catch(Exception e) {
        request.setAttribute("error_message", e.getMessage());
%>
      <jsp:forward page="arrangeDayOff.jsp" />
<%
    }
%>