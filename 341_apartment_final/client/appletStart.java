
import java.applet.*;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import javax.swing.JOptionPane;

public class appletStart extends Applet implements ActionListener
{
   private Button loginBtn = new Button("Login");
	private Button visitorBtn = new Button("Visitor");
	private TextField lnTF = new TextField("",20);
	private TextField passTF = new TextField("",20);

   public void init()
   {
      setSize(300,200);
		loginBtn.addActionListener(this);
      visitorBtn.addActionListener(this);
      add(loginBtn);
      add(visitorBtn);
		add(lnTF);
		add(passTF);
   }

//
// This places the objects on the frame in a specific location.
//
   public void paint(Graphics g)
   {
       g.drawString("Login to the Apartment System",50,60);
       g.drawString("LoginName",20,90);
       g.drawString("Password",20,125);
		 lnTF.setLocation(100,75);
		 passTF.setLocation(100,110);
		 visitorBtn.setLocation(70,150);
       loginBtn.setLocation(170,150);
   } // end paint

	public void actionPerformed(ActionEvent a)
	{
		 if (a.getSource() == loginBtn)
		 {	
		 	try{
        		Socket theSocket = new Socket("127.0.0.1",6669);
				PrintStream outs = new PrintStream(theSocket.getOutputStream());
				BufferedReader inps = new BufferedReader(new InputStreamReader(theSocket.getInputStream()));
   				String LN = lnTF.getText();
				String PS = passTF.getText();
				System.out.println("Keyed In L:P =>"+ LN+" "+PS);
   				if(! (LN.equals("")))
     			{
					outs.print("LOGIN\n");
					outs.print(LN + "\n");
					System.out.println("appletStart sent login:"+ LN);
					if (PS.equals(""))
					{
						PS = "no";
					}
					outs.print(PS + "\n");
					System.out.println("appletStart sent password:"+ PS);
       				String response=inps.readLine();
					System.out.println("appletStart responce " + response);
        			if (response.equals("manager"))
        			{
						screenMgr m = new screenMgr();
					    m.show();
					}
					else
					{
						if (response.equals("tenant"))
						{
							screenTenant t = new screenTenant();
							t.show();
						}
						else
						{
							System.out.println("about to show bad login button");
							JOptionPane.showMessageDialog(null, "Bad Login and Password", "Error", JOptionPane.PLAIN_MESSAGE);
							System.out.println("Completed showing bad login button");
						}
						
					}
				}
				else
				{
            		JOptionPane.showMessageDialog(null, "Please Enter A Login Name", "Error", JOptionPane.PLAIN_MESSAGE);
        		}
				System.out.println("appletStart closing socket");
 				theSocket.close();
				lnTF.setText("");
				passTF.setText("");
			}
			catch (IOException e)
			{
			   JOptionPane.showMessageDialog(null, "Error: Connection with Server", "Error", JOptionPane.PLAIN_MESSAGE);
			}
		} // end Login

  	 	if (a.getSource() == visitorBtn)
		{	
       		screenVisitor v = new screenVisitor();
       		v.show();
	 	}       
   	}
}
