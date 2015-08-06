import java.io.*;
import java.net.*;
import java.util.*;
import java.awt.*;
/**
 * THE Manager RETURNS NOTHING BUT PERSON AND VECTOR INSTANCES
 */

public class Manager extends Employee{
	public  Vector apartmentList = new Vector();
	public Vector pastTenents = new Vector();
	public Vector maintenanceReports = new Vector();
	public Vector tenentVect = new Vector();
	public String sp = " ";

	//private Connection conn = null;
	public Manager(String fn, String ln, float ssn, String logInID, 
					String password,ContactInformation ci,
					float wage, float hiringDate){
		super(fn, ln, ssn, logInID, password, ci, wage, hiringDate);
		apartmentList = new Vector();
		pastTenents = new Vector();
	}
	
	/**************************
	 * addApt();              *
	 **************************/
	public void addApartment(Vector features){
		//System.out.println("Manager.addApartment()");
		Integer i = new Integer(apartmentList.size()+1);
		boolean b;
		System.out.println("i="+i);
		if (i.intValue() == 0)
		{
			b = features.add(new Integer(1));
		}
		else
		{
			b = features.add(i);
		}
		System.out.println("Manager adding apt");
		//System.out.println("features.elementAt("+(k)+")= "+newFeatures.elementAt(k));
		Apartment temp = new Apartment(features);
		//System.out.println("The new Apts #="+temp.aptNumber());
		b = this.apartmentList.add(temp);
	}

	
	public void createTenent(Vector person)
	{
		String firstName = ((String)person.elementAt(0));
		String lastName  = ((String)person.elementAt(1));
		float  ssn       = Float.parseFloat((String)person.elementAt(2));
		String logInID	 = ((String)person.elementAt(3));
		String password  = ((String)person.elementAt(4));
		String street  	 = ((String)person.elementAt(5));
		int aptNum 		 = Integer.parseInt((String)person.elementAt(6));
		String city	 	 = "Metairie";
		String state	 = "LA";
		float zip		 = 77705;
		float phone		 = Float.parseFloat((String)person.elementAt(7));
		ContactInformation ci = 
			new ContactInformation(street, aptNum, city, state, zip, phone);
	
		Tenent t = new Tenent(firstName, lastName, ssn, logInID, password, ci);
		tenentVect.add(t);
		Apartment a = (Apartment)apartmentList.elementAt(aptNum-1);
		a.rentOut(t);

	}
	
	public Tenent getTenentForApartment(int aptNum)
	{
		return ((Apartment)apartmentList.get(aptNum)).getTenent();
	}
	public Vector getTenentVector(){
		return this.tenentVect;
	}
	//THE VECTOR LOCATION + 1 IS THE APARTMENT NUMBER
	public Vector getAllTenents(){
		return tenentVect;
	}
	
	public Vector getAvailableApts(){
		Vector temp = new Vector();
		for(int i = 0; i < apartmentList.size(); i++){
			Apartment a = (Apartment)apartmentList.get(i);
			if (!(a.isRentedOut())){
				temp.add(a);
			}
		}
		return temp;
	}
		
	public Vector getAptsWithFeatures(Vector features)
	{
		System.out.println("Manager.getAptsWithFeatures:");
		for(int i = 0; i < features.size(); i++)
		{
			System.out.println(i+": "+features.elementAt(i));
		}
		Vector tempList = new Vector();
		Apartment tempA;
		Boolean temp;
		int floor = 			Integer.parseInt((String)features.elementAt(0));
		int numBdRms = 			Integer.parseInt((String)features.elementAt(1));
		float numBthRms = 		Float.parseFloat((String)features.elementAt(2));
		int minSqFt = 			Integer.parseInt((String)features.elementAt(3));
		temp = Boolean.valueOf((String)features.elementAt(4));
		boolean walkInClosets = temp.booleanValue();
		temp = Boolean.valueOf((String)features.elementAt(5));
		boolean dishwasher = temp.booleanValue();
		temp = Boolean.valueOf((String)features.elementAt(6));
		boolean washDryer = temp.booleanValue();
		temp = Boolean.valueOf((String)features.elementAt(7));
		boolean patio = temp.booleanValue();
		temp = Boolean.valueOf((String)features.elementAt(8));
		boolean fireplace = temp.booleanValue();
		temp = Boolean.valueOf((String)features.elementAt(9));
		boolean covPark = temp.booleanValue();
		System.out.println("features assigned");
		tempList = apartmentList;
		if (floor != -1){
			for(int i = 0; i < apartmentList.size(); i++){
				tempA = (Apartment)apartmentList.get(i);
				if (tempA.floor() != floor){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (numBdRms != -1){
			for(int i = 0; i < apartmentList.size(); i++){
				tempA = (Apartment)apartmentList.get(i);
				if (tempA.numBedRooms() != numBdRms){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}	
		if (numBthRms != -1){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (tempA.numBathRooms() != numBdRms){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (minSqFt != -1){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (tempA.size() < minSqFt){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (walkInClosets == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (tempA.size() < minSqFt){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (dishwasher == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (tempA.size() < minSqFt){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (washDryer == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (!tempA.hasWasherDryer()){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (patio == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (!tempA.hasPatio()){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (fireplace == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (!tempA.hasFireplace()){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		if (covPark == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (!tempA.hasCoveredParking()){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}				
		if (walkInClosets == true){
			for(int i = 0; i < tempList.size(); i++){
				tempA = (Apartment)tempList.get(i);
				if (!tempA.hasWalkInClosets()){
					tempA = (Apartment)tempList.remove(i);
				}
			}
		}
		System.out.println("Manager sending searched Vector back");
		return tempList;			 
	}
	/*
	 * To rentAptOut, call createTenent and then pass that as an argument
	 */
	public void rentAptOut(int aptNum, int CustNum)
	{
		Tenent t = (Tenent)(tenentVect.elementAt(CustNum));
		Apartment a = (Apartment)apartmentList.elementAt(aptNum);
		a.rentOut(t);
	}
	
	public void setAptAvailable(int aptNum)
	{		
		pastTenents.add(((Apartment)apartmentList.get(aptNum)).getTenent());
		((Apartment)apartmentList.get(aptNum)).setAvailable();
	}
	
	
	public void requestMaintenance(Vector requests){
		MaintenanceReport mr = new MaintenanceReport(requests);
		maintenanceReports.add(mr);
	}					   
	
	public Vector listMaintenanceRequests()
	{
		return maintenanceReports;
	}
	
	public void chargeFees(int custNum, float amt){
		((Customer)(tenentVect.elementAt(custNum))).chargeAccount(amt);
	}	
	public void creditAccount(int custNum, float amt){
		((Customer)(tenentVect.elementAt(custNum))).creditAccount(amt);
		//c.creditAccount(amt);
	}	
}
			
	
