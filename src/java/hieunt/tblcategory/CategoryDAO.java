/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblcategory;

import hieunt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author HIEUNGUYEN
 */
public class CategoryDAO implements Serializable {

    public List<CategoryDTO> getCategoryList() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<CategoryDTO> list = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT categoryID, name\n"
                    + "FROM tblCategory";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                String id = rs.getString("categoryID");
                String name = rs.getString("name");
                list.add(new CategoryDTO(id, name));
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

