/* Player.java */
/* 04/03/01 8PM */
import java.awt.*;
import java.util.Vector;
import java.applet.Applet;
import java.awt.event.*;

public class Player extends Sprite
{	
	Rectangle newBounds = getBounds();
	Rectangle oldBounds = getBounds();
	private boolean hitWall = false;
	Point press = new Point();
	//private Dragger dragger = new Dragger();
    private Stopwatch cellAdvanceTimer = new Stopwatch();
	public boolean onWall = false;
	private Point     lastPaintLocation   = new Point(0,0);
	protected int newX, prevX, newY, prevY;
	public Player(DoubleBufferedContainer container, Image image, Point ulhc) {
			super(container, image, ulhc);
		//	addMouseListener(dragger);
		//	addMouseMotionListener(dragger);
	}
	
	public void  setHitWall(boolean hitOne)	{	}
	
    public void animate() {
        if(timeToMove()) {
			advance();
		}
		else {	container.paintComponent(this);	}
    }
	
	protected void advance() {
		//oldBounds = newBounds;
		oldBounds = getBounds();
		this.container.blitBackgroundToWorkplace(oldBounds);
		setBounds(oldBounds.x + moveVector.x, oldBounds.y + moveVector.y,
		      thisImage.getWidth(this), thisImage.getHeight(this));
		container.paintComponents(oldBounds.union(getBounds()),
		                          true);
		cellAdvanceTimer.reset();  	  
	}
	
	class Dragger extends MouseAdapter implements
					MouseMotionListener	{
		boolean dragging = false;
		protected int xTemp;
		protected int yTemp;
		public void mousePressed(MouseEvent event) {
			xTemp = (int)getLocation().getX();
			yTemp = (int)getLocation().getY();
			//System.out.println("Pressed");
			press.x = event.getX();
			press.y = event.getY();
			dragging = true;
		}
		public boolean isDragging() {
			//System.out.println("Dragging");
			return dragging;
		}
		public void mouseReleased(MouseEvent event) {
			//System.out.println("Released");
			onWall = false;
			dragging = false;
			//setMoveVector(new Point(0,0));
		}
		public void mouseClicked(MouseEvent event) {
			//System.out.println("Clicked");
			dragging = false;
		}
		public void mouseMoved(MouseEvent event) {
			// don't care
		}
		public void mouseDragged(MouseEvent event) {
			
			//System.out.println("Dragged");
			//DoubleBufferedContainer c;
			//oldBounds = getBounds();
			//prevLoc = getLocation();
			/*
			 * prevX -> (prevX, prevY) is the point the character was 
			 *			drawn at when the mouse was pressed on it.
			 *		 EX: Character started at (30,0) so prev:=(30,0)
			 * relX -> where mouse is currently in relation to prev
			 * loc -> current location
			 * press.x -> on the 30*30 character, where from origin 
			 *			mouse button is pressed.
			 *			EX: close to bottom left => (1,5)
			 * newX -> the new point to draw the image from dragging.
			 * event.getX -> where in relation to image mouse is
			 */
			Point loc = getLocation();
			prevX = loc.x;
			prevY = loc.y;
			Point prevLoc = new Point(prevX, prevY);
			int relX = event.getX();
			int relY = event.getY();
			newX = prevX + relX - 5;
			newY = prevY + relY - 5;
			int xTemp = relX- press.x;
			int yTemp = relY- press.y;
			System.out.println("The new Location is:("+newX+", "+newY+")");	
			
			setMoveVector(new Point((newX - prevX),	(newY - prevY)));
			animate();
			/*
			 * because xtemp increases as long as the mouse button
			 *	is held down, we subtract the value held coming into this 
			 *	method again to keep it holding a value related to the
			 *	previous location rather that the location it had when the 
			 * 	mouse button was pressed down.
			 */
			//int xMove = (prevX - xTemp);
			//int yMove = (prevY - yTemp);
		}
	}		
}
