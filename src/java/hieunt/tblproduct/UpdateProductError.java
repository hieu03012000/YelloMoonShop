/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.tblproduct;

/**
 *
 * @author HIEUNGUYEN
 */
public class UpdateProductError {
    private String nameError;
    private String priceError;
    private String quantityError;
    private String imageError;
    private String cDateError;
    private String eDateError;

    public UpdateProductError() {
    }

    public String getNameError() {
        return nameError;
    }

    public void setNameError(String nameError) {
        this.nameError = nameError;
    }

    public String getPriceError() {
        return priceError;
    }

    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

    public String getQuantityError() {
        return quantityError;
    }

    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    public String getImageError() {
        return imageError;
    }

    public void setImageError(String imageError) {
        this.imageError = imageError;
    }

    public String getcDateError() {
        return cDateError;
    }

    public void setcDateError(String cDateError) {
        this.cDateError = cDateError;
    }

    public String geteDateError() {
        return eDateError;
    }

    public void seteDateError(String eDateError) {
        this.eDateError = eDateError;
    }
    
    
}
