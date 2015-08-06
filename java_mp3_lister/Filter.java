//package my_mp3_lister;
import java.io.*;
/*
 * Create a filter for mp3 files.
 * To list all files in the dir, use no argument
 * To list files with particular extension,
 * provide it.
 */
class Filter implements FilenameFilter
{
	String extension = "";
	public Filter()
	{
		extension = "";
	}
	public Filter(String n)
	{
		extension = n;
	}
	public boolean accept(File dir, String name)
	{
		return name.endsWith(extension);
	}
}
