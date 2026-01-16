package com.Controller;

import java.io.IOException;

import com.Dao.NoteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addnote")
public class AddNote extends HttpServlet {

 protected void service(HttpServletRequest req, HttpServletResponse resp)
 throws IOException {

     HttpSession s = req.getSession();
     String uname = (String) s.getAttribute("check");

     String text = req.getParameter("notetext");

     new NoteDao().insertNote(text, uname);

     resp.sendRedirect("home.jsp?status=added");
 }
}
