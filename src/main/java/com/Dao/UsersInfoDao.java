package com.Dao;

import java.sql.*;

import com.ConnectionFactory.ConnectionFactory;

public class UsersInfoDao {

    public String addUser(String name, String pass, String email) {

        try {
            String sql = "INSERT INTO usersinfo VALUES(?,?,?)";

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, pass);
            ps.setString(3, email);

            int row = ps.executeUpdate();

            return row == 1 ? "added" : "failed";

        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    public String checkUser(String uname, String pass) {

        try {
            String sql = "SELECT * FROM usersinfo WHERE username=? AND password=?";

            Connection con = ConnectionFactory.getCon();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, uname);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            return rs.next() ? "exists" : "failed";

        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }
}
