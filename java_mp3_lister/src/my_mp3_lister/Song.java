package my_mp3_lister;

/**
 * Title:        MP3 Lister
 * Description:  This program will scan your directories and list the mp3s
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author James Sandlin
 * @version 1.0
 */

public class Song {
  private String title;
  private Artist artist;
  public Song(String t, Artist a) {
    this.title = t;
    this.artist = a;
  }

  public String getArtist(){
    return this.artist;
  }
  public String getTitle(){
    return this.title;
  }
  public void setTitle(String t){
    this.title = t;
  }
  public void setArtist(Artist a){
    this.artist = a;
  }

}