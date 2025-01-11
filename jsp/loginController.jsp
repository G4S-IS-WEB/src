<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%
String id = request.getParameter("id");
String password = request.getParameter("password");

EmployeeService eService = new EmployeeService();

try {

    Employee employee = eService.authenticate(id, password);

    session.setAttribute("Employee_obj", employee);
    response.sendRedirect("menu.jsp");

} catch(Exception e) {

    request.setAttribute("error_message", "Wrong username or password");

%>
    <jsp:forward page="login.jsp" />

<%
}
%>

