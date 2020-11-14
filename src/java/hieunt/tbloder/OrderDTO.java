/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tbloder;

import java.io.Serializable;

/**
 *
 * @author HIEUNGUYEN
 */
public class OrderDTO implements Serializable{
    private float total;
    private String orderDate;
    private String oderAddress;
    private String paymentID;
    private String userID;

    public OrderDTO() {
    }

    public OrderDTO(float total, String orderDate, String oderAddress, String paymentID, String userID) {
        this.total = total;
        this.orderDate = orderDate;
        this.oderAddress = oderAddress;
        this.paymentID = paymentID;
        this.userID = userID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getOderAddress() {
        return oderAddress;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public float getTotal() {
        return total;
    }

    public void setOderAddress(String oderAddress) {
        this.oderAddress = oderAddress;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public void setTotal(float total) {
        this.total = total;
    }
    
}
