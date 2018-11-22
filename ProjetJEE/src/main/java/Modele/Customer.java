/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modele;

/**
 *
 * @author Matthias
 */
public class Customer {
    // TODO : ajouter les autres propriétés
	private int customerId;
	private String name;
	private String addressLine1;
        private String city;
        private String State;
        private String phone;
        private String fax;
        private String Email;
        private int Credit_Limit;

	public Customer(int customerId, String name, String addressLine1,String city, String State, String phone, String fax, String Email, int Credit) {
		this.customerId = customerId;
		this.name = name;
		this.addressLine1 = addressLine1;
                this.city=city;
                this.State=State;
                this.phone=phone;
                this.fax=fax;
                this.Email=Email;
                this.Credit_Limit=Credit;
	}

	/**
	 * Get the value of customerId
	 *
	 * @return the value of customerId
	 */
	public int getCustomerId() {
		return customerId;
	}

	/**
	 * Get the value of name
	 *
	 * @return the value of name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Get the value of addressLine1
	 *
	 * @return the value of addressLine1
	 */
	public String getAddressLine1() {
		return addressLine1;
	}
        
        public String getCity() {
		return city;
	}
        
        public String getState() {
		return State;
	}
        
        public String getPhone() {
		return phone;
	}
        
        public String getFax() {
		return fax;
	}
        
        public String getEmail() {
		return Email;
	}
        
        public int getCreditLimit() {
		return Credit_Limit;
	}
}
