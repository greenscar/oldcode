public class Person implements java.io.Serializable
{
	protected String firstName;
	protected String lastName;
	protected String logInID;
	protected String password;
	protected float ssn;
	protected ContactInformation contactInfo;
	
	public Person(){
		this(null, null);
	}
	public Person(String fn, String ln){
		this.firstName = fn;
		this.lastName = ln;
	}
	public Person(String fn, String ln, float ssn, String logInID, String password,
							ContactInformation ci){
		this.contactInfo = ci;
		this.firstName = fn;
		this.lastName = ln;
		this.logInID = logInID;
		this.password = password;
		this.ssn = ssn;
	}
	//QUERIES
	public String getFirstName(){
		return this.firstName;
	}
	public String getLastName(){
		return this.lastName;
	}
	public String getName(){
		String temp = this.firstName;
		temp.concat(" ");
		temp.concat(this.lastName);
		return temp;
	}
	public String getLogInID(){
		return this.logInID;
	}
	public String getPassword(){
		return this.password;
	}
	public float getSSN(){
		return this.ssn;
	}
	public ContactInformation getContactInfo(){
		return this.contactInfo;
	}
	
	//COMMANDS
	public void setFirstName(String n){
		this.firstName = n;
	}
	public void setLastName(String n){
		this.lastName = n;
	}
	public void setLogInID(String n){
		this.logInID = n;
	}
	public void setPassword(String n){
		this.password = n;
	}
	public void setSSN(float n){
		this.ssn = n;
	}
	public void setContactInfo(ContactInformation ci){
		this.contactInfo = ci;
	}
}