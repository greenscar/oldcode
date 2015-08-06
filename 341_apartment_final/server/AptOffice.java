import java.io.*;
import java.net.*;
import java.util.*;
import java.awt.*;

public class AptOffice
{
	private Manager thisManager;
	private int saveCounter = 0;
	private PrintStream outs;
	private BufferedReader inps; 
	private String sp = " ";

	public AptOffice()
	{
		thisManager = getManagerFromDisk();
	}	
	
	/**************************
	 * reqAllTenents();       *
	 **************************/
	 public Vector getAllTenents(){
		Vector tenents = new Vector();
		return tenents;
	}
	
	 public void reqAllTenents(Socket c)
	 {
	 	System.out.println("reqAllTenents");
	    try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			Vector allTenents = thisManager.getAllTenents();
			String tenInfo;
			for(int i = 0; i < thisManager.apartmentList.size(); i++){
				Apartment a = (Apartment)thisManager.apartmentList.get(i);
				System.out.println(a.isRentedOut());
				if (a.isRentedOut())
				{
					Integer anInt = new Integer(a.aptNumber());
					tenInfo = ("APT:"+ anInt+" ");
					tenInfo = tenInfo.concat("NAME: "+a.getTenent().getName()+sp);
					tenInfo = tenInfo.concat("SSN: "+a.getTenent().getSSN()+sp);
					tenInfo = tenInfo.concat("LOGIN: "+a.getTenent().getLogInID()+sp);
					System.out.println("Sending acct Info");
					outs.print(tenInfo+"\n");
				}
      		}//for(int i=0; i<apartmentList.size(); i++)
			outs.print("***\n");
			saveManagerToDisk();
		}//try
		catch(Exception e){System.out.println(e);}
	 }
	/**************************
	 * logUserIn();           *
	 **************************/
	public void logUserIn(Socket c){
		System.out.println("AptOffice logUserIn");
		try{
			String results = "bad";
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String userName = inps.readLine();
			String password = inps.readLine();
			System.out.println("Your entry.l:p = "+userName+"/"+password);
			System.out.println("thisManager.l:p = "+thisManager.getLogInID()+"/"+thisManager.getPassword());
			Vector allTenents = thisManager.getTenentVector();
			if(thisManager.getLogInID().equals(userName)){
				if(thisManager.getPassword().equals(password)){
					System.out.println("Manager Logging in");
					results = "manager";
				}
			}
			else{
				for(int i = 0; i < allTenents.size(); i++){
					Person p = ((Person)allTenents.get(i));
					if(p.getLogInID().equals(userName)){
						if((p.getPassword()).equals(password)){
							System.out.println("Tenent Logging in");
							results = "tenent";
						}
					}
				}
			}
			outs.print(results+"\n");
			System.out.println("logUserIn sent back:"+results);
		}	
	  	catch (Exception e)
	  	{
		   System.out.println("Error" + e);
		   System.out.println("Error: In Logging in");
	 	}
	}
	
	/**************************
	 * searchApts();          *
	 **************************/
	public void searchApts(Socket c){
		Vector aptSearch = new Vector();
		try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			for(int i = 0; i < 10; i++)
			{
				aptSearch.add(inps.readLine());
			}
			System.out.println("AptOffice just received search terms");
			Vector results = thisManager.getAptsWithFeatures(aptSearch);
			System.out.println("Manager has done search");
			String aptNum;
			for(int i=0; i<results.size(); i++)
			{
				Apartment aptTemp = ((Apartment)(results.elementAt(i)));
				aptNum = String.valueOf("APT NUM:"+aptTemp.aptNumber());
				aptNum = aptNum.concat(sp);
				aptNum = aptNum.concat(" FLOOR:"+String.valueOf(aptTemp.floor()));
				aptNum = aptNum.concat(sp);
				aptNum = aptNum.concat(" BEDRMS:"+String.valueOf(aptTemp.numBedRooms()));
				aptNum = aptNum.concat(sp);
				aptNum = aptNum.concat(" BTH RMS:"+String.valueOf(aptTemp.numBathRooms()));
				aptNum = aptNum.concat(sp);
				aptNum = aptNum.concat(" SQ FT:"+String.valueOf(aptTemp.size()));
				aptNum = aptNum.concat(sp);
				aptNum = aptNum.concat(" RENT:"+String.valueOf(aptTemp.cost()));
				aptNum = aptNum.concat(sp+"EXTRAS: ");
				if (aptTemp.hasFireplace())
					aptNum = aptNum.concat("Fireplace, ");
				if (aptTemp.hasPatio())
							aptNum = aptNum.concat("Patio, ");
				if (aptTemp.hasWasherDryer())
					aptNum = aptNum.concat("W/D, ");
				if (aptTemp.hasDishwasher())
					aptNum = aptNum.concat("Dishwasher, ");
				if (aptTemp.hasWalkInClosets())
					aptNum = aptNum.concat("Walk-In Closets, ");
				if (aptTemp.hasCoveredParking())
					aptNum = aptNum.concat("Covered Parking");
				System.out.println("Sending acct Info");
				outs.print(aptNum+"\n");
        	}//for(int i=0; i<results.size(); i++)
			outs.print("***\n");
		}
		catch (Exception e)
	  	{
		  	System.out.println("Error: In Add Movie");
	  	}
			saveManagerToDisk();
	}
	
	/**************************
	 * reqAllAvail();         *
	 **************************/
	public void reqAllAvail(Socket c){
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			Vector allAvailable = thisManager.getAvailableApts();
			String aptNum;
			for(int i=0; i<allAvailable.size(); i++)
			{
				Apartment tempApt = (Apartment)(allAvailable.elementAt(i));
				aptNum = "APT NUM:";
				aptNum = aptNum.concat(String.valueOf(tempApt.aptNumber()));
				aptNum = aptNum.concat(sp + " FLOOR:");
				aptNum = aptNum.concat(String.valueOf(tempApt.floor()));
				aptNum = aptNum.concat(sp+" BDRMS:");
				aptNum = aptNum.concat(String.valueOf(tempApt.numBedRooms()));
				aptNum = aptNum.concat(sp+" BTHRMS:");
				aptNum = aptNum.concat(String.valueOf(tempApt.numBathRooms()));
				aptNum = aptNum.concat(sp+" SQ FT:");
				aptNum = aptNum.concat(String.valueOf(tempApt.size()));
				aptNum = aptNum.concat(sp+" RENT $");
				aptNum = aptNum.concat(String.valueOf(tempApt.cost()));
				aptNum = aptNum.concat(sp);
				if (tempApt.hasFireplace())
						aptNum = aptNum.concat("Fireplace, ");
				if (tempApt.hasPatio())
					aptNum = aptNum.concat("Patio, ");
				if (tempApt.hasWasherDryer())
					aptNum = aptNum.concat("W/D, ");
				if (tempApt.hasDishwasher())
					aptNum = aptNum.concat("Dishwasher, ");
				if (tempApt.hasWalkInClosets())
					aptNum = aptNum.concat("Walk-In Closets, ");
				if (tempApt.hasCoveredParking())
					aptNum = aptNum.concat("Covered Parking");
				System.out.println("Sending acct Info");
				outs.print(aptNum+"\n");
      	}//for(int i=0; i<allAvailable.size(); i++)
			outs.print("***\n");
			saveManagerToDisk();
		}//try
		catch(Exception e){System.out.println(e);}
	}

	/**************************
	 * payBill();             *
	 **************************/
	public void payBill(Socket c){
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			thisManager.creditAccount(Integer.parseInt(inps.readLine()), Float.parseFloat(inps.readLine()));
	  }
	  catch (Exception e)
	  {
		   System.out.println("Error: In Add Movie");
	  }
			saveManagerToDisk();
	}
	
	/**************************
	 * reqMaint();            *
	 **************************/
	public void reqMaint(Socket c){
		Vector reqMaint = new Vector();
		try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			for(int i = 0; i < 13; i++){
				reqMaint.add(inps.readLine());
			}
			thisManager.requestMaintenance(reqMaint);	
		}
		catch (Exception e)
	  	{
		  	System.out.println("Error: In Add Movie");
	  	}
			saveManagerToDisk();
		
	}
	
	/**************************
	 * setAptAvail();         *
	 **************************/
	public void setAptAvail(Socket c){
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			thisManager.setAptAvailable(Integer.parseInt(inps.readLine()));
	  }
	  catch (Exception e)
	  {
		   System.out.println("Error: In Add Movie");
	  }
			saveManagerToDisk();
	}
	/**************************
	 * newTenent();           *
	 **************************/
	public void newTenent(Socket c){
		Vector newTen = new Vector();
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			for(int i = 0; i < 8; i ++){
				newTen.add(inps.readLine());
				System.out.println(newTen.elementAt(i));
			}
			thisManager.createTenent(newTen);
	  }
	  catch (Exception e)
	  {
	  		e.printStackTrace();
		   System.out.println("Error: In Add Tenent");
	  }
			saveManagerToDisk();
	}
	
	/**************************
	 * newApt();              *
	 **************************/
	public void newApt(Socket c){	
		Vector newApt = new Vector();
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			//start at 1 because vect location 0 will be assigned apt #
			for(int i = 1; i < 12; i ++){
				String temp = inps.readLine();
				newApt.add(temp);
			}
			thisManager.addApartment(newApt);
			System.out.println("Manager has added apartment");
	  }
	  catch (Exception e)
	  {
	  	e.printStackTrace();
		   System.out.println("Error: In Add Apartment");
	  }
			saveManagerToDisk();
	}
	
	/**************************
	 * chargeFees();          *
	 **************************/
	public void chargeFees(Socket c){
		int aptNum;
	  	float fees;
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			aptNum = Integer.parseInt(inps.readLine());
			fees = Float.parseFloat(inps.readLine());
			thisManager.chargeFees(aptNum, fees);
	  }
	  catch (Exception e)
	  {
		   System.out.println("Error: In Add Movie");
	  }
			saveManagerToDisk();
	}
	
	/**************************
	 * rentAptOut();          *
	 **************************/
	public void rentAptOut(Socket c){
		int aptNum;
		int custNum;
	   try{
			outs = new PrintStream(c.getOutputStream());
			inps = new BufferedReader(new InputStreamReader(c.getInputStream()));
			aptNum = Integer.parseInt(inps.readLine());
			custNum = Integer.parseInt(inps.readLine());
			thisManager.rentAptOut(aptNum, custNum);
	  }
	  catch (Exception e)
	  {
		   System.out.println("Error: In Add Movie");
	  }
			saveManagerToDisk();

	}



	
	public Manager getManagerFromDisk()
	{
		Manager m = null;
		try
		{
			File bankFile = new File("apartment.ser");
			if (bankFile.exists())
			{
				FileInputStream f = new FileInputStream("apartment.ser");
				ObjectInputStream s = new ObjectInputStream(f);
				m = (Manager)s.readObject();
				s.close();
			}
			else
			{
				ContactInformation conInfo = new ContactInformation("111 Elysian Fields", -1, "New Orleans", "LA", 66609, 4546363);
				m = new Manager("Frank N.", "Furter", 666778888, "x", "x", conInfo, 66609, 10311998);
				// m = new Manager(null);
			}
		}
		catch(Exception e){e.printStackTrace();}
		return m;
	}
	/*
	public Manager getManagerFromDisk()
	{
		System.out.println("getManagerFromDisk()");
		Manager m = null;
		try
		{
			File mgrFile = new File("apartment.ser");
			if (mgrFile.exists())
			{
				System.out.println("apartment.ser does exist... LOADING");
				FileInputStream f = new FileInputStream("apartment.ser");
				ObjectInputStream s = new ObjectInputStream(f);
				m = (Manager)s.readObject();
				System.out.println("The managers l:p = " + m.getLogInID()+"/"+m.getPassword()); 
				s.close();
			}
			else
			{
				ContactInformation conInfo = new ContactInformation("111 Elysian Fields", -1, "New Orleans", "LA", 66609, 4546363);
				m = new Manager("Frank N.", "Furter", 666778888, "Ralfe", "Magenta", conInfo, 66609, 10311998);
				//saveManagerToDisk();
			}
		}
		catch(Exception e){e.printStackTrace();}
		return m;	
	}
	 */	
	public void saveManagerToDisk(){
		System.out.println("saveManagerToDisk()");
		if (saveCounter++ %2 == 0)
		{
		try{
			FileOutputStream fos = new FileOutputStream("apartment.ser");
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(thisManager);
			oos.close();
		}
		catch(Exception e){e.printStackTrace();}
		}
	}

	
}