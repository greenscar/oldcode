import java.io.*;
import java.awt.*;
import java.applet.*;
import java.util.*;
import java.io.*;
import java.net.*;
public class screenTenant extends java.awt.Frame {
    
	String home = "127.0.0.1";
	int port = 6669;
	Socket s = null;
	String serverResponse = null;

    /** Creates new form screenTenant */
    public screenTenant() {
        initComponents ();
    }

    /** This method is called from within the init() method to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the FormEditor.
     */
    private void initComponents() {//GEN-BEGIN:initComponents
        button1 = new java.awt.Button();
        button2 = new java.awt.Button();
        button3 = new java.awt.Button();
        setLayout(new java.awt.GridLayout(3, 1));
        setTitle("Tenant Screen");
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                closeDialog(evt);
            }
        }
        );
        
        button1.setFont(new java.awt.Font ("Agency FB", 0, 10));
        button1.setLabel("Pay Bill");
        button1.setName("button3");
        button1.setBackground(java.awt.Color.lightGray);
        button1.setForeground(java.awt.Color.black);
        button1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button1ActionPerformed(evt);
            }
        }
        );
        
        add(button1);
        
        
        button2.setFont(new java.awt.Font ("Agency FB", 0, 10));
        button2.setLabel("Request Maintenance");
        button2.setName("button4");
        button2.setBackground(java.awt.Color.lightGray);
        button2.setForeground(java.awt.Color.black);
        button2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button2ActionPerformed(evt);
            }
        }
        );
        
        add(button2);
        
        
        button3.setFont(new java.awt.Font ("Agency FB", 0, 10));
        button3.setLabel("Log Out");
        button3.setName("button5");
        button3.setBackground(java.awt.Color.lightGray);
        button3.setForeground(java.awt.Color.black);
        button3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                button3ActionPerformed(evt);
            }
        }
        );
        
        add(button3);
        
        //pack();
        java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
        java.awt.Dimension dialogSize = getSize();
        setSize(new java.awt.Dimension(300, 200));
        setLocation((screenSize.width-300)/2,(screenSize.height-200)/2);
    }//GEN-END:initComponents

  private void button1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button1ActionPerformed
        new screenPayBill(this, true).show();
  }//GEN-LAST:event_button1ActionPerformed

  private void button2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button2ActionPerformed
        new screenRequestMaintenance(this, true).show();        
  }//GEN-LAST:event_button2ActionPerformed

  private void button3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button3ActionPerformed
        setVisible (false);
        dispose ();
      // Add your handling code here:
  }//GEN-LAST:event_button3ActionPerformed

  
    /** Closes the dialog */
    private void closeDialog(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_closeDialog
        setVisible (false);
        dispose ();
    }//GEN-LAST:event_closeDialog
   
	//STUFF THE CUSTOMER WILL DO	
	protected void payFees(int custNum, float amount)
	{
  	Socket s = null;
  	String serverResponse = null;
  	Vector reportVector = new Vector();
  	try{
  		System.out.println("Opening socket connection");
  		s = new Socket(home, port);
  		System.out.println("Socket connection established.");
  		PrintStream os = new PrintStream(s.getOutputStream());
  		DataInputStream is = new DataInputStream(s.getInputStream());
  		String cust = String.valueOf(custNum);
		String amt = String.valueOf(amount);
		System.out.println("Sending pay fees to server");
		System.out.println("Sending customer number "+cust);
		System.out.println("Sending amount $"+amt);
		os.print("PAYBILL\n");
  		os.print(cust + "\n");
		os.print(amt + "\n");
		if(s != null) s.close();
	}
	catch(Exception e){System.out.println("Error" + e);}
	}
	protected void requestMaintenance(Vector v)
	{
  		Socket s = null;
  		String serverResponse = null;
  		Vector reportVector = new Vector();
  		try{
  			System.out.println("Opening socket connection");
  			s = new Socket(home, port);
  			System.out.println("Socket connection established.");
  			PrintStream os = new PrintStream(s.getOutputStream());
  			DataInputStream is = new DataInputStream(s.getInputStream());
  			os.print("REQMAINT\n");
			System.out.println("Sending request maintenance to server");
			for(int i = 0; i < v.size(); i ++)
			{
				os.print((String)v.elementAt(i)+"\n");
			   System.out.println((String)v.elementAt(i)+"\n");
				}
			if(s != null) s.close();
  		}
  		catch(Exception e){System.out.println("Error" + e);}
	}
    /**
    * @param args the command line arguments
    */
    public static void main (String args[]) {
        new screenTenant().show ();
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private java.awt.Button button1;
    private java.awt.Button button2;
    private java.awt.Button button3;
    // End of variables declaration//GEN-END:variables

}