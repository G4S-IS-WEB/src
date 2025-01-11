<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Footer</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/footer.css">
</head>

	<footer class="footer">
            <div class="footer-container">
                <div class="footer-section about">
                    <h2>About Us</h2>
                    <p>
 			Our information system streamlines communication between employees and HR. 
			It efficiently manages meeting requests with designated participants and promptly 
			processes day-off requests, enhancing workplace productivity and connectivity. 
                    </p>
                </div>
                
                <div class="footer-section links">
                    <h2>Quick Links</h2>
                    <ul>
                        <li><a href="<%=request.getContextPath() %>/jsp/menu.jsp">Menu</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/answers.jsp">Inbox</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/schedule.jsp">Schedule</a></li>
			<li><a href="<%=request.getContextPath() %>/jsp/logout.jsp">Logout</a></li>
                    </ul>
                </div>
    
                <div class="footer-section contact">
                    <h2>Contact Us</h2>
                    <p><i class="fas fa-envelope"></i> <a href="https://www.linkedin.com/in/pavlos-stamatis-177143316/">t8220141@aueb.gr</a> </p>
                    <p><i class="fas fa-envelope"></i> <a href="https://www.linkedin.com/in/thanos-sakkatos-35b5642ba/">t8220132@aueb.gr</a> </p>
                    <p><i class="fas fa-envelope"></i> <a href="https://www.linkedin.com/in/spilios-dimakopoulos-a1595a261/">t8220035@aueb.gr</a> </p>
                    <p><i class="fas fa-envelope"></i> <a href="https://www.linkedin.com/in/stavros-vlachos-608712303/">t8220019@aueb.gr</a> </p>
                </div>    
            </div>
            <div class="footer-bottom">
                &copy; 2024 Ismgroup19 | All rights reserved
            </div>
	</footer>
 </html>