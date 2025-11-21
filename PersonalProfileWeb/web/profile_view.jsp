<%-- 
    Document   : profile_view
    Created on : Nov 22, 2025, 1:40:56 AM
    Author     : Ron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Personal Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .profile-card {
            background-color: white;
            width: 350px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            text-align: center;
        }
        .header {
            background-color: #4a4e69;
            color: white;
            padding: 20px;
            position: relative;
        }
        .avatar-circle {
            width: 80px;
            height: 80px;
            background-color: #fff;
            border-radius: 50%;
            margin: 0 auto 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 40px;
            color: #4a4e69;
            border: 4px solid #f2f2f2;
        }
        .body {
            padding: 20px;
            color: #555;
        }
        .info-item {
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .info-label {
            font-weight: bold;
            color: #222;
            display: block;
            font-size: 0.9em;
            text-transform: uppercase;
            margin-bottom: 3px;
        }
        .intro-box {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 5px;
            font-style: italic;
            font-size: 0.9em;
        }
        .btn-back {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #f2f2f2;
            text-decoration: none;
            color: #333;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn-back:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="profile-card">
        <div class="header">
            <div class="avatar-circle">
                <%= request.getAttribute("userName").toString().charAt(0) %>
            </div>
            <h2>${userName}</h2>
            <p>${userProgram}</p>
        </div>
        
        <div class="body">
            <div class="info-item">
                <span class="info-label">Student ID</span>
                ${userId}
            </div>
            
            <div class="info-item">
                <span class="info-label">Email Address</span>
                ${userEmail}
            </div>
            
            <div class="info-item">
                <span class="info-label">Hobbies</span>
                ${userHobbies}
            </div>
            
            <div class="info-item">
                <span class="info-label">About Me</span>
                <div class="intro-box">
                    "${userIntro}"
                </div>
            </div>
        </div>
        
        <a href="index.html" class="btn-back">Edit Profile</a>
    </div>
</body>
</html>