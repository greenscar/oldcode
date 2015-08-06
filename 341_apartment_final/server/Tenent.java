import java.util.*;
public class Tenent extends Customer implements java.io.Serializable
{
	private String employer;
	public Tenent(String fn, String ln, float ssn, String logInID, String password,ContactInformation ci){
		super(fn, ln, ssn, logInID, password, ci);
	}
		
	public void setEmployer(String s){
		this.employer = s;
	}
	public String getEmployer(){
		return this.employer;
	}
	
	public void makePayment(float amt){
		super.creditAccount(amt);
	}
	
	public void requestMaintainance(){
		//create new maintenanceReport 
	}	
}
	
	
	