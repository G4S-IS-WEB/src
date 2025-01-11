<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>
<% Employee e = (Employee)session.getAttribute("Employee_obj") ; %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>User Account</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/userAccount.css">
</head>
<body>
    <%@ include file="banner.jsp" %>
    <div class="wrapper"> 
        <div class="user-cards-container">
            <div class="first-user-card">
                <div class="User-photo">
                    <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Photo">
                </div>
                <hr>
                <div class="User-name">
                    <p>ID: <%=e.getEmployeeId() %></p>
                </div>
                <hr>
                <div class="general-info">
                    <p><span class="info-thing">FullName: </span> <span class="info-input"><%=e.getEmployee_fullname() %></span></p>
                    <p><span class="info-thing">Date of Birth: </span> <span class="info-input"><%=e.getEmployee_dateofbirth() %></span></p>
                    <p><span class="info-thing">Gender: </span> <span class="info-input"><%=e.getEmployee_gender() %></span></p>
                    <p><span class="info-thing">Role: </span> <span class="info-input"><%=e.getEmployee_role() %></span></p>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html> 
