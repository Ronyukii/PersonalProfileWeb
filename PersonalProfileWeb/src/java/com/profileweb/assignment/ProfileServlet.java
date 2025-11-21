package com.profileweb.assignment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

// Map the servlet to handle the form action
@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve data from the HTML form
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");
        
        // Handle hobbies (checkboxes return an array of strings)
        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbiesStr = "None selected";
        
        if (hobbiesArray != null && hobbiesArray.length > 0) {
            // Join array elements into a single string for easy display
            hobbiesStr = String.join(", ", hobbiesArray);
        }

        // 2. Set attributes to pass data to the JSP
        request.setAttribute("userName", name);
        request.setAttribute("userId", studentId);
        request.setAttribute("userProgram", program);
        request.setAttribute("userEmail", email);
        request.setAttribute("userHobbies", hobbiesStr);
        request.setAttribute("userIntro", introduction);

        // 3. Forward the request to the JSP page for display
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile_view.jsp");
        dispatcher.forward(request, response);
    }
}