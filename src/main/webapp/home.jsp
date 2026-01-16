<%@page import="com.Model.Note"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.NoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Notes - Professional UI</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Toastify -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<style>
body {
    background: linear-gradient(to right, #667eea, #764ba2);
    font-family: 'Arial', sans-serif;
    min-height: 100vh;
}

/* Navbar styling */
.navbar {
    background: #ffffff !important;
    border-radius: 10px;
    margin: 15px 30px;
    padding: 10px 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

/* Add/Edit modal box */
#addBox {
    background: #ffffff;
    border-radius: 15px;
    padding: 25px;
    width: 50%;
    position: fixed;
    top: 15%;
    left: 25%;
    z-index: 1000;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

/* Notes cards */
.note-card {
    transition: transform 0.2s;
}
.note-card:hover {
    transform: scale(1.03);
}

/* Pagination buttons */
.pagination-container {
    text-align: center;
    margin: 20px 0;
}
.pagination-container .btn {
    margin: 0 3px;
}
</style>
</head>
<body>

<%
String user = (String) session.getAttribute("check");
if(user != null){
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light shadow-sm">
    <a class="navbar-brand">Hello, <%=user%></a>
    <div class="ms-auto">
        <a href="userlogout" class="btn btn-danger btn-sm">Logout</a>
    </div>
</nav>

<!-- Add Note Button -->
<div class="container mt-3 d-flex justify-content-between align-items-center">
    <button class="btn btn-primary" onclick="openAddNoteBox()">Add Note</button>
    <input type="text" id="searchInput" class="form-control w-50" placeholder="Search notes...">
</div>

<!-- Add Note Modal -->
<section id="addBox" style="display:none;">
    <button class="btn-close float-end" onclick="closeAddNoteBox()"></button>
    <h4>Add New Note</h4>
    <form action="addnote" method="post">
        <input type="hidden" name="uname" value="<%=user%>">
        <textarea class="form-control mt-3" name="notetext" rows="5" placeholder="Write your note here..." required></textarea>
        <button class="btn btn-success mt-3 w-100">Save Note</button>
    </form>
</section>

<!-- Edit Note Modal -->
<div class="modal fade" id="editModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Note</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="editnote" method="post">
                <div class="modal-body">
                    <input type="hidden" name="noteid" id="editNoteId">
                    <input type="hidden" name="uname" value="<%=user%>">
                    <textarea class="form-control" rows="5" name="notetext" id="editNoteText" required></textarea>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Update Note</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Notes Display -->
<%
NoteDao dao = new NoteDao();
ArrayList<Note> notes = dao.readAllNotes(user);
%>
<div class="container mt-4" id="notesContainer">
    <div class="row g-3">
        <%
        if(notes.size() > 0){
            for(Note n : notes){
        %>
        <div class="col-md-6 note-card">
            <div class="card shadow-sm">
                <div class="card-body">
                    <p><%=n.getNotetext()%></p>
                    <small class="text-muted">Added: <%=n.getAdddate()%> | Edited: <%=n.getModdate()%></small>
                    <div class="mt-2 text-end">
                        <button class="btn btn-danger btn-sm" onclick="confirmDelete('<%=n.getNoteid()%>')">Delete</button>
                        <form id="deleteForm<%=n.getNoteid()%>" action="deletenote" method="post">
                            <input type="hidden" name="noteid" value="<%=n.getNoteid()%>">
                            <input type="hidden" name="uname" value="<%=user%>">
                        </form>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
                                onclick="openEditModal('<%=n.getNoteid()%>', '<%=n.getNotetext()%>')">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <h4 class="text-center text-white mt-5">No notes available</h4>
        <%
        }
        %>
    </div>
</div>

<!-- Pagination container -->
<div class="pagination-container" id="pagination"></div>

<script>
// Open and close Add Note box
function openAddNoteBox(){ document.getElementById("addBox").style.display = "block"; }
function closeAddNoteBox(){ document.getElementById("addBox").style.display = "none"; }

// Edit Note Modal
function openEditModal(id, text){
    document.getElementById("editNoteId").value = id;
    document.getElementById("editNoteText").value = text;
}

// Toast messages
const urlParams = new URLSearchParams(window.location.search);
const status = urlParams.get("status");
if(status === "added") showToast("Note added successfully!");
if(status === "updated") showToast("Note updated successfully!");
if(status === "deleted") showToast("Note deleted successfully!");

function showToast(msg){
    Toastify({
        text: msg,
        duration: 3000,
        gravity: "top",
        position: "right",
        style: { background: "#198754" }
    }).showToast();
}

// Confirm Delete
function confirmDelete(id){
    Swal.fire({
        title: "Are you sure?",
        text: "This note will be deleted!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#dc3545",
        cancelButtonColor: "#6c757d",
        confirmButtonText: "Delete"
    }).then((result)=>{
        if(result.isConfirmed){
            document.getElementById("deleteForm"+id).submit();
        }
    });
}

// Search Notes
document.getElementById("searchInput").addEventListener("keyup", function(){
    let search = this.value.toLowerCase();
    let cards = document.getElementsByClassName("note-card");
    for(let i=0;i<cards.length;i++){
        let text = cards[i].innerText.toLowerCase();
        cards[i].style.display = text.includes(search) ? "block" : "none";
    }
});

// Pagination
let cards = document.getElementsByClassName("note-card");
let perPage = 4;
function showPage(page){
    let start = (page-1)*perPage;
    let end = start+perPage;
    for(let i=0;i<cards.length;i++){
        cards[i].style.display = (i>=start && i<end) ? "block" : "none";
    }
}
let totalPages = Math.ceil(cards.length/perPage);
let paginationDiv = document.getElementById("pagination");
for(let i=1;i<=totalPages;i++){
    let btn = document.createElement("button");
    btn.innerText = i;
    btn.className = "btn btn-outline-light btn-sm me-1";
    btn.onclick = function(){ showPage(i); };
    paginationDiv.appendChild(btn);
}
showPage(1);

</script>

<%
} else {
    response.sendRedirect("login.jsp");
}
%>

</body>
</html>
