//   Movie System Project
//   ACS 341
//   04/25/2001   
//   
//   Description: This is theThread2 class. TheThread class is used
//		  to implement the right actions from the socket.
//
//

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;


public class theThread2 extends Thread
{
   private Socket client = null;
   private ServerSocket theServer = null;
   private String OptAry[] = {"APTSEARCH", "REQALLAVAIL", "PAYBILL", "REQMAINT", "NEWTENENT", "NEWAPT", "CHARGEFEES", "SETAPTAVAIL", "RENTAPTOUT", "LOGIN", "REQALLTENENTS"};
   private BufferedReader inps;
   private String firstString; 
	private AptOffice thisOffice;
   int i;

   public theThread2 (Socket c, AptOffice s)
   {
	client = c;
	thisOffice = s;
   }

   public void run()
   {
	try{
	inps = new BufferedReader(new InputStreamReader(client.getInputStream()));
	
	firstString = inps.readLine();
	System.out.println("theThread2.firstString = "+firstString);
	i=0;
	while (! OptAry[i].equals(firstString))
	{
	   i++;
	}
	System.out.println("switch i = "+i);
	switch(i)
	{
	   case 0:
	   	System.out.println("theThread2 calling thisOffice.searchApts(client);");
		thisOffice.searchApts(client);
		break;
	   case 1:
	   	System.out.println("theThread2 thisOffice.reqAllAvail(client);");
		thisOffice.reqAllAvail(client);
		break;
	   case 2:
	   	System.out.println("theThread2 thisOffice.payBill(client);");
		thisOffice.payBill(client);
		break;
	   case 3:
	   	System.out.println("theThread2 thisOffice.reqMaint(client);");
		thisOffice.reqMaint(client);
		break;
	   case 4:
	   	System.out.println("theThread2 thisOffice.newTenent(client);");
		thisOffice.newTenent(client);
		break;
	   case 5:
	   	System.out.println("theThread2 thisOffice.newApt(client);");
		thisOffice.newApt(client);
		break;
	   case 6:
	   	System.out.println("theThread2 thisOffice.chargeFees(client);");
		thisOffice.chargeFees(client);
		break;
	   case 7:
	   	System.out.println("theThread2 thisOffice.setAptAvail(client);");
		thisOffice.setAptAvail(client);
		break;
	   case 8:
	   	System.out.println("theThread2 thisOffice.rentAptOut(client);");
		thisOffice.rentAptOut(client);
		break;
		case 9:
		System.out.println("theThread2 thisOffice.logUserIn(client);");
		thisOffice.logUserIn(client);
		break;
		case 10:
		System.out.println("theThread2 thisOffice.listAllTenents(client);");
		thisOffice.reqAllTenents(client);
		break;
	   default:
		System.out.println("theThread2 Did not find a match");
		break; 
		}
		}//end try

		catch(Exception e){
			System.out.println("Error in thread");

		}
   }
	public void saveManagerToDisk()
	{
		try
		{
			FileOutputStream fos = new FileOutputStream("apartment.ser");
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(thisOffice);
			oos.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	} 
}
