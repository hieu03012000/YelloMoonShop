/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblproduct;

import hieunt.cart.CakeInCart;
import hieunt.cart.CartObj;
import hieunt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.naming.NamingException;

/**
 *
 * @author HIEUNGUYEN
 */
public class ProductDAO implements Serializable {

    public List<ProductDTO> getProductListForUser(String search, String category, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT p.productID, p.name, p.price, p.quantity, p.image, p.createDate, p.expirationDate, c.name as category, p.description\n"
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID\n"
                    + "WHERE quantity > 0 AND status = 1 AND p.name LIKE ? AND c.name LIKE ?  AND p.price > ? AND p.price <= ? AND p.expirationDate > GETDATE()\n"
                    + "ORDER BY createDate DESC\n"
                    + "OFFSET ? ROWS\n"
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + category + "%");
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            ps.setInt(5, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                String productID = rs.getString("productID");
                String name = rs.getString("name");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                Timestamp date1 = rs.getTimestamp("createDate");
                Timestamp date2 = rs.getTimestamp("expirationDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date1);
                String expirationDate = format.format(date2);
                String cate = rs.getString("category");
                String description = rs.getString("description");
                list.add(new ProductDTO(productID, name, price, quantity, image, createDate, expirationDate, cate, true, description));
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

    public List<ProductDTO> getProductListForAdmin(String search, String category, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT p.productID, p.name, p.price, p.quantity, p.image, p.createDate, p.expirationDate, c.name as category, p.status, p.description\n"
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID\n"
                    + "WHERE p.name LIKE ? AND c.name LIKE ?  AND p.price > ? AND p.price <= ?\n"
                    + "ORDER BY createDate DESC\n"
                    + "OFFSET ? ROWS\n"
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + category + "%");
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            ps.setInt(5, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                String productID = rs.getString("productID");
                String name = rs.getString("name");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                Timestamp date1 = rs.getTimestamp("createDate");
                Timestamp date2 = rs.getTimestamp("expirationDate");
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                String createDate = format.format(date1);
                String expirationDate = format.format(date2);
                String cate = rs.getString("category");
                boolean status = rs.getBoolean("status");
                String description = rs.getString("description");
                list.add(new ProductDTO(productID, name, price, quantity, image, createDate, expirationDate, cate, status, description));
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

    public int getMaxPrice() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT TOP 1 price\n"
                    + "FROM tblProduct\n"
                    + "ORDER BY price DESC";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("price");
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
        return 0;
    }

    public int pageCountForUser(String search, String category, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT count(p.productID) AS row\n"
                        + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID\n"
                        + "WHERE quantity > 0 AND status = 1 AND p.name LIKE ? AND c.name LIKE ? AND p.price > ? AND p.price <= ? AND p.expirationDate > GETDATE()";
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + category + "%");
                ps.setFloat(3, min);
                ps.setFloat(4, max);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int count = (rs.getInt("row") - 1) / 20;
                    return count + 1;
                }
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
        return 0;
    }

    public int pageCountForAdmin(String search, String category, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT count(p.productID) AS row\n"
                        + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID\n"
                        + "WHERE p.name LIKE ? AND c.name LIKE ? AND p.price > ? AND p.price <= ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + category + "%");
                ps.setFloat(3, min);
                ps.setFloat(4, max);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int count = (rs.getInt("row") - 1) / 20;
                    return count + 1;
                }
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
        return 0;
    }

    public void updateProduct(ProductDTO dto) throws SQLException, NamingException, ParseException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE tblProduct SET name = ?, price = ?, quantity = ?,\n"
                        + "categoryID = ?, image = ?, createDate = ?,\n"
                        + "expirationDate = ?, status = ?\n"
                        + "WHERE productID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getName());
                ps.setFloat(2, dto.getPrice());
                ps.setInt(3, dto.getQuantity());
                ps.setString(4, dto.getCategory());
                ps.setString(5, dto.getImage());
                ps.setString(6, dto.getCreateDate());
                ps.setString(7, dto.getExpirationDate());
                ps.setBoolean(8, dto.isStatus());
                ps.setString(9, dto.getProductID());
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

    public void addNewProduct(ProductDTO dto) throws SQLException, NamingException, ParseException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblProduct(name, price, quantity, categoryID, image, createDate, expirationDate, status)\n"
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getName());
                ps.setFloat(2, dto.getPrice());
                ps.setInt(3, dto.getQuantity());
                ps.setString(4, dto.getCategory());
                ps.setString(5, dto.getImage());
                ps.setString(6, dto.getCreateDate());
                ps.setString(7, dto.getExpirationDate());
                ps.setBoolean(8, dto.isStatus());
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

    public String getImageByID(String productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT image\n"
                        + "FROM tblProduct\n"
                        + "WHERE productID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, productID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString("image");
                }
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

    public ProductDTO getPproductByID(String productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productID, name, price, quantity, description\n"
                        + "FROM tblProduct\n"
                        + "WHERE productID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, productID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    String description = rs.getString("description");
                    return new ProductDTO(productID, name, price, quantity, "", "", "", "", true, description);
                }
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

    public String getNewestProductID(String name) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT TOP 1 productID FROM tblProduct\n"
                    + "Where name = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("productID");
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

    public void changeQuantity(Map<String, CakeInCart> list) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            Set<String> keys = list.keySet();
            for (String key : keys) {
                String sql = "UPDATE tblProduct SET quantity = (SELECT quantity\n"
                        + "FROM tblProduct\n"
                        + "WHERE productID = ?) - ?\n"
                        + "WHERE productID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, key);
                ps.setInt(2, list.get(key).getQuantity());
                ps.setString(3, key);
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
}
