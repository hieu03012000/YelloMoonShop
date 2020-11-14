/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblorderdetail;

import hieunt.cart.CakeInCart;
import hieunt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.naming.NamingException;

/**
 *
 * @author HIEUNGUYEN
 */
public class OrderDetailDAO implements Serializable {

    public void addDetail(Map<String, CakeInCart> list, String oID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            Set<String> keys = list.keySet();
            for (String key : keys) {
                String sql = "INSERT INTO tblOrderDetail(orderID, productID, quantity, price)\n"
                        + "VALUES (?, ?, ? , ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, oID);
                ps.setString(2, key);
                ps.setInt(3, list.get(key).getQuantity());
                ps.setFloat(4, list.get(key).getPrice());
                ps.executeUpdate();
            }

        } finally {

            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public List<OrderDetailDTO> getDetail(String orderID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderDetailDTO> list = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT p.name, o.quantity, o.price\n"
                    + "FROM tblOrderDetail o JOIN tblProduct p ON o.productID = p.productID\n"
                    + "WHERE o.orderID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, orderID);
            rs = ps.executeQuery();
            while (rs.next()) {
                if(list == null) {
                    list = new ArrayList<>();
                }
                String name = rs.getString("name");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price");
                list.add(new OrderDetailDTO(name, quantity, price));
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
