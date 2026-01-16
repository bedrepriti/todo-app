package com.Controller;

import java.io.IOException;

import com.Dao.NoteDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editnote")
public class EditNote extends HttpServlet {

 protected void service(HttpServletRequest  req, HttpServletResponse   resp)
 throws IOException {

     HttpSession s = req.getSession();
     String uname = (String) s.getAttribute("check");

     int id = Integer.parseInt(req.getParameter("noteid"));
     String text = req.getParameter("notetext");

     new NoteDao().updateNote(id, text, uname);

     resp.sendRedirect("home.jsp");
 }
}
