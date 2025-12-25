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

    // Database Configuration
    String dbURL = "jdbc:derby://localhost:1527/PersonalDB"; // Removed create=true
    String dbUser = "app"; 
    String dbPass = "app"; 

    // HANDLES SAVING (Create OR Update)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action"); // hidden field
        
        // 1. Capture Common Data
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");
        
        // Handle Hobbies (Input text vs Checkboxes)
        // If coming from edit page, it might be a single string, handle carefully
        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbiesStr = (hobbiesArray != null) ? String.join(", ", hobbiesArray) : request.getParameter("hobbies");
        if (hobbiesStr == null) hobbiesStr = "None";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            if ("update".equals(action)) {
                // === UPDATE LOGIC ===
                String id = request.getParameter("id");
                String sql = "UPDATE APP.PROFILE SET name=?, studentId=?, program=?, email=?, hobbies=?, introduction=? WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, studentId);
                ps.setString(3, program);
                ps.setString(4, email);
                ps.setString(5, hobbiesStr);
                ps.setString(6, introduction);
                ps.setInt(7, Integer.parseInt(id));
                ps.executeUpdate();
                
                // Redirect back to list after update
                response.sendRedirect("viewProfiles.jsp");
                
            } else {
                // === INSERT LOGIC (Create New) ===
                ProfileBean profile = new ProfileBean();
                profile.setName(name);
                profile.setStudentId(studentId);
                profile.setProgram(program);
                profile.setEmail(email);
                profile.setHobbies(hobbiesStr);
                profile.setIntroduction(introduction);

                String sql = "INSERT INTO APP.PROFILE (name, studentId, program, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, profile.getName());
                ps.setString(2, profile.getStudentId());
                ps.setString(3, profile.getProgram());
                ps.setString(4, profile.getEmail());
                ps.setString(5, profile.getHobbies());
                ps.setString(6, profile.getIntroduction());
                ps.executeUpdate();
                
                // Forward to Success Card
                request.setAttribute("profile", profile);
                RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
                dispatcher.forward(request, response);
            }
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // HANDLES ACTIONS (Delete OR Edit-Load)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                if ("delete".equals(action)) {
                    // === DELETE ===
                    PreparedStatement ps = conn.prepareStatement("DELETE FROM APP.PROFILE WHERE id = ?");
                    ps.setInt(1, id);
                    ps.executeUpdate();
                    response.sendRedirect("viewProfiles.jsp");
                    
                } else if ("edit".equals(action)) {
                    // === EDIT (Load Data) ===
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM APP.PROFILE WHERE id = ?");
                    ps.setInt(1, id);
                    ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        ProfileBean profile = new ProfileBean();
                        profile.setId(rs.getInt("id"));
                        profile.setName(rs.getString("name"));
                        profile.setStudentId(rs.getString("studentId"));
                        profile.setProgram(rs.getString("program"));
                        profile.setEmail(rs.getString("email"));
                        profile.setHobbies(rs.getString("hobbies"));
                        profile.setIntroduction(rs.getString("introduction"));
                        
                        // Send bean to the Edit Form
                        request.setAttribute("profile", profile);
                        RequestDispatcher rd = request.getRequestDispatcher("editProfile.jsp");
                        rd.forward(request, response);
                    }
                }
                conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
    }
}