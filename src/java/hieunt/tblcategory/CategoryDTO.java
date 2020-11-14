/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblcategory;

import java.io.Serializable;

/**
 *
 * @author HIEUNGUYEN
 */
public class CategoryDTO implements Serializable{
    private String categoryID;
    private String name;

    public CategoryDTO() {
    }

    public CategoryDTO(String categoryID, String name) {
        this.categoryID = categoryID;
        this.name = name;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public String getName() {
        return name;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
