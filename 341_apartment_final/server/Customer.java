public class Customer extends Person implements java.io.Serializable
{
	private float balance = 0;
	private float custID;
	private float creditCardNum;
	
	public Customer(String fn, String ln, float ssn, String lid, String pw,ContactInformation ci){
		super(fn, ln, ssn, lid, pw,ci);
	}
	
	public float getCustID(){
		return this.custID;
	}
	public float getBalance(){
		return this.balance;
	}
	
	public float getCreditCardNum(){
		return this.creditCardNum;
	}
	
	/* 
	 * chargeAccount WILL NOT BE PREFORMED BY THE CUSTOMER
	 * 	HOWEVER, WE NEED A WAY TO CHARGE THE CUSTOMER'S 
	 *	ACCOUNT.
	 */
	public void chargeAccount(float fees){
		this.balance += fees;
	}
	
	public void creditAccount(float fees){
		this.balance -= fees;
	}
}
	
	
	