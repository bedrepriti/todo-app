<%@ page import="com.Model.Note"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.Dao.NoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - My Notes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body { font-family: Arial, sans-serif; background: #f0f2f5; }
.navbar { margin-bottom: 20px; }
#addBox { display: none; background: #fff; padding: 20px; border-radius: 10px; width: 50%; position: fixed; top: 15%; left: 25%; z-index: 1000; box-shadow: 0 5px 15px rgba(0,0,0,0.2);}
</style>
</head>
<body>

<%
String user = (String) session.getAttribute("check");
if(user == null){
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<nav class="navbar navbar-light bg-light">
    <a class="navbar-brand">Hello, <%=user%></a>
    <a href="<%=request.getContextPath()%>/userlogout" class="btn btn-danger btn-sm">Logout</a>
</nav>

<div class="container">
    <button class="btn btn-primary mb-3" onclick="document.getElementById('addBox').style.display='block'">Add Note</button>
    
    <!-- Add Note Form -->
    <div id="addBox">
        <form action="<%=request.getContextPath()%>/addnote" method="post">
            <textarea name="notetext" rows="5" class="form-control" placeholder="Write your note..." required></textarea>
            <input type="hidden" name="uname" value="<%=user%>">
            <button type="submit" class="btn btn-success mt-2">Save Note</button>
            <button type="button" class="btn btn-secondary mt-2" onclick="document.getElementById('addBox').style.display='none'">Cancel</button>
        </form>
    </div>

    <!-- Display Notes -->
    <div class="mt-4">
        <%
        NoteDao dao = new NoteDao();
        ArrayList<Note> notes = dao.readAllNotes(user);
        if(notes.isEmpty()){
        %>
        <p>No notes available.</p>
        <%
        } else {
            for(Note n: notes){
        %>
        <div class="card mb-2">
            <div class="card-body">
                <p><%=n.getNotetext()%></p>
                <small>Added: <%=n.getAdddate()%> | Edited: <%=n.getModdate()%></small>
                <form action="<%=request.getContextPath()%>/deletenote" method="post" style="display:inline;">
                    <input type="hidden" name="noteid" value="<%=n.getNoteid()%>">
                    <input type="hidden" name="uname" value="<%=user%>">
                    <button class="btn btn-danger btn-sm">Delete</button>
                </form>
            </div>
        </div>
        <%
            }
        }
        %>
    </div>
</div>

</body>
</html>
