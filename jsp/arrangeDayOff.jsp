<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Arrange Day Off</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/arrangeDayOff.css">
</head>
<body>

<%  request.setCharacterEncoding("UTF-8");
    Employee employee = (Employee)session.getAttribute("Employee_obj") ;
%>
    <%@ include file="banner.jsp" %>
    <div class="wrapper">
        <div class="container">
            <h2>Arrange Day Off</h2>
            <form method="post" action="dayoffController.jsp">
                <div class="form-group date-group">
                    <input type="date" id="start-date" name="start-date" placeholder="Start Date" required>
                    <input type="date" id="end-date" name="end-date" placeholder="End Date" required>
                </div>
                
                <div class="form-group reason-group">
                    <textarea id="reason" name="reason" rows="4" placeholder="Reason for Day Off" required></textarea>
                </div>
        
                <div class="form-group button-center">
                    <button type="submit">Submit Request</button>
                </div>
            </form>
        </div>
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>