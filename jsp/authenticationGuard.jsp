<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>

<%
if (session.getAttribute("Employee_obj") == null) {

    request.setAttribute("error_message", "You are not authorized to view this page!");

%>
    <jsp:forward page="login.jsp" />

<%
    return;
}    
%>