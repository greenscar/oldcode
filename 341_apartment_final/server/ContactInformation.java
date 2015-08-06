public class ContactInformation implements java.io.Serializable
{
	private String street;
	private int aptNum;
	private String city;
	private String state;
	private float zipCode;
	private float phoneNum;
	public ContactInformation(String street, int aptNum,
								String city, String state, float zip,
								float phone){
		this.street = street;
		this.aptNum = aptNum;
		this.city = city;
		this.state = state;
		this.zipCode = zip;
		this.phoneNum = phone;
	}
	//QUERIES
	public String getStreet()
	{
		return this.street;
	}
	public int getAptNum(){
		return this.aptNum;
	}
	public String getCity(){
		return this.city;
	}
	public String getState(){
		return this.state;
	}
	public float getZipCode(){
		return this.zipCode;
	}
	public float getPhoneNum(){
		return this.phoneNum;
	}
	
	//COMMANDS
	public void setStreetLoc(String s){
		this.street = s;
	}
	public void setAptNum(int k){
		this.aptNum = k;
	}
	public void setCity(String k){
		this.city = k;
	}
	public void setZipCode(float k){
		this.zipCode = k;
	}
	public void getPhoneNum(float k){
		this.phoneNum = k;
	}
}
	
		
								
								