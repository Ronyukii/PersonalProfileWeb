<%-- 
    Document   : viewProfiles
    Created on : Dec 25, 2025, 6:42:19 PM
    Author     : Ron
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>All Registered Students</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f7f6; padding: 40px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: linear-gradient(to right, #a18cd1, #fbc2eb); color: white; }
        .delete-btn { color: #ff4d4d; font-weight: bold; text-decoration: none; }
        .navbar {
        background: rgba(255, 255, 255, 0.95);
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        margin-bottom: 30px;
        border-radius: 12px;
        width: 100%;
        max-width: 600px; /* Matches your container width */
    }
    .nav-brand { font-weight: 700; font-size: 1.2em; color: #a18cd1; text-decoration: none; }
    .nav-links a { text-decoration: none; color: #555; margin-left: 20px; font-weight: 500; transition: color 0.3s; }
    .nav-links a:hover { color: #a18cd1; }
    </style>
</head>
<body>
    <h2>Student Directory</h2>
    <nav class="navbar">
        <div class="nav-links">
            <a href="index.html">➕ Register New</a>
        </div>
    </nav>
    <table>
        <tr><th>Name</th><th>ID</th><th>Program</th><th>Hobbies</th><th>Action</th></tr>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/PersonalDB", "app", "app");
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM APP.PROFILE");
                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("studentId") %></td>
            <td><%= rs.getString("program") %></td>
            <td><%= rs.getString("hobbies") %></td>
            <td>
                <a href="ProfileServlet?action=edit&id=<%= rs.getInt("id") %>" 
                    style="color: #4CAF50; font-weight: bold; text-decoration: none; margin-right: 15px;">
                    Edit</a>
                <a href="ProfileServlet?action=delete&id=<%= rs.getInt("id") %>" 
                   class="delete-btn" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
        <% 
                }
                conn.close();
            } catch (Exception e) { out.println(e); }
        %>
    </table>
</body>
</html>