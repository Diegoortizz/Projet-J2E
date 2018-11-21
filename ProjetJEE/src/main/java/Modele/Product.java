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
    private int id = -1;
	private String name = "Unknown";
	private float price = 0.0f;

	public Product(int id, String name, float price) {
		this.id = id;
		this.name = name;
		this.price = price;
	}
	
	public Product() {};

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	@Override
	public int hashCode() {
		int hash = 7;
		hash = 97 * hash + this.id;
		hash = 97 * hash + Objects.hashCode(this.name);
		hash = 97 * hash + Float.floatToIntBits(this.price);
		return hash;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		final Product other = (Product) obj;
		if (this.id != other.id) {
			return false;
		}
		if (Float.floatToIntBits(this.price) != Float.floatToIntBits(other.price)) {
			return false;
		}
		return Objects.equals(this.name, other.name);
	}

	@Override
	public String toString() {
		return "Product{" + "id=" + id + ", name=" + name + ", price=" + price + '}';
	}		
}
