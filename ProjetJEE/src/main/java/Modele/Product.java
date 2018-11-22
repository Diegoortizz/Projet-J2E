/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modele;

import java.util.Objects;

/**
 *
 * @author Matthias
 */
public class Product {
    private int Product_ID;
    private String Description;
    
    public Product(int Product_ID, String Description) {
		this.Product_ID = Product_ID;
		this.Description = Description;
	}
    
    public int getProduct_Id(){
        return Product_ID;
    }
    
    public String getDescription(){
        return Description;
    }
}
