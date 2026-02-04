package com.Controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Dao.NoteDao;

@WebServlet("/editnote")
public class EditNote extends HttpServlet {

 protected void service(HttpServletRequest req, HttpServletResponse resp)
 throws IOException {

     HttpSession s = req.getSession();
     String uname = (String) s.getAttribute("check");

     // Login validation
     if (uname == null) {
         resp.sendRedirect("login.jsp");
         return;
     }

     String idStr = req.getParameter("noteid");
     String text = req.getParameter("notetext");

     // Input validation
     if (idStr == null || text == null || text.trim().isEmpty()) {
         resp.sendRedirect("home.jsp");
         return;
     }

     try {
         int id = Integer.parseInt(idStr);

         text = text.trim();

         new NoteDao().updateNote(id, text, uname);

         s.setAttribute("msg", "Note updated successfully");

     } catch (Exception e) {
         e.printStackTrace();
     }

     resp.sendRedirect("home.jsp");
 }
}

