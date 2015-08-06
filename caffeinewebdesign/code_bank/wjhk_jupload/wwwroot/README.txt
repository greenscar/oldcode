~~~~~~~~~~~~~~~~~~~
0.0	INFORMATION
~~~~~~~~~~~~~~~~~~~
WEB SITE: http://jupload.sourceforge.net/
Version : 1.1

This applet comes with source code. I take no responsibility for any damages 
caused by the usage of this applet. Use it at your own risk!

~~~~~~~~~~~~~~~~~~~
1.0	DESCRIPTION
~~~~~~~~~~~~~~~~~~~
Traditional HTML upload forms allow you to select and upload one file at a 
time. This restriction is unacceptable when it comes to uploading thousands 
of files within a single folder. 

Java Multiple File Upload Applet (JUpload) takes care of this limited by 
allowing users to select and upload a whole directory and the files 
within it with a single click.

~~~~~~~~~~~~~~~~~~~~~~~
2.0 Self Sign Applet.
~~~~~~~~~~~~~~~~~~~~~~~
    - Generate Private/Public key set.
       keytool -genkey -alias "jupload" -validity 3600 -dname "CN=JUpload, OU=Testing/Demo, O=JUpload.SourceForge.net, L=SourceForge, S=SourceForge, C=SG"
    - List key set.
       keytool -list
    - Sign the Applet with the private key.
       jarsigner wjhk.jupload.jar jupload
    - Verify the jar file have being sign properly.
       jarsigner -verify wjhk.jupload.jar


~~~~~~~~~~~~~~~~~~~~~~
3.0	Server scripts
~~~~~~~~~~~~~~~~~~~~~~
Here's a simple JSP script to log the input into file (./pages/writeOut.jsp)
---------------------------------------------------------------------
<%@ page language="java" import="java.io.*, java.sql.*, java.util.*" %>
<%
   // This JSP will save the request Input Steam into a file.
   String fileOut = "c:/temp/writeOut.bin";
    try{
      ServletInputStream in = request.getInputStream();
      byte[] line = new byte[1024];
      int bytes = 0;

      FileOutputStream fileOutS = new  FileOutputStream(fileOut);

      while(0 <(bytes = in.read(line))){
        fileOutS.write(line,0, bytes);
      }

      fileOutS.close();
      fileOutS = null;
      out.println("SUCCESSFUL : Upload Stream Saved to \"" + fileOut + "\".");
    }catch(Exception e){
      out.println("ERROR : Exception \"" + e.getMessage() + "\" Occured.");
    }
%>
---------------------------------------------------------------------
A more sophisticated server FileUpload (Jakarta Commons FileUpload) package 
can be obtained from apache.org. How it works? Look at the parseRequest.jsp 
(./pages/parseRequest.jsp).

~~~~~~~~~~~~
4.0	FAQ:
~~~~~~~~~~~~
1) If your permissions are not setup properly the following Error messages
   will appear.

    - "File Chooser Exception: access denied (java... )"
