/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tbluser;

import java.io.Serializable;

/**
 *
 * @author HIEUNGUYEN
 */
public class UserDTO implements Serializable{
    private String email;
    private String name;
    private String password;
    private String role;
    private String address;

    public UserDTO() {
    }

    public UserDTO(String email, String name, String password, String role, String address) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
    
    
}
