package hieunt.cart;

import java.util.HashMap;
import java.util.Map;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author HIEUNGUYEN
 */
public class CartObj {

    private Map<String, CakeInCart> cakeList;
    private float total;

    public Map<String, CakeInCart> getCakeList() {
        return cakeList;
    }

    public float getTotal() {
        return total;
    }

    public void addItem(String id, String name, float price) {
        if (this.cakeList == null) {
            this.cakeList = new HashMap<>();
            this.total = 0;
        }
        CakeInCart info = new CakeInCart(name, 1, price);
        total += price;
        if (this.cakeList.containsKey(id)) {
            info.setQuantity(this.cakeList.get(id).getQuantity() + 1);
            info.setPrice(this.cakeList.get(id).getPrice() + price);
        }
        this.cakeList.put(id, info);
    }
    
    public void subItem(String id, String name, float price) {
        if (this.cakeList.get(id).getQuantity() == 1) {
            removeItem(id);
            return;
        }
        CakeInCart info = new CakeInCart(name, 1, price);
        total -= price;
        if (this.cakeList.containsKey(id)) {
            info.setQuantity(this.cakeList.get(id).getQuantity() - 1);
            info.setPrice(this.cakeList.get(id).getPrice() - price);
        }
        this.cakeList.put(id, info);
    }

    public void removeItem(String id) {
        if (this.cakeList == null) {
            total = 0;
            return;
        }
        if (this.cakeList.containsKey(id)) {
            float p = this.cakeList.get(id).getPrice();
            this.total -= p;
            this.cakeList.remove(id);
            if (this.cakeList.isEmpty()) {
                this.cakeList = null;
            }
        }
    }

}
