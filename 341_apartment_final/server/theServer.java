
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;

public class theServer extends Frame implements ActionListener
{
  private int flag = 0;
  private Button startstopBtn;

  public theServer()
  {
    startstopBtn = new Button("Start Server");
    startstopBtn.addActionListener(this);

    add(startstopBtn);


    setLayout(new FlowLayout());
    setSize(135, 100);
  }

  public void actionPerformed(ActionEvent a)
  {
     if(a.getSource() == startstopBtn)
     {
         if (flag == 0)
	 {
            theThread1 st1 = new theThread1();
	    flag = 1;
            startstopBtn.setLabel("Stop Server");
            st1.start();
	    repaint();
	 }
	 else
	 {
	    System.exit(0);
	 }
     }
   }

//
// This sets up the Frame by putting objects in location
//
  public void paint(Graphics g)
  {
     setTitle("The Apartment Server");
     setBackground(Color.white);
     startstopBtn.setLocation(25,50);
  }

//
// This tell the program to show the Frame
//
  public static void main(String[] args)
  {
       Frame f = new theServer();
       f.show();
  }
} // end theServer
