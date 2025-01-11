<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*,java.util.List" %>
<%@ include file="authenticationGuard.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Answers</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/answers.css">
</head>
<body>
    <%@ include file="banner.jsp" %>
    <div class="wrapper">
        <div class="container">
            <div class="request-answers">

<%  Employee employee = (Employee)session.getAttribute("Employee_obj") ; 
    AnswerService as = new AnswerService();
    List<Answer> answerscomplaints = as.getAnswerComplaints(employee.getEmployeeId());
    int i=0;
    for (Answer a:answerscomplaints) {

%>
                <details>
                    <summary>
                        <h3>Complaint Response</h3>
                        <p>Complaint Id: <strong><%=a.getRequestId() %></strong></p>
                        <p>From: <strong>HR Department</strong></p>
                    </summary>
                    <div class="answer-info">
                        <p><%=a.getAnswerBody() %> </p>
                    </div>
                </details>
<%  }

    List<Answer> answermeetings = as.getAnswerMeetings(employee.getEmployeeId());
    int j=0;
    for (Answer an:answermeetings) {

%>
                <details>
                    <summary>
                        <h3>Meeting Request Response</h3>
                        <p>Meeting Id: <strong><%=an.getRequestId() %></strong></p>
                        <p>From: <strong>HR Department</strong></p>
                    </summary>
                    <div class="answer-info">
<%                   if (an.getAnswerBody().equals("deny")) {
%>                      <p>Your meeting request was rejected !</p>
<%                   } else {
%>                      <p>Your meeting request was accepted !</p>
<%                   }
%>                   </div>
                </details>
<%  }

    List<Answer> answerdaysoff = as.getAnswerDaysOff(employee.getEmployeeId());
    int k=0;
    for (Answer ans:answerdaysoff) {

%>
                <details>
                    <summary>
                        <h3>Dayoff Request Response</h3>
                        <p>Dayoff Id: <strong><%=ans.getRequestId() %></strong></p>
                        <p>From: <strong>HR Department</strong></p>
                    </summary>
                    <div class="answer-info">
<%                   if (ans.getAnswerBody().equals("deny")) {
%>                      <p>Your day-off request was rejected !</p>
<%                   } else {
%>                      <p>Your day-off request was accepted !</p>
<%                   }
%>                   </div>
                </details>
<%  }
%>
            </div>
        </div>    
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
