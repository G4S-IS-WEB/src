<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Banner</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/banner.css">
</head>

    <div class="banner">
        <a href="<%=request.getContextPath() %>/jsp/menu.jsp">
            <img src="<%=request.getContextPath() %>/images/logo.png" alt="Company Logo" class="logo">
        </a>

        <a href="<%=request.getContextPath() %>/jsp/userAccount.jsp" class="profile-link">
            <img src="<%=request.getContextPath() %>/images/user_photo.jpg" alt="User Profile" class="profile-image">
        </a>

        <div class="buttons">
            <a href="<%=request.getContextPath() %>/jsp/menu.jsp">
                <button>Menu</button>
            </a>
            <a href="<%=request.getContextPath() %>/jsp/answers.jsp">
                <button>Inbox</button>
            </a>
            <a href="<%=request.getContextPath() %>/jsp/schedule.jsp">
                <button>Schedule</button>
            </a>
            <div class="dropdown">
                <button>Make a Request</button>
                <div class="dropdown-content">
                    <a href="<%=request.getContextPath() %>/jsp/scheduleMeeting.jsp">Arrange Meeting</a>
                    <a href="<%=request.getContextPath() %>/jsp/arrangeDayOff.jsp">Arrange Day Off</a>
                    <a href="<%=request.getContextPath() %>/jsp/expressComplaint.jsp">Express Complaint</a>
                </div>
            </div>
            <a href="<%=request.getContextPath() %>/jsp/logout.jsp">
                <button>Logout</button>
            </a>
        </div>
    </div>
</html>