package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import com.ConnectionFactory.ConnectionFactory;
import com.Model.Note;

public class NoteDao {
	
	public void insertNote(String notetext, String uname)
	{
		try
		{
			LocalDateTime dt=LocalDateTime.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
			
			String adddate = dtf.format(dt).toString();
			
			String sql = "insert into "+uname+"notes(notetext, adddate, moddate) values(?,?,?)";
			
			Connection con = ConnectionFactory.getCon();
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setString(1, notetext);
			ps.setString(2, adddate);
			ps.setString(3, "NA");
			
			
			ps.executeUpdate();
		}
		catch (Exception e)
		{
			System.out.println(e);
		}
	}
	
	
	
	
	public ArrayList<Note> readAllNotes(String uname)
	{
		ArrayList<Note> al = new ArrayList<Note>();
		try
		{
			String sql = "select * from "+uname+"notes";
			
			Connection con = ConnectionFactory.getCon();
			
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			while(rs.next())
			{
				Note n = new Note();
				n.setNoteid(rs.getInt("noteid"));
				n.setNotetext(rs.getString("notetext"));
				n.setAdddate(rs.getString("adddate"));
				n.setModdate(rs.getString("moddate"));
				
				al.add(n);
			}
		}
		catch (Exception e) 
		{
			System.out.println(e);
		}
		finally
		{
			return al;
		}
	}
	
	
	
	public void deleteNote(String uname, String noteid)
	{
		try
		{
			String sql = "delete from "+uname+"notes where noteid=?";
			
			Connection con = ConnectionFactory.getCon();
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, Integer.valueOf(noteid));
			
			ps.executeUpdate();
		}
		catch (Exception e) 
		{
			System.out.println(e);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
