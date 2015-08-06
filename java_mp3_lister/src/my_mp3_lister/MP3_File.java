package my_mp3_lister;
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

public class MP3_File {
  private File theFile;
  private String fileName;
  private Artist artist;
  private Song song;
  private String location;

  public MP3_File(String name) {
    this.fileName = name;
  }
  public String getLocation(){
    return this.location;
  }
  public String getName(){
    return this.fileName;
  }
  public Song getSong(){
    return this.song;
  }
  public Artist getArtist(){
    return this.artist;
  }

}