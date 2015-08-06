/*
 * THE APARTMENT NUMBER IS THE VECTOR LOCATION + 1.
 */
import java.util.*;
public class Apartment implements java.io.Serializable
{
	private Tenent currentTenent;
	private int numBedRooms, floor, squareFeet, number;
	private float numBathRooms, rentCost;
	private boolean walkInClosets, dishwasher, washerDryer, patio;
	private boolean fireplace, coveredParking, rented = false;
	Boolean temp;
	//CONSTRUCTOR
	public Apartment(Vector apartment){
		this.floor = Integer.parseInt((String)apartment.elementAt(0));
		this.numBedRooms = Integer.parseInt((String)apartment.elementAt(1));
		this.numBathRooms = Float.parseFloat((String)apartment.elementAt(2));
		this.squareFeet = Integer.parseInt((String)apartment.elementAt(3));
		temp = Boolean.valueOf((String)apartment.elementAt(4));
		this.walkInClosets = temp.booleanValue();
		temp = Boolean.valueOf((String)apartment.elementAt(5));
		this.dishwasher = temp.booleanValue();
		temp = Boolean.valueOf((String)apartment.elementAt(6));
		this.washerDryer  = temp.booleanValue();
		temp = Boolean.valueOf((String)apartment.elementAt(7));
		this.patio = temp.booleanValue();
		temp = Boolean.valueOf((String)apartment.elementAt(8));
		this.fireplace = temp.booleanValue();
		temp = Boolean.valueOf((String)apartment.elementAt(9));
		this.coveredParking = temp.booleanValue();
		this.rentCost = Float.parseFloat((String)apartment.elementAt(10));
		System.out.println(apartment.elementAt(11));
		this.number = ((Integer)apartment.elementAt(11)).intValue();
	//	this.number = Integer.parseInt((String)apartment.elementAt(11));
	}
	
	//QUERIES	
	public int aptNumber(){
		return this.number;
	}
	public Tenent getTenent(){
		return currentTenent;
	}
	public int floor(){
		return this.floor;
	}
	public int size(){
		return this.squareFeet;
	}
	public int numBedRooms(){
		return this.numBedRooms;
	}
	public float numBathRooms(){
		return this.numBathRooms;
	}
	public float cost(){
		return this.rentCost;
	}
	public boolean isRentedOut(){
		return this.rented;
	}
	public boolean hasFireplace(){
		return this.fireplace;
	}
	public boolean hasPatio(){
		return this.patio;
	}
	public boolean hasWasherDryer(){
		return this.washerDryer;
	}
	public boolean hasDishwasher(){
		return this.dishwasher;
	}
	public boolean hasWalkInClosets(){
		return this.walkInClosets;
	}
	public boolean hasCoveredParking(){
		return this.coveredParking;
	}
	//COMMANDS
	public void rentOut(Tenent t){
		this.currentTenent = t;
		System.out.println("rentOut "+this.rented+" "+this.number);
		this.rented = true;
	}
	public void setAvailable(){
		this.currentTenent = null;
		this.rented = false;
	}
	public void setCost(float f){
		this.rentCost = f;
	}
}
	
	