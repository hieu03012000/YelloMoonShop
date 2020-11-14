/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tbllog;

import java.io.Serializable;

/**
 *
 * @author HIEUNGUYEN
 */
public class LogDTO implements Serializable{
    private String logID;
    private String email;
    private String productID;
    private String date;
    private String type;

    public LogDTO() {
    }

    public LogDTO(String logID, String email, String productID, String date, String type) {
        this.logID = logID;
        this.email = email;
        this.productID = productID;
        this.date = date;
        this.type = type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }


    public String getDate() {
        return date;
    }

    public String getEmail() {
        return email;
    }

    public String getLogID() {
        return logID;
    }

    public String getProductID() {
        return productID;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setLogID(String logID) {
        this.logID = logID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }
    
    
}
