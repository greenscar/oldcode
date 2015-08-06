public class Employee extends Person implements java.io.Serializable
{
	float salary;
	float dateHired;
	String employeeID;
	public Employee(String fn, String ln, float ssn, String logInID, 
					String password,ContactInformation ci,
					float wage, float hiringDate){
		super(fn, ln, ssn, logInID, password, ci);
		this.salary = wage;
		this.dateHired = hiringDate;
		this.employeeID = logInID;
	}
	
	public void setSalary(float newSalary){
		this.salary = newSalary;
	}
	public void setEmployeeID(String newID){
		this.employeeID = newID;
		this.setLogInID(newID);
	}
	public float getSalary(){		
		return this.salary;
	}
	public String getEmployeeID(){
		return this.employeeID;
	}
}
		
	