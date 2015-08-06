import java.util.*;

public Manager(
{
	Vector personList;
	public Manager()
	{
		personList = new Vector();
	}
	
	public void addPerson(String fName, String lName, String addy, String cty, 
					String st, String z, String phn, String email,
					String howIHeard, boolean onML)
	{
		personList.add(new Person(fName, lName, addy, cty, st, z, phn, email, howIHeard, onML));
	}
	
	public void removePerson(int personNum)
	{
		personList.remove(personNum);
	}
	
	public void saveList()
	{
	
		
					