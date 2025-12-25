package com.profileweb.assignment;

import com.profile.model.ProfileBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    // DATABASE CONFIGURATION
    String dbURL = "jdbc:derby://localhost:1527/ProfileDB";
    String dbUser = "app"; 
    String dbPass = "app"; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Capture Data
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");
        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbiesStr = (hobbiesArray != null) ? String.join(", ", hobbiesArray) : "None";

        // 2. Populate Bean
        ProfileBean profile = new ProfileBean();
        profile.setName(name);
        profile.setStudentId(studentId);
        profile.setProgram(program);
        profile.setEmail(email);
        profile.setHobbies(hobbiesStr);
        profile.setIntroduction(introduction);

        // 3. JDBC Insert
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/PersonalDB", "app", "app");
            
            String sql = "INSERT INTO APP.PROFILE (name, studentId, program, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, profile.getName());
            statement.setString(2, profile.getStudentId());
            statement.setString(3, profile.getProgram());
            statement.setString(4, profile.getEmail());
            statement.setString(5, profile.getHobbies());
            statement.setString(6, profile.getIntroduction());
            
            statement.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. Forward to JSP
        request.setAttribute("profile", profile);
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }

    // DELETE feature
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("delete".equals(action) && id != null) {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/PersonalDB", "app", "app");
                PreparedStatement ps = conn.prepareStatement("DELETE FROM APP.PROFILE WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        response.sendRedirect("viewProfiles.jsp");
    }
}