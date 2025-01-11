<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*,java.util.List" %>

<%@ include file="authenticationGuard.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Schedule Meeting</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/schedule-meeting.css">
</head>
<body>

<%  request.setCharacterEncoding("UTF-8");
    Employee employee = (Employee)session.getAttribute("Employee_obj") ;
    EmployeeService es = new EmployeeService();
    List<Employee> employees = es.getEmployees();
%>
    <%@ include file="banner.jsp" %>
    <div class="wrapper">
        <div class="container">
            <h2>Schedule a Meeting</h2>
            <form method="post" action="meetingController.jsp">
                <div class="form-group time-group">
                    <input type="date" id="meeting-date" name="meeting-date" placeholder="Meeting Date" required>
                    <input type="time" id="meeting-time" name="meeting-time" placeholder="Meeting Time" required>
                </div>
                <div class="room-participants">
                    <label class="title" style="margin-bottom: 5px; display: inline-block; 
			font-weight: 600; font-size: 1.1em; transition: color 0.3s ease; hover: color #e74c3c;">
			Select Participants:
		    </label>
                    <div class="checkbox-container">
                        
<%  int i=0;
    for (Employee e:employees) {
    i++;

        if (!employee.getEmployeeId().equals(e.getEmployeeId())) {
%>

                        <label>
                            <span class="participant-name"><%=e.getEmployee_fullname()%> , <i><%=e.getEmployee_role()%></i></span>
                            <input type="checkbox" name="participants" value="<%=e.getEmployeeId()%>">
                        </label>
<% 
        }
    }
%>                        
                       
                    </div>
                    <div class="form-group">
                        <label for="meeting-subject" class="title">Meeting Subject:</label>
                        <input type="text" id="meeting-subject" name="meeting-subject" placeholder="Enter meeting subject" required>
                    </div>
                </div>
                <div class="form-group button-center">
                    <button type="submit">Schedule Meeting</button>
                </div>
            </form>
        </div>
        
       <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
