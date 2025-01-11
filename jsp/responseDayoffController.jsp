<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="3;url=viewDayOff.jsp" />
    <title>DayOff Controller</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/requestController.css">
</head>

<%  request.setCharacterEncoding("UTF-8");
    String hrSession = (String) session.getAttribute("HR");
    if (hrSession == null || !"logged_in".equals(hrSession)) {
        response.sendRedirect("hrLogin.jsp");
        return;
}
    String response_button = request.getParameter("response");
    String dayoff_id = request.getParameter("dayoffid");
    String replied = request.getParameter("replied");
    boolean reply = Boolean.parseBoolean(replied);

    try{
            if (reply == false) {
                Answer answer = new Answer(response_button);
                AnswerService as = new AnswerService();
                as.newAnswerDayOff(answer, dayoff_id);
                request.setAttribute("success-response", "Replied successfully!");
%>                  <div class="success-message">
                        <p><%=(String)request.getAttribute("success-response") %></p>
                    </div>
         
<%          } else {
                Answer answer = new Answer(response_button);
                AnswerService as = new AnswerService();
                as.deleteAnswerDayOff(dayoff_id);
                as.newAnswerDayOff(answer, dayoff_id);
                request.setAttribute("success-response", "Replied successfully!");
%>                  <div class="success-message">
                        <p><%=(String)request.getAttribute("success-response") %></p>
                    </div>

<%            }
    } catch(Exception e) {
        request.setAttribute("error_dayoff", e.getMessage());
%>      <jsp:forward page="viewDayOff.jsp"/>
<%
    }
%>