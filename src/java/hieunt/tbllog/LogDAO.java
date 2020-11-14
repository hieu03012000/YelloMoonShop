/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tbllog;

import hieunt.tblproduct.ProductDTO;
import hieunt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author HIEUNGUYEN
 */
public class LogDAO implements Serializable {

    public void addLog(LogDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "INSERT INTO tblLog(userID, productID, date, type)\n"
                    + "VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, dto.getEmail());
            ps.setString(2, dto.getProductID());
            java.util.Date date = new java.util.Date();
            Timestamp d = new Timestamp(date.getTime());
            ps.setTimestamp(3, d);
            ps.setString(4, dto.getType());
            ps.executeUpdate();
        } finally {

            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void deleteLog(String productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "DELETE FROM tblLog\n"
                    + "WHERE productID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, productID);
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean isUpdated(String productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT productID\n"
                    + "FROM tblLog\n"
                    + "WHERE productID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public List<LogDTO> viewLog() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<LogDTO> list = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT TOP 10 l.logID, u.name as 'username', p.name, l.date, l.type\n"
                    + "FROM tblUser u join tblLog l ON u.email = l.userID\n"
                    + "join tblProduct p ON p.productID = l.productID\n"
                    + "ORDER BY date DESC";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                String logID = rs.getString("logID");
                String name = rs.getString("username");
                String productName = rs.getString("name");
                Timestamp date2 = rs.getTimestamp("date");
                String type = rs.getString("type");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                String date = format.format(date2);
                list.add(new LogDTO(logID, name, productName, date, type));
            }
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
}
