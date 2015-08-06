import java.io.*;
import java.awt.*;
import java.applet.*;
import java.util.*;
import java.io.*;
import java.net.*;
public class screenAddApt extends java.awt.Dialog {
    
    screenMgr managerMenu;
    /** Creates new form screenAddApt */
    public screenAddApt(java.awt.Frame parent,boolean modal) {
        super (parent, modal);
        managerMenu = (screenMgr)parent;
        initComponents ();
    }

    /** This method is called from within the init() method to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the FormEditor.
     */
    private void initComponents() {//GEN-BEGIN:initComponents
        rentLabel = new java.awt.Label();
		label1 = new java.awt.Label();
        panel1 = new java.awt.Panel();
        label2 = new java.awt.Label();
		rentField = new java.awt.TextField();
        textField1 = new java.awt.TextField();
        label3 = new java.awt.Label();
        textField2 = new java.awt.TextField();
        label4 = new java.awt.Label();
        textField3 = new java.awt.TextField();
        label5 = new java.awt.Label();
        textField4 = new java.awt.TextField();
        checkbox1 = new java.awt.Checkbox();
        checkbox2 = new java.awt.Checkbox();
        checkbox3 = new java.awt.Checkbox();
        checkbox4 = new java.awt.Checkbox();
        checkbox5 = new java.awt.Checkbox();
        panel2 = new java.awt.Panel();
        panel3 = new java.awt.Panel();
        checkbox6 = new java.awt.Checkbox();
        panel4 = new java.awt.Panel();
        button5 = new java.awt.Button();
        button6 = new java.awt.Button();
        panel5 = new java.awt.Panel();
        setLayout(new java.awt.BorderLayout());
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                closeDialog(evt);
            }
        }
        );
        
        label1.setFont(new java.awt.Font ("Dialog", 0, 11));
        label1.setName("label5");
        label1.setBackground(new java.awt.Color (204, 204, 204));
        label1.setForeground(java.awt.Color.black);
        label1.setText("Add Apartment");
        label1.setAlignment(java.awt.Label.CENTER);
        
        add(label1, java.awt.BorderLayout.NORTH);
        
        
        panel1.setLayout(new java.awt.GridLayout(5, 4));
        panel1.setFont(new java.awt.Font ("Dialog", 0, 11));
        panel1.setName("panel1");
        panel1.setBackground(new java.awt.Color (204, 204, 204));
        panel1.setForeground(java.awt.Color.black);
        
        label2.setFont(new java.awt.Font ("Dialog", 0, 11));
          label2.setName("label2");
          label2.setBackground(new java.awt.Color (204, 204, 204));
          label2.setForeground(java.awt.Color.black);
          label2.setText("Floor");
          panel1.add(label2);
          
          
        textField1.setBackground(java.awt.Color.white);
          textField1.setName("textfield1");
          textField1.setFont(new java.awt.Font ("Dialog", 0, 11));
          textField1.setForeground(java.awt.Color.black);
          panel1.add(textField1);
          
          
        label3.setFont(new java.awt.Font ("Dialog", 0, 11));
          label3.setName("label3");
          label3.setBackground(new java.awt.Color (204, 204, 204));
          label3.setForeground(java.awt.Color.black);
          label3.setText("# bedrooms");
          panel1.add(label3);
          
          
        textField2.setBackground(java.awt.Color.white);
          textField2.setName("textfield2");
          textField2.setFont(new java.awt.Font ("Dialog", 0, 11));
          textField2.setForeground(java.awt.Color.black);
          panel1.add(textField2);
          
          
        label4.setFont(new java.awt.Font ("Dialog", 0, 11));
          label4.setName("label4");
          label4.setBackground(new java.awt.Color (204, 204, 204));
          label4.setForeground(java.awt.Color.black);
          label4.setText("# bathrooms");
          panel1.add(label4);
          
          
        textField3.setBackground(java.awt.Color.white);
          textField3.setName("textfield3");
          textField3.setFont(new java.awt.Font ("Dialog", 0, 11));
          textField3.setForeground(java.awt.Color.black);
          panel1.add(textField3);
          
          
        label5.setFont(new java.awt.Font ("Dialog", 0, 11));
          label5.setName("label5");
          label5.setBackground(new java.awt.Color (204, 204, 204));
          label5.setForeground(java.awt.Color.black);
          label5.setText("Square feet");
          panel1.add(label5);
          
          
        textField4.setBackground(java.awt.Color.white);
          textField4.setName("textfield4");
          textField4.setFont(new java.awt.Font ("Dialog", 0, 11));
          textField4.setForeground(java.awt.Color.black);
          panel1.add(textField4);
          
          
        checkbox1.setBackground(new java.awt.Color (204, 204, 204));
          checkbox1.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox1.setForeground(java.awt.Color.black);
          checkbox1.setLabel("Walk-In Closets");
          panel1.add(checkbox1);
          
          
        checkbox2.setBackground(new java.awt.Color (204, 204, 204));
          checkbox2.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox2.setForeground(java.awt.Color.black);
          checkbox2.setLabel("Dishwasher");
          panel1.add(checkbox2);
          
          
        checkbox3.setBackground(new java.awt.Color (204, 204, 204));
          checkbox3.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox3.setForeground(java.awt.Color.black);
          checkbox3.setLabel("Washer/Dryer");
          panel1.add(checkbox3);
          
          
        checkbox4.setBackground(new java.awt.Color (204, 204, 204));
          checkbox4.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox4.setForeground(java.awt.Color.black);
          checkbox4.setLabel("Patio");
          panel1.add(checkbox4);
          
          
        checkbox5.setBackground(new java.awt.Color (204, 204, 204));
          checkbox5.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox5.setForeground(java.awt.Color.black);
          checkbox5.setLabel("Fireplace");
          panel1.add(checkbox5);
          
          
      
        rentLabel.setFont(new java.awt.Font ("Dialog", 0, 11));
          rentLabel.setName("label5");
          rentLabel.setBackground(new java.awt.Color (204, 204, 204));
          rentLabel.setForeground(java.awt.Color.black);
          rentLabel.setText("Rent $");
          panel1.add(rentLabel);
          
          
        rentField.setBackground(java.awt.Color.white);
          rentField.setName("rent");
          rentField.setFont(new java.awt.Font ("Dialog", 0, 11));
          rentField.setForeground(java.awt.Color.black);
          panel1.add(rentField);
          
          
        checkbox6.setBackground(new java.awt.Color (204, 204, 204));
          checkbox6.setFont(new java.awt.Font ("Dialog", 0, 11));
          checkbox6.setForeground(java.awt.Color.black);
          checkbox6.setLabel("Covered Parking");
          panel1.add(checkbox6);
          
          
        panel4.setFont(new java.awt.Font ("Dialog", 0, 11));
          panel4.setName("panel4");
          panel4.setBackground(new java.awt.Color (204, 204, 204));
          panel4.setForeground(java.awt.Color.black);
          panel1.add(panel4);
          
          
        button5.setFont(new java.awt.Font ("Dialog", 0, 11));
          button5.setLabel("Add");
          button5.setName("button5");
          button5.setBackground(java.awt.Color.lightGray);
          button5.setForeground(java.awt.Color.black);
          button5.addActionListener(new java.awt.event.ActionListener() {
              public void actionPerformed(java.awt.event.ActionEvent evt) {
                  button5ActionPerformed(evt);
              }
          }
          );
          panel1.add(button5);
          
          
        button6.setFont(new java.awt.Font ("Dialog", 0, 11));
          button6.setLabel("Cancel");
          button6.setName("button6");
          button6.setBackground(java.awt.Color.lightGray);
          button6.setForeground(java.awt.Color.black);
          button6.addActionListener(new java.awt.event.ActionListener() {
              public void actionPerformed(java.awt.event.ActionEvent evt) {
                  button6ActionPerformed(evt);
              }
          }
          );
          panel1.add(button6);
          
          
        panel5.setFont(new java.awt.Font ("Dialog", 0, 11));
          panel5.setName("panel5");
          panel5.setBackground(new java.awt.Color (204, 204, 204));
          panel5.setForeground(java.awt.Color.black);
          panel1.add(panel5);
          
          
        add(panel1, java.awt.BorderLayout.CENTER);
        
        //pack();
        java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
        java.awt.Dimension dialogSize = getSize();
        setSize(new java.awt.Dimension(400, 200));
        setLocation((screenSize.width-300)/2,(screenSize.height-200)/2);
    }//GEN-END:initComponents

  private void button5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button5ActionPerformed
    Vector v = new Vector();
    v.add(textField1.getText());
    v.add(textField2.getText());
    v.add(textField3.getText());
    v.add(textField4.getText());
    Boolean bo = new Boolean(checkbox1.getState());
    v.add((bo.toString()));
    bo = new Boolean(checkbox2.getState());
    v.add((bo.toString()));
    bo = new Boolean(checkbox3.getState());
    v.add((bo.toString()));
    bo = new Boolean(checkbox4.getState());
    v.add((bo.toString()));
    bo = new Boolean(checkbox5.getState());
    v.add((bo.toString()));
    bo = new Boolean(checkbox6.getState());
    v.add((bo.toString()));
	v.add(rentField.getText());
    managerMenu.createNewApt(v);
    setVisible (false);
    dispose ();
  }//GEN-LAST:event_button5ActionPerformed

  private void button6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_button6ActionPerformed
  setVisible (false);
  dispose ();
 
  }//GEN-LAST:event_button6ActionPerformed

    /** Closes the dialog */
    private void closeDialog(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_closeDialog
        setVisible (false);
        dispose ();
    }//GEN-LAST:event_closeDialog


    // Variables declaration - do not modify//GEN-BEGIN:variables
	private java.awt.Label rentLabel;
    private java.awt.Label label1;
    private java.awt.Panel panel1;
    private java.awt.Label label2;
	private java.awt.TextField rentField;
    private java.awt.TextField textField1;
    private java.awt.Label label3;
    private java.awt.TextField textField2;
    private java.awt.Label label4;
    private java.awt.TextField textField3;
    private java.awt.Label label5;
    private java.awt.TextField textField4;
    private java.awt.Checkbox checkbox1;
    private java.awt.Checkbox checkbox2;
    private java.awt.Checkbox checkbox3;
    private java.awt.Checkbox checkbox4;
    private java.awt.Checkbox checkbox5;
    private java.awt.Panel panel2;
    private java.awt.Panel panel3;
    private java.awt.Checkbox checkbox6;
    private java.awt.Panel panel4;
    private java.awt.Button button5;
    private java.awt.Button button6;
    private java.awt.Panel panel5;
    // End of variables declaration//GEN-END:variables

}