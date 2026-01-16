<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up - My Notes App</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    height: 100vh;
    background: linear-gradient(135deg, #ff9ff3, #feca57);
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Arial', sans-serif;
}

.card-signup {
    width: 450px;
    padding: 30px;
    border-radius: 15px;
    background: #ffffff;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.card-signup h1 {
    font-size: 2rem;
    color: #ee5253;
}

.btn-signup {
    width: 100%;
}

.msg {
    margin-bottom: 15px;
    font-weight: 500;
    text-align: center;
}
</style>
</head>
<body>

<%
String msg = (String) session.getAttribute("msg");
if(msg != null){
%>
<div class="msg text-danger"><%=msg%></div>
<%
}
session.removeAttribute("msg");
%>

<div class="card card-signup">
    <h1 class="text-center mb-4">Sign Up</h1>
    <form action="adduser" method="post">
        <div class="mb-3">
            <label for="uname" class="form-label">Username</label>
            <input type="text" name="uname" id="uname" class="form-control" placeholder="Enter username" required>
        </div>
        <div class="mb-3">
            <label for="upass" class="form-label">Password</label>
            <input type="password" name="upass" id="upass" class="form-control" placeholder="Enter password" required>
        </div>
        <div class="mb-3">
            <label for="uemail" class="form-label">Email</label>
            <input type="email" name="uemail" id="uemail" class="form-control" placeholder="Enter email" required>
        </div>
        <button type="submit" class="btn btn-success btn-signup mb-3">Sign Up</button>
        <p class="text-center">Already have an account? <a href="login.jsp" class="text-danger">Login</a></p>
    </form>
</div>

</body>
</html>
