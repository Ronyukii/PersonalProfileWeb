<%-- 
    Document   : editProfile
    Created on : Dec 25, 2025, 8:23:07 PM
    Author     : Ron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.profile.model.ProfileBean"%>
<% 
    // Get the profile data sent by the Servlet
    ProfileBean profile = (ProfileBean) request.getAttribute("profile"); 
    // Safety check in case someone opens this page directly
    if (profile == null) profile = new ProfileBean();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Paste your standard CSS here to make it look consistent */
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #E0C3FC 0%, #8EC5FC 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: white; padding: 40px; border-radius: 24px; width: 100%; max-width: 500px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #666; font-weight: 500; font-size: 0.9em; }
        input, textarea, select { width: 100%; padding: 12px; border: 2px solid #eee; border-radius: 12px; font-family: inherit; font-size: 1em; transition: 0.3s; box-sizing: border-box;}
        input:focus, textarea:focus { border-color: #a18cd1; outline: none; }
        .btn { width: 100%; padding: 14px; background: linear-gradient(to right, #a18cd1, #fbc2eb); color: white; border: none; border-radius: 12px; font-size: 1.1em; font-weight: 600; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn:hover { opacity: 0.9; transform: translateY(-2px); }
        .cancel-link { display: block; text-align: center; margin-top: 15px; color: #888; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Student Profile</h2>
        <form action="ProfileServlet" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= profile.getId() %>">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="<%= profile.getName() %>" required>
            </div>

            <div class="form-group">
                <label>Student ID</label>
                <input type="text" name="studentId" value="<%= profile.getStudentId() %>" required>
            </div>

            <div class="form-group">
                <label>Program</label>
                <input type="text" name="program" value="<%= profile.getProgram() %>" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" value="<%= profile.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label>Hobbies (Previous: <%= profile.getHobbies() %>)</label>
                <input type="text" name="hobbies" placeholder="Re-enter hobbies (separated by commas)" required>
            </div>

            <div class="form-group">
                <label>Brief Introduction</label>
                <textarea name="introduction" rows="4" required><%= profile.getIntroduction() %></textarea>
            </div>

            <button type="submit" class="btn">Update Profile</button>
            <a href="viewProfiles.jsp" class="cancel-link">Cancel</a>
        </form>
    </div>
</body>
</html>