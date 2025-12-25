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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f7f6; padding: 40px; }
        h2 { color: #333; margin-bottom: 20px; }
        
        /* Search Bar Styles */
        .search-container { margin-bottom: 20px; display: flex; gap: 10px; max-width: 600px; }
        .search-input { flex: 1; padding: 10px; border: 2px solid #ddd; border-radius: 8px; font-family: inherit; }
        .search-btn { background: #a18cd1; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; }
        .reset-btn { background: #eee; color: #555; text-decoration: none; padding: 10px 15px; border-radius: 8px; display: inline-block; line-height: 1.2; }
        
        /* Table Styles */
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: linear-gradient(to right, #a18cd1, #fbc2eb); color: white; font-weight: 600; }
        tr:hover { background-color: #f9f9f9; }
        
        /* Button Styles */
        .action-link { font-weight: 600; text-decoration: none; margin-right: 15px; }
        .edit-link { color: #4CAF50; }
        .delete-link { color: #ff4d4d; }
        .nav-link { display: inline-block; margin-top: 20px; text-decoration: none; color: #a18cd1; font-weight: 600; }
    </style>
</head>
<body>
    <h2>Student Directory</h2>
    <nav class="navbar">
        <div class="nav-links">
            <a href="index.html">➕ Register New</a>
        </div>
    </nav>
    
    <form action="viewProfiles.jsp" method="GET" class="search-container">
        <input type="text" name="q" class="search-input" placeholder="Search by Name or Student ID..." 
               value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">
        <button type="submit" class="search-btn">Search</button>
        <% if (request.getParameter("q") != null) { %>
            <a href="viewProfiles.jsp" class="reset-btn">Reset</a>
        <% } %>
    </form>
    
    <table>
        <tr><th>Name</th><th>ID</th><th>Program</th><th>Hobbies</th><th>Action</th></tr>
        <%
            String searchQuery = request.getParameter("q");
            
            String sql = "SELECT * FROM APP.PROFILE";
            
           if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql += " WHERE LOWER(name) LIKE ? OR studentId LIKE ?";
            }
            
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/PersonalDB", "app", "app");
                PreparedStatement ps = conn.prepareStatement(sql);
                
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String pattern = "%" + searchQuery.toLowerCase() + "%";
                    ps.setString(1, pattern);
                    ps.setString(2, pattern);
                }

                ResultSet rs = ps.executeQuery();
                
                boolean hasResults = false;
                while(rs.next()) {
                    hasResults = true;
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("studentId") %></td>
            <td><%= rs.getString("program") %></td>
            <td><%= rs.getString("hobbies") %></td>
            <td>
                <a href="ProfileServlet?action=edit&id=<%= rs.getInt("id") %>" class="action-link edit-link">Edit</a>
                <a href="ProfileServlet?action=delete&id=<%= rs.getInt("id") %>" 
                   class="action-link delete-link"
                   onclick="return confirm('Are you sure you want to delete this student?');">
                   Delete
                </a>
            </td>
        </tr>
        <% 
                }
                if (!hasResults) {
        %>
            <tr><td colspan="5" style="text-align:center; color:#888; padding:30px;">No students found matching "<%= searchQuery %>"</td></tr>
        <%
                }
                conn.close();
            } catch (Exception e) { out.println("Error: " + e.getMessage()); }
        %>
    </table>
</body>
</html>