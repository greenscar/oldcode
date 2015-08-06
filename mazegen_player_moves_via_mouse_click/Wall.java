/* Wall.java */
/* 04/03/01 8PM */
import java.awt.*;
import java.awt.image.*;
import java.util.*;
import java.net.URL;

public class Wall extends Sprite{
	protected Image brick;
	private int x, y;
	private Point startingPoint, endingPoint;
	private DoubleBufferedContainer container;
	private Vector wallVector = new Vector();
	//private Point moveVector = new Point(0,0);
	private int NumUnits = 1;
	private String direction = "vert"; /* vert OR horiz */
	int spX, spY, epX, epY, xLength, yLength;
	
	public Wall(DoubleBufferedContainer c, Point sp)
	{
		this(c, sp, sp);
	}
	public Wall(DoubleBufferedContainer c, Point sp, Point ep)
	{
		this.container = c;
		spX = (int)sp.getX();
		spY = (int)sp.getY();
		epX = (int)ep.getX();
		epY = (int)ep.getY();
		xLength = epX - spX;
		yLength = epY - spY;
		getImage();
		setLocation(sp);
	}
	
	
	public void  reverseX () { moveVector.x = 0-moveVector.x;  }
	public void  reverseY () { moveVector.y = 0-moveVector.y;  }
	public void  turn  () { reverseX(); reverseY();         }

	/*                                                */
	/* DETERMINE IF THE WALL WILL BE VERT OR HORIZ    */
	/*                                                */
	public String VertOrHoriz()
	{
		if((xLength) != 0)
		{
			return "horiz";
		}
		else
		{
			return "vert";
		}
	}
	
	/*                                                */
	/* LOAD THE CORRECT IMAGE BASED ON VertOrHoriz()  */ 
	/*  & THE DISTANCE BETWEEN sp & ep                */
	/*                                                */
	public void getImage()
	{
		URL url;
		MediaTracker mt = new MediaTracker(this);
		//System.out.println("getImage sp(" + spX+ ","+spY+")");
		//System.out.println("getImage ep(" + epX+ ","+epY+")");
		if ((spX == epX) && (spY == epY))
		{
			//System.out.println("Loading 1 brick");
			url = getClass().getResource("gifs/brick1.jpg");
		}
		else
		{
			int numUnits = 0;
			if (VertOrHoriz() == "vert")
			{
				numUnits = yLength / 30 + 1;
				//System.out.println("Loading "+ numUnits + "V brick");
				url = getClass().getResource("gifs/brick" + numUnits + "V.jpg");
			}
			else
			{
				numUnits = xLength / 30 + 1;
				//System.out.println("Loading "+ numUnits + "H brick");
				url = getClass().getResource("gifs/brick" + numUnits + "H.jpg");
			}
			System.out.println(numUnits +" bricks");
		}
		try
		{
			this.brick = createImage((ImageProducer)url.getContent());
			mt.addImage(this.brick, 0);
			mt.waitForID(0);
			if (this.brick == null)
			{
				System.out.println("null image");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void paint(Graphics g)
	{
		if(isVisible()) 
		g.drawImage(brick, 0, 0, this);
	}
	public void update(Graphics g)
	{
		paint(g);
	}
	/**
	 * @deprecated as of JDK1.1
	 */
	public Dimension preferredSize() {
		return new Dimension(xLength+30, yLength+30);
	}
	public Dimension getPreferredSize() {
		return preferredSize();
	}
	
	public void advance() {
		Rectangle bounds = getBounds();
		//System.out.println("Bounds("+bounds.x +"," +bounds.y+")  "+"MoveVector("+moveVector.x+"," + moveVector.y+")");
		this.container.blitBackgroundToWorkplace(bounds);
		setBounds((bounds.x + moveVector.x),(bounds.y + moveVector.y),
				  brick.getWidth(this), brick.getHeight(this));
		container.paintComponents(bounds.union(getBounds()), true);
		cellAdvanceTimer.reset();
    	  
	}
}