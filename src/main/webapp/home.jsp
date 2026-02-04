<%@ page import="com.Model.Note"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.Dao.NoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - My Notes</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- SweetAlert for delete confirmation -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body { font-family: Arial, sans-serif; background: #f0f2f5; }
.navbar { margin-bottom: 20px; }
#addBox { display: none; background: #fff; padding: 20px; border-radius: 10px; width: 50%; position: fixed; top: 15%; left: 25%; z-index: 1000; box-shadow: 0 5px 15px rgba(0,0,0,0.2);}
.card { transition: transform 0.2s; }
.card:hover { transform: scale(1.02); }
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

<!-- Navbar -->
<nav class="navbar navbar-light bg-light px-4">
    <a class="navbar-brand">Hello, <%=user%></a>
    <a href="<%=request.getContextPath()%>/userlogout" class="btn btn-danger btn-sm">Logout</a>
</nav>

<div class="container">

    <!-- Add Note Button -->
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

    <!-- Edit Note Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/editnote" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Note</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="noteid" id="editNoteId">
                        <textarea name="notetext" id="editNoteText" rows="5" class="form-control" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Note</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Notes Display -->
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
        <div class="card mb-2 p-2">
            <p><%=n.getNotetext()%></p>
            <small>Added: <%=n.getAdddate()%> | Edited: <%=n.getModdate()%></small>
            <div class="mt-2">
                <!-- Delete -->
                <form id="deleteForm<%=n.getNoteid()%>" action="<%=request.getContextPath()%>/deletenote" method="post" style="display:inline;">
                    <input type="hidden" name="noteid" value="<%=n.getNoteid()%>">
                    <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete('<%=n.getNoteid()%>')">Delete</button>
                </form>

                <!-- Edit -->
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
                    onclick="openEditModal('<%=n.getNoteid()%>', '<%=n.getNotetext().replaceAll("'", "\\\\'")%>')">Edit</button>
            </div>
        </div>
        <%
            }
        }
        %>
    </div>

</div>

<script>
// Open edit modal and set values
function openEditModal(id, text){
    document.getElementById('editNoteId').value = id;
    document.getElementById('editNoteText').value = text;
}

// Confirm delete
function confirmDelete(id){
    Swal.fire({
        title: 'Are you sure?',
        text: "This note will be deleted!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Delete'
    }).then((result) => {
        if(result.isConfirmed){
            document.getElementById('deleteForm'+id).submit();
        }
    });
}
</script>

</body>
</html>
