//package my_MP3_lister;

/**
 * Title:        MP3 Lister
 * Description:  This program will scan your directories and list the MP3s
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author James Sandlin
 * @version 1.0
 */

import java.io.*;
import java.util.*;

public class MP3{
  	private String pathName;  	
	private String fileName;
  	//private Artist artist;
  	//private Song song;
  	private String location;
	
	public MP3(String pathname)
	{
		this.pathName = pathname;//super(pathname);
	}
	

  public String getLocation(){
    return this.location;
  }
  public String getName(){
    return this.fileName;
  }
}