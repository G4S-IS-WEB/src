<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Express Complaint</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/expressComplaint.css">
</head>
<body>
<%    Employee employee = (Employee)session.getAttribute("Employee_obj") ; 
%>

<%@ include file="banner.jsp" %>

    <div class="wrapper">
        <div class="container">
            <h2>Submit a Complaint</h2>
            <form method="post" action="complaintController.jsp">
                <div class="form-group complaint-group">
                    <textarea id="complaint" name="complaint" rows="6" placeholder="Describe your complaint here..." required></textarea>
                </div>

                <div class="form-group button-center">
                    <button type="submit">Submit Complaint</button>
                </div>
            </form>
        </div>
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>