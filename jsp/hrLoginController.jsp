
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <meta http-equiv="refresh" content="3;url=hrLogin.jsp" />
    <title>Express Complaint</title>
</head>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");
if (!"HR".equals(username) || !"123".equals(password)) {
request.setAttribute("error_message", "Wrong username or password");
%>
    <jsp:forward page="hrLogin.jsp" />
<% } 
session.setAttribute("HR", "logged_in");
response.sendRedirect("viewComplaint.jsp");%>