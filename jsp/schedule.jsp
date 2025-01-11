<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*,java.util.List,java.util.ArrayList" %>
<%@ include file="authenticationGuard.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Schedule</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/schedule.css">
</head>
<body>
    <div class="content-wrapper">
        <%@ include file="banner.jsp" %>

        <main class="content-main">
            <table class="schedule">
                <caption><span style="color: red;">Schedule Overview</span></caption>
                <thead>
                    <tr>
                        <th>Request Id</th>
                        <th>Accepted Requests</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>

<%  Employee employee = (Employee)session.getAttribute("Employee_obj") ;
    EmployeeService es = new EmployeeService();
    List<Request> acceptedrequests = es.getAcceptedRequestsbyEmployeeId(employee.getEmployeeId());
    List<String> request_ids = new ArrayList<String>();
    for (Request r:acceptedrequests) {
%>                  <tr>
                        <td><%=r.getRequestId()%></td>
                        <td>
                        <%=r.getRequestBody()%>
<%                      if (!request_ids.contains(r.getRequestId())) {
                            request_ids.add(r.getRequestId());
                        }else {
%>                            <p style="color:blue">{End}</p>
<%                        }  
%>                        </td>
                        <td>
                        <%=r.getDateSQL()%>
<%                        if(r.getTimeSQL() != null) {   
%>                          <%=r.getTimeSQL()%>
<%                          }  
%>                        </td>
                    </tr>
<%  }
%>
                </tbody>
            </table>
        </main>

        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
