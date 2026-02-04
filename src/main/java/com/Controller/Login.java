package com.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Dao.UsersInfoDao;


@WebServlet("/userlogin")
public class Login extends HttpServlet {
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("uname");
		String pass = req.getParameter("upass");
		
		UsersInfoDao uDao = new UsersInfoDao();
		String res = uDao.checkUser(name, pass);
		HttpSession s = req.getSession();
		
		if(res.equals("exists"))
		{
			s.setAttribute("check", name);
			resp.sendRedirect("home.jsp");
		}
		else
		{
			s.setAttribute("msg", "Invalid Credentials");
			resp.sendRedirect("login.jsp");
		}
	}

}
