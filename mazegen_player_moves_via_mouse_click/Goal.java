/* Goal.java */
/* 04/03/01 8PM */
import java.awt.*;
import java.awt.image.*;
import java.util.*;
import java.net.URL;

public class Goal extends Sprite{
	protected Image goal;
	private int x, y;
	private Point startingPoint, endingPoint;
	private DoubleBufferedContainer container;
	private Vector wallVector = new Vector();
	private int spX, spY;
	public Goal(DoubleBufferedContainer c, Point sp)
	{
		
		this.container = c;
		spX = (int)sp.getX();
		spY = (int)sp.getY();
		getImage();
		setLocation(sp);
	}
	
	/*                                                */
	/* LOAD THE CORRECT IMAGE BASED ON VertOrHoriz()  */ 
	/*  & THE DISTANCE BETWEEN sp & ep                */
	/*                                                */
	public void getImage()
	{
		URL url;
		MediaTracker mt = new MediaTracker(this);
		url = getClass().getResource("gifs/ankh.gif");
		try
		{
			this.goal = createImage((ImageProducer)url.getContent());
			mt.addImage(this.goal, 0);
			mt.waitForID(0);
			if (this.goal == null)
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
		g.drawImage(goal, 1, 0, this);
	}
	public void update(Graphics g)
	{
		paint(g);
	}
	/**
	 * @deprecated as of JDK1.1
	 */
	public Dimension preferredSize() {
		return new Dimension(30, 30);
	}
	public Dimension getPreferredSize() {
		return preferredSize();
	}
	
	public void advance() {
		Rectangle bounds = getBounds();
		this.container.blitBackgroundToWorkplace(bounds);
		setBounds((bounds.x + moveVector.x),(bounds.y + moveVector.y),
				  goal.getWidth(this), goal.getHeight(this));
		container.paintComponents(bounds.union(getBounds()), true);
		cellAdvanceTimer.reset();
    	  
	}
}