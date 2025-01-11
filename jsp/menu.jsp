<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="hr_info_system_java.*" %>

<%@ include file="authenticationGuard.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="header.jsp" %>
    <title>Menu</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/menu.css">
</head>
<body>
    <%@ include file="banner.jsp" %>  
    <div class="wrapper"> 
        <div class="welcome-hub">
            <div class="welcome-text">
                <h1>Welcome to the Company Hub</h1>
                <p>We are thrilled to have you here! As a dedicated member of our team, you have access to all the tools and resources you need to succeed. Whether you are scheduling meetings, sending requests to hr, seeing your work schedule this hub is here to support you every step of the way.</p>
                <p>Explore, engage, and stay connected with everything we have to offer.</p>
            </div>
            <div class="welcome-image">
                <img src="<%=request.getContextPath() %>/images/building.jpg" alt="Welcome Image">
            </div>
        </div>

        <section class="newsletter">
            <h1>Newsletter</h1>
            <div class="newsletter-container">
                <div class="newsletter-item">
                    <img src="<%=request.getContextPath() %>/images/newsletter (8).jpg" alt="Company Achievements">
                    <h2>Company Achievements</h2>
                    <p>This month, we achieved several milestones in innovation and service delivery, reinforcing our commitment to excellence.</p>
                </div>
        
                <div class="newsletter-item">
                    <img src="<%=request.getContextPath() %>/images/newsletter (7).jpg" alt="Community Involvement">
                    <h2>Community Involvement</h2>
                    <p>We are proud to support various community initiatives, fostering positive social change and local engagement.</p>
                </div>
        
                <div class="newsletter-item">
                    <img src="<%=request.getContextPath() %>/images/newsletter (2).jpg" alt="Sustainability Efforts">
                    <h2>Sustainability Efforts</h2>
                    <p>Our ongoing commitment to sustainability includes new eco-friendly policies and practices across all areas of operation.</p>
                </div>
        
                <div class="newsletter-item">
                    <img src="<%=request.getContextPath() %>/images/newsletter (5).jpg" alt="Upcoming Events">
                    <h2>Upcoming Events</h2>
                    <p>Join us at our upcoming webinar series on industry trends and best practices, designed to empower and inform our clients.</p>
                </div>
        
                <!-- Hidden items -->
                <input type="checkbox" id="view-more" style="display: none;">
                <div class="hidden-items">
                    <div class="newsletter-item">
                        <img src="<%=request.getContextPath() %>/images/newsletter (4).jpg" alt="Product Launches">
                        <h2>Product Launches</h2>
                        <p>We are excited to introduce new products that align with our mission to provide innovative solutions for our clients.</p>
                    </div>
        
                    <div class="newsletter-item">
                        <img src="<%=request.getContextPath() %>/images/newsletter (1).jpg" alt="Employee Spotlight">
                        <h2>Employee Spotlight</h2>
                        <p>Meet the team! This month, we highlight an exceptional team member who embodies our core values and dedication.</p>
                    </div>
        
                    <div class="newsletter-item">
                        <img src="<%=request.getContextPath() %>/images/newsletter (6).jpg" alt="Industry Insights">
                        <h2>Industry Insights</h2>
                        <p>Stay informed with insights on recent trends, technologies, and practices shaping the industry.</p>
                    </div>
        
                    <div class="newsletter-item">
                        <img src="<%=request.getContextPath() %>/images/newsletter (3).jpg" alt="Client Success Stories">
                        <h2>Client Success Stories</h2>
                        <p>We take pride in helping our clients achieve success. Here are some recent stories from valued clients.</p>
                    </div>
                </div>
            </div>
        </section>
        
            <label for="view-more" class="view-more-button">View More</label>
        </section>

        <!-- Footer Section -->
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>