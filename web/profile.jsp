<%-- 
    Document   : profile_view
    Created on : Nov 22, 2025, 1:11:55 AM
    Author     : Ron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.profile.model.ProfileBean"%> 
<% ProfileBean profile = (ProfileBean) request.getAttribute("profile"); %>

<!DOCTYPE html>
<html>
<head>
    <title>My Personal Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Copy your original CSS styles from Assignment 1 here */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #E0C3FC 0%, #8EC5FC 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .profile-card { background: white; width: 100%; max-width: 400px; border-radius: 24px; overflow: hidden; box-shadow: 0 20px 50px rgba(0,0,0,0.15); position: relative; }
        .card-header { height: 140px; background: linear-gradient(to right, #a18cd1, #fbc2eb); position: relative; }
        .avatar-container { width: 100px; height: 100px; background: white; border-radius: 50%; position: absolute; bottom: -50px; left: 50%; transform: translateX(-50%); display: flex; justify-content: center; align-items: center; box-shadow: 0 10px 20px rgba(0,0,0,0.1); font-size: 40px; color: #a18cd1; font-weight: 600; border: 4px solid white; }
        .card-body { padding: 60px 30px 30px; text-align: center; }
        .user-name { font-size: 1.5em; font-weight: 600; color: #333; margin-bottom: 5px; }
        .user-program { color: #888; font-size: 0.9em; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 25px; }
        .info-grid { display: grid; grid-template-columns: 1fr; gap: 15px; text-align: left; }
        .info-box { background: #f8f9fa; padding: 15px; border-radius: 12px; border-left: 4px solid #a18cd1; }
        .label { font-size: 0.75em; text-transform: uppercase; color: #999; font-weight: 600; display: block; margin-bottom: 4px; }
        .value { color: #444; font-weight: 500; font-size: 0.95em; }
        .bio-box { background: #fff0f5; border-left-color: #fbc2eb; }
        .btn-back { display: block; margin-top: 15px; padding: 12px; text-decoration: none; color: #a18cd1; font-weight: 600; border: 2px solid #f3eefc; border-radius: 12px; transition: all 0.3s; }
        .btn-back:hover { background: #f3eefc; }
    </style>
</head>
<body>
    <div class="profile-card">
        <div class="card-header">
            <div class="avatar-container">
                <%= (profile != null && profile.getName() != null) ? profile.getName().charAt(0) : "?" %>
            </div>
        </div>
        <div class="card-body">
            <div class="user-name">${profile.name}</div>
            <div class="user-program">${profile.program}</div>

            <div class="info-grid">
                <div class="info-box"><span class="label">Student ID</span><span class="value">${profile.studentId}</span></div>
                <div class="info-box"><span class="label">Email</span><span class="value">${profile.email}</span></div>
                <div class="info-box"><span class="label">Interests</span><span class="value">${profile.hobbies}</span></div>
                <div class="info-box bio-box"><span class="label">About Me</span><span class="value">"${profile.introduction}"</span></div>
            </div>

            <a href="index.html" class="btn-back">Create Another</a>
            <a href="viewProfiles.jsp" class="btn-back" style="color:#666; border-color:#eee;">View All Profiles</a>
        </div>
    </div>
</body>
</html>