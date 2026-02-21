package com.Controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.Dao.NoteDao;

@WebServlet("/addnote") 
public class AddNote extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String uname = (String) session.getAttribute("check");

        if(uname == null){
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String text = req.getParameter("notetext");
        if(text == null || text.trim().isEmpty()){
            resp.sendRedirect(req.getContextPath() + "/home.jsp");
            return;
        }

        try {
            new NoteDao().insertNote(text.trim(), uname);
            session.setAttribute("msg", "Note added successfully!");
        } catch(Exception e){
            e.printStackTrace();
            session.setAttribute("msg", "Error adding note!");
        }

        resp.sendRedirect(req.getContextPath() + "/home.jsp");
    }
}
