import java.util.*;
public class MaintenanceReport implements java.io.Serializable
{
	private Person creator;
	private Apartment apartment;
	private float dateFiled;
	private boolean done, bedRoom, bathRoom, livingRoom, diningRoom, water;
	private boolean electrical, gas, floor, wall, outside, ceiling;
	
	public MaintenanceReport(Vector vect){
		this.creator = (Person)vect.elementAt(0);
		this.apartment = (Apartment)vect.elementAt(1);
		this.dateFiled = ((Float)vect.elementAt(2)).floatValue();
		this.bedRoom = ((Boolean)vect.elementAt(3)).booleanValue(); 
		this.bathRoom= ((Boolean)vect.elementAt(4)).booleanValue(); 
		this.livingRoom= ((Boolean)vect.elementAt(5)).booleanValue(); 
		this.diningRoom= ((Boolean)vect.elementAt(6)).booleanValue(); 
		this.water= ((Boolean)vect.elementAt(7)).booleanValue(); 
		this.electrical= ((Boolean)vect.elementAt(8)).booleanValue(); 
		this.gas= ((Boolean)vect.elementAt(9)).booleanValue(); 
		this.floor= ((Boolean)vect.elementAt(10)).booleanValue(); 
		this.wall= ((Boolean)vect.elementAt(11)).booleanValue(); 
		this.outside= ((Boolean)vect.elementAt(12)).booleanValue(); 
		this.ceiling= ((Boolean)vect.elementAt(13)).booleanValue(); 
	}
	
	public Person getRequestor(){
		return this.creator;
	}
	public float getDateFiled(){
		return this.dateFiled;
	}
	public Apartment getApartment(){
		return this.apartment;
	}
	public String getRequestedWork(){
		String temp = new String();
		if(bedRoom)  	temp.concat("Bedroom\n");
		if(bathRoom)	temp.concat("Bathroom\n");
		if(livingRoom)	temp.concat("Living Room\n");
		if(diningRoom)	temp.concat("Dining Room\n");
		if(water)		temp.concat("Water\n");
		if(electrical)	temp.concat("Electrical\n");
		if(gas)			temp.concat("Gas\n");
		if(floor)		temp.concat("Floor\n"); 
		if(wall)		temp.concat("Wall\n"); 
		if(ceiling)		temp.concat("Ceiling\n"); 
		if(outside)		temp.concat("Outside\n"); 
		return temp;
	}		
	public void setDone(){
		this.done = true;
	}
	public void setBedRoom(){
		this.bedRoom = true;
	}
	public void setLivingRoom(){
		this.livingRoom = true;
	}
	public void setDiningRoom(){
		this.diningRoom = true;
	}
	public void setWater(){
		this.water = true;
	}
	public void setElectrical(){
		this.electrical = true;
	}
	public void setGas(){
		this.gas = true;
	}
	public void setFloor(){
		this.floor = true;
	}
	public void setWall(){
		this.wall = true;
	}
	public void setCeiling(){
		this.ceiling = true;
	}
	public void setOutside(){
		this.outside = true;
	}
}
	
	
	
	