//   Movie System Project
//   ACS 341
//   04/25/2001   
//   
//   Description: This is theThread class. TheThread class is used
//		  to accept the Socket and send it to the right actions.
//
//

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;


public class theThread1 extends Thread
{
   private boolean success;
   private AptOffice thisOffice;
   private Socket client = null;
   private ServerSocket theServer = null; 
   int i;

   public theThread1 ()
   {
		thisOffice = new AptOffice();
		//System.out.println("The managers l:p = " + thisManager.getLogInID()+"/"+thisManager.getPassword()); 
   }

   public void run()
   {
        System.out.println("In Thread (waiting for message)...");
	try
        {
            theServer = new ServerSocket(6669);

            while(true)
            {
                client = theServer.accept();

                System.out.println("Accepted connection");

		theThread2 st1 = new theThread2(client, thisOffice);
	        st1.start();
	    }
        } // end try
        catch(IOException ex)
        {
            System.out.println("Server exiting...");
        } // end catch

   }
}
