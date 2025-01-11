<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>

<% if (request.getAttribute("error_message") != null) { %>
        <div class="error-message">
          <p><%=(String)request.getAttribute("error_message") %></p>
        </div>
<% } %>
  
<!DOCTYPE html>
<html lang="en">
<head>
  <%@ include file="header.jsp" %>
  <title>Login Employee</title>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/loginStyles.css">
</head>
<body>
  <div class="banner">
    <a href="<%=request.getContextPath() %>/jsp/menu.jsp">
      <img src="<%=request.getContextPath() %>/images/logo.png" alt="Company Logo" class="logo">
    </a>
  </div>
  
  <div class="container">
    <div class="left-side">
      <div class="profile-icon">
        <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="Profile Icon">
      </div>

      <form method="post" action="<%=request.getContextPath()%>/jsp/loginController.jsp" >
      
        <input type="text" name="id" placeholder="Id" required>
        <input type="password" name="password" placeholder="Password" required>
        <div class="button-group">
          <button type="submit" class="login-btn">Log In</button>
          <button type="button" class="hr-login-btn" onclick="location.href='<%=request.getContextPath() %>/jsp/hrLogin.jsp'">Log In as HR</button>
        </div>
      </form>
    </div>

    <div class="right-side"> 
      <h1>Welcome to the platform</h1>
      <p>Use the Id and password provided by IT.</p>
      <table border="1">
        <thead>
          <tr>
            <th>ID</th>
            <th>Password</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>E0000001</td>
            <td>thanos</td>
          </tr>
          <tr>
            <td>E0000002</td>
            <td>spilios</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
