@WebServlet("/addnote")
public class AddNote extends HttpServlet {

 protected void service(HttpServletRequest req, HttpServletResponse resp)
 throws IOException {

     HttpSession s = req.getSession();
     String uname = (String) s.getAttribute("check");

     // Login validation
     if (uname == null) {
         resp.sendRedirect("login.jsp");
         return;
     }

     String text = req.getParameter("notetext");

     // Input validation
     if (text == null || text.trim().isEmpty()) {
         resp.sendRedirect("home.jsp");
         return;
     }

     try {
         text = text.trim();

         new NoteDao().insertNote(text, uname);

         s.setAttribute("msg", "Note added successfully");

     } catch (Exception e) {
         e.printStackTrace();
     }

     resp.sendRedirect("home.jsp?status=added");
 }
}
