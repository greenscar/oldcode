import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.*;
import java.util.*;
import java.lang.reflect.*;
import javax.swing.*;
import java.net.*;
import java.lang.Runtime;

public class MazeGenPlayfield extends Playfield 
                                  implements ItemListener {
    private Applet   applet;
	private MediaTracker mt;
	private Sprite monster;
	private Player player;
	private Wall wall;
	private Goal goal;
	private Vector wallVector = new Vector();
	private int windowWidth, windowHeight;
	private int imageSize = 30;
	private boolean firstTime = true;
	private Image bg, playerIm, monsterIm, brickIM;
	private boolean  collisionsEnabled = true;
	private Point sp, ep;
	protected Point press = new Point(1,1);
	private Dragger dragger = new Dragger();
	Runtime runtime;
	public MazeGenPlayfield(Applet applet) {
		windowWidth = 600;//applet.getWidth();
		windowHeight = 480;
		this.applet = applet;
		mt = new MediaTracker(this);
		buildIt();
		start();
		addMouseListener(dragger);
		addMouseMotionListener(dragger);
	}
	public void buildIt()
	{
		addMonster(29, 'y');
		addMonster(261, 'x');
		addMonster(216);
		addPlayer(21);
		addGoal(23);
		buildMaze1();
		
	}
    public void spriteCollision(Sprite sprite, Sprite sprite2, Orientation orient) {
	   	if (sprite instanceof Player)
		{
			if (sprite2 instanceof Wall)
			{
				sprite.setMoveVector(new Point(0,0));
			}
			else if (sprite2 instanceof Goal)
			{
				JOptionPane.showMessageDialog(this, "Well good for you; you won.");
				runtime.exit(1);
			}
			else //sprite2 monstor
			{
				JOptionPane.showMessageDialog(this, "You lost. Get over it.");
				runtime.exit(1);
			}
		}
		else if (sprite2 instanceof Player)
		{
			if ( sprite instanceof Wall)
			{
				sprite2.setMoveVector(new Point(0,0));
			}
			else if (sprite instanceof Goal)
			{
				JOptionPane.showMessageDialog(this, "I can't believe you won!?!?!");
				runtime.exit(1);
			}
			else //sprite2 monstor
			{
				JOptionPane.showMessageDialog(this, "You are a LOOSER");
				runtime.exit(1);
			}
		}
		else if (sprite instanceof Wall)
		{
			sprite2.turn();
		}
		else if (sprite2 instanceof Wall)
		{
			sprite.turn();
		}
		else if(sprite != sprite2) {
            sprite.reverse();
            sprite2.reverse();
       	}  	 
		
    }
	
    public void edgeCollision(Sprite      sprite, 
                              Orientation orientation) {
        if(orientation == Orientation.RIGHT || 
           orientation == Orientation.LEFT) 
            sprite.reverseX();
        else 
            sprite.reverseY();
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
        Util.wallPaper(this, g, bg);
		//repaint();
	//	buildGrid(g);
    }
	private void addPlayer(int boxNum)
	{	
		mt = new MediaTracker(this);
		URL url = getClass().getResource("gifs/snake.gif");
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
		Point playerLoc = boxToPoint(boxNum);
		player = new Player(this,playerIm, playerLoc);
		add(player);
    }
	
	private void addMonster(int location)
	{	
		addMonster(location, 'z');
	}
	
	private void addMonster(int location, char xy)
	{	
		Point movement;
		if (xy == 'x') movement = new Point(1,0);
		else if (xy == 'y') movement = new Point(0,1);
		else movement = new Point(1,-1);
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
			monster = new Sprite(this, monsterIm, boxToPoint(location));
			monster.setMoveVector(movement);
        	monster.setMoveInterval(2);		
			add(monster);
	}
	private void buildGrid(Graphics g)
	{
		Dimension size = getSize();
		int num = (windowHeight*windowWidth)/(imageSize * imageSize);
		int counter = 0;
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
	}	
	private Point boxToPoint(int boxNum)
	{
		int startY = (boxNum / 20) * 30;
		int startX;
		while (boxNum>19)	boxNum -= 20;
		startX = 30 * boxNum;
		Point p = new Point(startX, startY);
		return p;
	}
	private void addGoal(int box)
	{
		Point p = boxToPoint(box);
		goal = new Goal(this, p);
		add(goal);
	}
	
	private void putWall(int sb)
	{
		putWall(sb, sb);
	}
	private void putWall(int startBox, int endBox)
	{
		Point sp = boxToPoint(startBox);
		Point ep = boxToPoint(endBox);
		wall = new Wall(this, sp, ep);
		wallVector.add(wall);
	}
	private void putMovingWall(int boxNum, char axis)
	{
		System.out.println(axis);
		Point moving;
		if (axis == 'y'){moving = new Point(0,1);}
		else if (axis == 'x'){moving = new Point(1,0);}
		else{moving = new Point(0,0);}
		Point where = boxToPoint(boxNum);
		wall = new Wall(this, where, where);
		wall.setMoveVector(new Point(0,-1));
        wall.setMoveInterval(0);		
		add(wall);
    }		
		
	private void buildMaze1()
	{
		putWall(0,180);		putWall(200,280);
		putWall(281,290); 	putMovingWall(291, 'y');
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
			add((Wall)wallVector.elementAt(i));
		}
    }
	public void itemStateChanged(ItemEvent event) {
	}
		
	class Dragger extends MouseAdapter implements
					MouseMotionListener	{
		boolean dragging = false;
		protected Point playerPt;
		int tempX, tempY;
		public void mousePressed(MouseEvent event) {
			dragging = true;
		}
		public void mouseReleased(MouseEvent event) {
		}
		public void mouseClicked(MouseEvent event) {
			press.x = event.getX();
			press.y = event.getY();
			tempX = (int)player.getLocation().getX();
			tempY= (int)player.getLocation().getY();
			playerPt = new Point(tempX, tempY);
			setPlayerMovement(press, playerPt);
			
		}
		public void mouseMoved(MouseEvent event) {
			
		}
		public void mouseDragged(MouseEvent event) {
		}
	}		
	void setPlayerMovement(Point press, Point playerPt)
	{
		int xDiff = press.x - playerPt.x;
		int yDiff = press.y - playerPt.y;
		System.out.println("Click:("+press.x+", "+press.y+")");
		System.out.println("Player:("+playerPt.x+", "+playerPt.y+")");
		System.out.println("Diff:("+xDiff+", "+yDiff+")");
		if((playerPt.x < press.x) && (press.x < (playerPt.x + 30))){
			/*THE CLICK WAS ON SAME COLUMN AS PLAYER*/
			if (press.y > (playerPt.y + 30))
			{
				player.setMoveVector(new Point(0,2));
			}
			else if (press.y < (playerPt.y))
			{
				player.setMoveVector(new Point(0,-2));
			}
		}
		
		else if((playerPt.y < press.y) && (press.y < (playerPt.y + 30))){
			/*THE CLICK WAS ON SAME ROW AS PLAYER*/
			if (press.x > (playerPt.x + 30))
			{
				player.setMoveVector(new Point(2,0));
			}
			else if (press.x < (playerPt.x))
			{
				player.setMoveVector(new Point(-2,0));
			}
		}
		
	}
	                              }
	
