<%@page import="com.Model.Note"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.NoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
</head>
<body class="bg-light">


	<%
	String check = (String) session.getAttribute("check");
	if (check != null) 
	{
	%>
	
	<!-- start of nav bar -->

	<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Hello, <%=check %></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="btn btn-outline-danger btn-sm"
						aria-current="page" href="userlogout">Logout</a></li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>


<!-- end of nav bar -->


<!-- start of form -->
	
<button class="btn btn-outline-danger btn-sm m-5" onclick="openbox()">Add note</button>



<section style="display: none;" id="box">
	<div class="container border rounded-3 p-5 w-50 bg-white" style="position:relative;">
		<button onclick="closebox()" class="btn-outline-danger btn-close m-3" style=" position:absolute; ; top: 0; right: 0;"></button>
		<form action="addnote" method="post">
			<div class="row g-3">
				<div class="col-md-12">
					<div>
						<textarea required placeholder="write note" rows="5" cols="10" class="form-control" name="notetext"></textarea>
					</div>
				</div>
				<input type="hidden" name="uname" value="<%=check%>">
				<div class="col-md-6 offset-md-5">
					<div>
						<button class="btn btn-success btn-sm">Submit</button>
					</div>
				</div>
			</div>
			
		</form>
	</div>
</section>

<!-- end of form -->



<!-- start of display notes -->

<%
NoteDao nDao = new NoteDao();
ArrayList<Note> al=nDao.readAllNotes(check);
%>

<section>
	<div class="container border p-5 rounded-3 mt-5">
		<div class="row g-3">
			<%
			if(al.size() > 0)
			{
				for(Note n:al)
				{
					%>
						<div class="col-md-6">
							<div class="border bg-white rounded p-3" style="position:relative; ">
								<h5>Note:</h5>
								<p><%=n.getNotetext() %></p>
								<p style="position: absolute; top:0; right:0; font-size: 0.8rem">Add Date & time :<%=n.getAdddate() %></p>
								<p style="position: absolute; bottom: 0; right: 0; font-size: 0.8rem">Edit Date & time : <%=n.getModdate() %></p>
								<form action="deletenote">
									<input type="hidden" name="uname" value="<%=check%>">
									<input type="hidden" name="noteid" value="<%=n.getNoteid()%>">
									<button class="btn btn-outline-danger btn-sm">Delete</button>
								</form>
								
									
								<form action="#">
									<button class="btn btn-outline-info btn-sm mt-3">Edit</button>
								</form>
								
							</div>
						</div>
					<%
				}
			}
			%>
			<%
			if(al.size() == 0)
			{
				%>
				<div class="col-md-12">
					<h1 class="display-6">No notes Available</h1>
				</div>
				<%
			}
			%>
		</div>
		
	</div>
</section>

<!-- end of display notes -->








<!-- start of edit -->
	

<!-- end of edit -->





















<script type="text/javascript">

var myModal = document.getElementById('myModal')
var myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', function () {
  myInput.focus()
})



function openbox()
{
	document.getElementById('box').style.display="block";
}

function closebox()
{
	document.getElementById('box').style.display="none";
}
</script>










	<%
	} else 
	{
	response.sendRedirect("login.jsp");
	}
	%>

</body>
</html>