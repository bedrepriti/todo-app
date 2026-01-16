package com.Dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import com.ConnectionFactory.ConnectionFactory;
import com.Model.Note;

public class NoteDao {

    // ADD NOTE
    public void insertNote(String text, String uname) {

        try {
            String sql = "INSERT INTO notes(username, notetext, adddate, moddate) VALUES(?,?,?,?)";

            String date = LocalDateTime.now()
                    .format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, uname);
            ps.setString(2, text);
            ps.setString(3, date);
            ps.setString(4, "NA");

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // READ NOTES
    public ArrayList<Note> readAllNotes(String uname) {

        ArrayList<Note> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM notes WHERE username=? ORDER BY noteid DESC";

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, uname);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Note n = new Note();
                n.setNoteid(rs.getInt("noteid"));
                n.setNotetext(rs.getString("notetext"));
                n.setAdddate(rs.getString("adddate"));
                n.setModdate(rs.getString("moddate"));

                list.add(n);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // DELETE NOTE
    public void deleteNote(int id, String uname) {

        try {
            String sql = "DELETE FROM notes WHERE noteid=? AND username=?";

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);
            ps.setString(2, uname);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // UPDATE NOTE
    public void updateNote(int id, String text, String uname) {

        try {
            String sql = "UPDATE notes SET notetext=?, moddate=? WHERE noteid=? AND username=?";

            String date = LocalDateTime.now()
                    .format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, text);
            ps.setString(2, date);
            ps.setInt(3, id);
            ps.setString(4, uname);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
