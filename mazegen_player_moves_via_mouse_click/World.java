/* WORLD IS USED TO BUILD A NEW WORLD */
import java.applet.Applet;
import java.net.URL;
import java.awt.*;
import java.awt.image.*;
import java.util.*;
import java.lang.reflect.*;
//import java.awt.event.*;
import java.awt.Component;

public class World extends Playfield
{
	private MediaTracker mt;
	private Playfield pf;
    private Sprite monster;
	private Player player;
	private Wall wall;
	private Vector wallVector = new Vector();
	//private Image wall = new Image();
	private int windowWidth, windowHeight;
	private int imageSize = 30;
	private boolean firstTime = true;
	private Image bg, playerIm, monsterIm;
	public World(MazeGenPlayfield field, int windWidth, int windHeight)
	{
		mt = new MediaTracker(this);
		windowWidth = windWidth;
		windowHeight = windHeight;
		pf = field;
	}
	public void createAll(MazeGenPlayfield pf)
	{
	}
	public void paintBackground(Graphics g) {
		URL url = getClass().getResource("gifs/background.gif");
		try
		{
        	bg = createImage((ImageProducer)url.getContent());
			mt.addImage(this.bg, 0);
			mt.waitForID(0);
			if (this.mt == null)
				System.out.println("Null background");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}				
        Util.wallPaper(pf, g, bg);
		//g.drawImage(bug[0], 0, 0, field);
		//this.buildGrid(g);
    }
	private void buildGrid(Graphics g)
	{
		Dimension size = getSize();
		int num = (windowHeight*windowWidth)/(imageSize * imageSize);
		int counter = 0;
		//if (firstTime)
		//{
		//	firstTime = false;
			int x, y;
			for (x = 0; x<=windowWidth; x+=imageSize)
			{
				g.drawLine(x,0,x, windowHeight); 
			}
			for (y = 0; y<=windowHeight; y+=imageSize)
			{
				g.drawLine(0,y, windowWidth, y); 
			}
			System.out.println("Num boxes=" +num);
			for(y=0; y<windowHeight; y+=imageSize)
			{
				for(x = 0; x<windowWidth;x += imageSize)
				{
					String number = Integer.toString(counter);
					g.drawString(number, x+(imageSize/4), y+(imageSize/2));
					counter ++;
				}
			}
		//}
	} //END buildGrid()
		
	private Point boxToPoint(int boxNum)
	{
		int startY = (boxNum / 20) * 30;
		int startX;
		while (boxNum>19)	boxNum -= 20;
		startX = 30 * boxNum;
		Point p = new Point(startX, startY);
		return p;
	}
	
	private void putWall(int sb)
	{
		putWall(sb, sb);
	}
	private void putWall(int startBox, int endBox)
	{
		Point sp = boxToPoint(startBox);
		Point ep = boxToPoint(endBox);
		Wall temp = new Wall(pf, sp, ep);
		wallVector.add(temp);
	}
	private void addPlayer(int boxNum)
	{	
		URL url = getClass().getResource("gifs/bug.gif");
		try
		{
        	playerIm = createImage((ImageProducer)url.getContent());
			mt.addImage(this.playerIm, 0);
			mt.waitForID(0);
			if (this.mt == null)
				System.out.println("Null background");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		//oneBug = applet.getImage(cb, file);
		//bug[0] = applet.getImage(cb, file);
		//System.out.println("Image is loaded");
		//System.out.print("boxNum: " + boxNum + " - ");
		Point playerLoc = boxToPoint(boxNum);
		//playerLoc.translate(1,1);
		//System.out.println("boxToPoint Complete");
		//System.out.println("("+playerLoc.getX()+", "+playerLoc.getY()+")");
        //bugSequence = new Sequence(field, bug);
		player = new Player(pf,playerIm, playerLoc);
		//player = new Player(field, bugSequence, playerLoc);
		//bugSequence.setAdvanceInterval(400);
		player.setMoveInterval(1000);
        player.setMoveVector(new Point(0,0));
		pf.add(player);
		
    }
	private void addMonsters(int[] locations)
	{	
		URL url = getClass().getResource("gifs/bug.gif");
		try
		{
        	monsterIm = createImage((ImageProducer)url.getContent());
			mt.addImage(this.monsterIm, 0);
			mt.waitForID(0);
			if (this.mt == null)
				System.out.println("Null monsters");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		for(int i=0; i< Array.getLength(locations); i++)
		{
			monster = new Sprite(pf, monsterIm, boxToPoint(locations[i]));
			monster.setMoveVector(new Point(-1,1));
        	monster.setMoveInterval(i * 1000 + 1000);		
			pf.add(monster);
		}
	}
	
	private void buildMaze1()
	{
		putWall(0,180);		putWall(200,280);
		putWall(281,290); 	putWall(291);
		putWall(292,297); 	putWall(219,299);
		putWall(19,199); 	putWall(2,10);
		putWall(10,18); 	putWall(48,68);
		putWall(50,51);		putWall(42,47);
		putWall(82,102); 	putWall(83,86);
		putWall(121,126); 	putWall(162,167);
		putWall(201,206); 	putWall(242,247);
		putWall(128,268); 	putWall(88,90);
		putWall(110,250); 	putWall(251,255);
		putWall(235);		putWall(192,198);
		putWall(151,157);	putWall(52,112);
		putWall(113,117);	putWall(34,74);
		putWall(56,96);		putWall(38,58);
		for(int i = 0; i < wallVector.size(); i++)
		{
			pf.add((Wall)wallVector.elementAt(i));
		}
    }
}