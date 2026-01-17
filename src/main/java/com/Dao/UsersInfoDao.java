package com.Dao;

import java.sql.*;
import com.ConnectionFactory.ConnectionFactory;

public class UsersInfoDao {

    // Add User
    public String addUser(String name, String pass, String email) {
        try {
            String sql = "INSERT INTO usersinfo(name, password, email) VALUES(?,?,?)";
            Connection con = ConnectionFactory.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);   // 'name' column
            ps.setString(2, pass);   // 'password' column
            ps.setString(3, email);  // 'email' column
            int row = ps.executeUpdate();
            return row == 1 ? "added" : "failed";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    // Check User (Login)
    public String checkUser(String uname, String pass) {
        try {
            String sql = "SELECT * FROM usersinfo WHERE name=? AND password=?";
            Connection con = ConnectionFactory.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, uname); // 'name' column
            ps.setString(2, pass);  // 'password' column
            ResultSet rs = ps.executeQuery();
            return rs.next() ? "exists" : "failed";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }
}
