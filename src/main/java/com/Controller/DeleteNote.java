package com.Controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Dao.NoteDao;

@WebServlet("/deletenote")
public class DeleteNote extends HttpServlet {

 protected void service(HttpServletRequest req, HttpServletResponse resp)
 throws IOException {

     HttpSession s = req.getSession();
     String uname = (String) s.getAttribute("check");

     // Session validation
     if (uname == null) {
         resp.sendRedirect("login.jsp");
         return;
     }

     String noteIdStr = req.getParameter("noteid");

     // Parameter validation
     if (noteIdStr == null) {
         resp.sendRedirect("home.jsp");
         return;
     }

     try {
         int id = Integer.parseInt(noteIdStr);

         new NoteDao().deleteNote(id, uname);

         s.setAttribute("msg", "Note deleted successfully");

     } catch (Exception e) {
         e.printStackTrace();
     }

     resp.sendRedirect("home.jsp");
 }
}

