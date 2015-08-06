import java.io.*;
import java.awt.*;
import java.applet.*;
import java.util.*;
import java.io.*;
import java.net.*;
public class screenPayBill extends java.awt.Dialog {

    screenTenant tenentScreen;
    /** Creates new form screenPayBill */
    public screenPayBill(java.awt.Frame parent,boolean modal) {
        super (parent, modal);
        tenentScreen = (screenTenant)parent;
        initComponents ();
        pack ();
    }

    /** This method is called from within the init() method to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the FormEditor.
     */
    private void initComponents() {//GEN-BEGIN:initComponents
        panel1 = new java.awt.Panel();
        label2 = new java.awt.Label();
        textField1 = new java.awt.TextField();
        button1 = new java.awt.Button();
        button2 = new java.awt.Button();
        setLayout(new java.awt.BorderLayout());
        setTitle("Pay Bill");
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                closeDialog(evt);
            }
        }
        );
        
        panel1.setLayout(new java.awt.GridLayout(2, 2));
        panel1.setFont(new java.awt.Font ("Dialog", 0, 11));
        panel1.setName("panel1");
        panel1.setBackground(new java.awt.Color (204, 204, 204));
        panel1.setForeground(java.awt.Color.black);
        
        label2.setFont(new java.awt.Font ("Dialog", 0, 11));
          label2.setName("label2");
          label2.setBackground(new java.awt.Color (204, 204, 204));
          label2.setForeground(java.awt.Color.black);
          label2.setText("Amount To Pay");
          panel1.add(label2);
          
          
        textField1.setBackground(java.awt.Color.white);
          textField1.setName("textfield1");
          textField1.setFont(new java.awt.Font ("Dialog", 0, 11));
          textField1.setForeground(java.awt.Color.black);
          textField1.addActionListener(new java.awt.event.ActionListener() {
              public void actionPerformed(java.awt.event.ActionEvent evt) {
                  textField1ActionPerformed(evt);
              }
          }
          );
          panel1.add(textField1);
          
          
        button1.setFont(new java.awt.Font ("Dialog", 0, 11));
          button1.setLabel("Back");
          button1.setBackground(java.awt.Color.lightGray);
          button1.setForeground(java.awt.Color.black);
          button1.addActionListener(new java.awt.event.ActionListener() {
              public void actionPerformed(java.awt.event.ActionEvent evt) {
                  button1ActionPerformed(evt);
              }
          }
          );
          panel1.add(button1);
          
          
        button2.setFont(new java.awt.Font ("Dialog", 0, 11));
          button2.setLabel("Submit");
          button2.setBackground(java.awt.Color.lightGray);
          button2.setForeground(java.awt.Color.black);
          button2.addActionListener(new java.awt.event.ActionListener() {
              public void actionPerformed(java.awt.event.ActionEvent evt) {
                  button2ActionPerformed(evt);
              }
          }
          );
          panel1.add(button2);
          
          
        add(panel1, java.awt.BorderLayout.CENTER);
         java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
        java.awt.Dimension dialogSize = getSize();
        setSize(new java.awt.Dimension(300, 200));
        setLocation((screenSize.width-300)/2,(screenSize.height-200)/2);
    }//GEN-END:initComponents

  private void textField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_textField1ActionPerformed
// Add your handling code here:
  }//GEN-LAST:event_textField1ActionPerformed

  private void button2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button2ActionPerformed
String Amount = textField1.getText();
      // Add your handling code here:
  }//GEN-LAST:event_button2ActionPerformed

  private void button1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button1ActionPerformed
 setVisible (false);
        dispose ();
      // Add your handling code here:
  }//GEN-LAST:event_button1ActionPerformed

    /** Closes the dialog */
    private void closeDialog(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_closeDialog
        setVisible (false);
        dispose ();
    }//GEN-LAST:event_closeDialog

    /**
    * @param args the command line arguments
    */
    public static void main (String args[]) {
        new screenPayBill (new java.awt.Frame (), true).show ();
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private java.awt.Panel panel1;
    private java.awt.Label label2;
    private java.awt.TextField textField1;
    private java.awt.Button button1;
    private java.awt.Button button2;
    // End of variables declaration//GEN-END:variables

}
