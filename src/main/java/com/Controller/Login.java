package com.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Dao.UsersInfoDao;

@WebServlet("/userlogin") // ✅ This must match your form action
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get form parameters
        String uname = req.getParameter("uname");
        String upass = req.getParameter("upass");

        HttpSession session = req.getSession();

        try {
            UsersInfoDao userDao = new UsersInfoDao();

            // Check credentials
            String result = userDao.checkUser(uname, upass);

            if ("exists".equals(result)) {
                // Successful login
                session.setAttribute("check", uname); // store username in session
                resp.sendRedirect("home.jsp");        // redirect to home page
            } else {
                // Invalid login
                session.setAttribute("msg", "Invalid username or password!");
                resp.sendRedirect("login.jsp");       // redirect back to login page
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Server error, try again!");
            resp.sendRedirect("login.jsp");
        }
    }

    // Optional: allow GET request to show login page (good practice)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }
}
