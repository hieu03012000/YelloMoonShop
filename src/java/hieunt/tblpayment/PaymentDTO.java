/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblpayment;

import java.io.Serializable;

/**
 *
 * @author HIEUNGUYEN
 */
public class PaymentDTO implements Serializable{
    String payID;
    String name;

    public PaymentDTO() {
    }

    public PaymentDTO(String payID, String name) {
        this.payID = payID;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getPayID() {
        return payID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPayID(String payID) {
        this.payID = payID;
    }
    
}
