/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tbloder;

import hieunt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;

/**
 *
 * @author HIEUNGUYEN
 */
public class OrderDAO implements Serializable {

    public void addOrder(OrderDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "INSERT INTO tblOrder(total, orderDate, orderAddress, paymentID, email)\n"
                    + "VALUES (?, ?, ? , ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setFloat(1, dto.getTotal());
            java.util.Date date = new java.util.Date();
            Timestamp d = new Timestamp(date.getTime());
            ps.setTimestamp(2, d);
            ps.setString(3, dto.getOderAddress());
            ps.setString(4, dto.getPaymentID());
            ps.setString(5, dto.getUserID());
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

    public String getNewestOrderID(String userID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT TOP 1 orderID FROM tblOrder\n"
                    + "WHERE email = ?\n"
                    + "ORDER BY orderDate DESC";
            ps = con.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("orderID");
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
        return "";
    }

    public OrderDTO getOrder(String orderID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT total, orderDate, orderAddress, p.name, email\n"
                    + "FROM tblOrder o JOIN tblPayment p ON o.paymentID = p.paymentID \n"
                    + "WHERE orderID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, orderID);
            rs = ps.executeQuery();
            if (rs.next()) {
                float total = rs.getFloat("total");
                Timestamp date1 = rs.getTimestamp("orderDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String date = format.format(date1);
                String address = rs.getString("orderAddress");
                String payment = rs.getString("name");
                String userID = rs.getString("email");
                return new OrderDTO(total, date, address, payment, userID);
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
        return null;
    }
}
