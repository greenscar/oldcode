//package my_mp3_lister;
/**
 * Title:        MP3 Lister
 * Description:  This program will scan your directories and list the mp3s
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author James Sandlin
 * @version 1.0
 */
import java.io.*;
import java.util.*;

public class Mp3Lister{
  	private Vector totalList = new Vector();
  	/*
  	 * This method will be called by other classes to get all
  	 * mp3s in a dir
  	 */
  	public Vector getMp3s(String directory){
  		this.makeList(directory);
		return totalList;
	}
  	/*
  	 * makeList takes a directory as an argument
  	 * and makes a Vector with all the mp3s in this dir
  	 * in totalList
  	 */
  	private void makeList(String directory){
  	  	File[] dirList = null;
		File[] mp3List = null;
		//MP3[] mp3List = null;
		directory = directory.concat("/");
    	dirList = List_Dirs_In_Dir(directory);
		mp3List = List_Mp3s_In_Dir(directory);
		if (dirList.length == 0){
			addToList(totalList, mp3List);
      		mp3List = List_Mp3s_In_Dir(directory);
    	}
    	else{
		  	for(int i = 0; i < dirList.length; i++){
	  			String temp = directory.concat(dirList[i].getName());
	    		makeList(temp);
      		}
	  		addToList(totalList, mp3List);
    	}
	}


  	/*
  	 * Display Vector provided to screen
  	 */
  	public void printList(){
  	  	for(int i = (totalList.size()-1); i >=0; i--){
  	    	System.out.println(i+1 + ") " +totalList.elementAt(i));
  	  	}
		System.out.println("The total list has "+ totalList.size()+ " songs.");
  	}

  	/*
   	 * appends the provided array elements to the Vector
   	 */
  	private void addToList(Vector totalList, File[] toAdd){
  		for(int i = 0; i < toAdd.length; i++){
			totalList.add(toAdd[i]);
  		}
  	}
	private void addToList(Vector totalList, MP3[] toAdd){
  		for(int i = 0; i < toAdd.length; i++){
			System.out.println(toAdd[i].getClass());
			//totalList.add((Object)toAdd[i]);
  		}
  	}

  	/*
   	 * Displays the number of elements in the Vector
   	 */
  	public void printListSize(){
		System.out.println(totalList.size()+" songs");
  	}

  	/*
   	 * Returns a File array holding all mp3s in the
     * 	provided directory
   	 */
  	private File[] List_Mp3s_In_Dir(String directory){
    	Filter MP3Filter = new Filter(".mp3");
    	File currentDir = new File(directory);
		File[] tempArray = currentDir.listFiles(MP3Filter);
		MP3[] mp3Array;
    	return (currentDir.listFiles(MP3Filter));
		//return tempArray;
		//for(int i = 0; i < tempArray.size; i++)
		//{
		//	mp3Array[i] = (MP3)(tempArray[i]);
		//}
		//return mp3Array;
		
  	}

  	/*
   	 * Returns a Vector holding all subdirectories
   	 * 	of the provided directory
     */
  	private File[] List_Dirs_In_Dir(String directory){
    	int i;
    	int dirCnt = 0;
    	File[] tmpList;
    	Vector dirList = new Vector();
    	dirCnt = 0;
    	Filter ListAllFilter = new Filter();
    	File currentDir = new File(directory);

    	tmpList = currentDir.listFiles(ListAllFilter);
    	if (tmpList != null){
      		for(i = 0; i < tmpList.length; i++){
        		if (tmpList[i].isDirectory()){
          			dirList.add(tmpList[i]);
        		}
      		}
    	}
    	tmpList = new File[dirList.size()];
    	for(i = 0; i < dirList.size(); i++){
      		tmpList[i] = (File)(dirList.elementAt(i));
    	}
    	return tmpList;
  	}


  	public static void main(String args[]){
    	Mp3Lister m = new Mp3Lister();
		//m.makeList("c:");
		//m.makeList("d:");
    	m.makeList("g:");
		m.printList();
		m.printListSize();
  	}

}


