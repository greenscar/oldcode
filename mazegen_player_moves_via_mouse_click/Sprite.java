/* Sprite.java */
/* 04/03/01 8PM */

import java.awt.*;
import java.util.*;

public class Sprite extends Component { 
	protected DoubleBufferedContainer container;
	protected Stopwatch cellAdvanceTimer = new Stopwatch();
	protected long cellAdvanceInterval = 0;
	protected Point lastPaintLocation = new Point(0,0);
	protected Stopwatch moveTimer = new Stopwatch();
	protected Image thisImage;
	protected Point startPt      = new Point(0,0);
	protected Point moveVector   = new Point(0,0);
	protected long  moveInterval = 0;
	protected int counter = 0;

	public Sprite()	{
	}
	public Sprite(DoubleBufferedContainer cont,	Image image, Point ulhc){
		thisImage = image;
		this.container = cont;
		setLocation(ulhc);
		moveTimer.start      ();
	}
	public void  reverseX () { moveVector.x = 0-moveVector.x;  }
	public void  reverseY () { moveVector.y = 0-moveVector.y;  }
	public void  reverse  () { reverseX(); reverseY();         }

	public void  turn() { 
		if (moveVector.x > 0)
		{
			moveVector.x = 0;
			moveVector.y = -1;
		}
		else if (moveVector.x < 0)
		{
			moveVector.x = 0;
			moveVector.y = 1;
		} 
		else if (moveVector.y > 0)
		{
			moveVector.x = 1;
			moveVector.y = 0;
		}
		else if (moveVector.y < 0)
		{
			moveVector.x = -1;
			moveVector.y = 0;
		}
	}
	public void  setMoveVector (Point p) { moveVector = p;     }
	public Point getMoveVector()         { return moveVector;  }

	public void rewind(){
		Rectangle bounds = this.getBounds();
		container.blitBackgroundToWorkplace(bounds);
		setBounds((bounds.x - this.moveVector.y),(bounds.y - this.moveVector.y),
				thisImage.getWidth(this), thisImage.getHeight(this));
		container.paintComponents(bounds.union(getBounds()), true);
		cellAdvanceTimer.reset();
	}
	public void paint(Graphics g) {
		if(isVisible()) {
			g.drawImage(thisImage, 0, 0, this);
		}
	}
	public void update(Graphics g) {
		paint(g);
	}
	/**
	 * @deprecated as of JDK1.1
	 */
	public Dimension preferredSize() {
		return new Dimension(thisImage.getWidth(this),
		                     thisImage.getHeight(this));
	}
	public Dimension getPreferredSize() {
		return preferredSize();
	}
	public void play(){	}
	
    public void animate() {
        if(timeToMove()) {
			advance();
		}
		else {
			if(needsRepainting()) {
				container.paintComponent(this);
			}
		}
    }
    public boolean willIntersect(Sprite otherSprite) {
        return getNextBounds().intersects(
				otherSprite.getNextBounds());
    }
    public void setLocation(int x, int y) {
		super.setLocation(x, y);
        moveTimer.reset();
    }
    public void setMoveInterval(long interval) {
        moveInterval = interval;
    }
    public void setImageChangeInterval(long interval) {
        setAdvanceInterval(interval);
    }
    public void setAdvanceInterval(long interval) {
        cellAdvanceInterval = interval;
    }
    public Image getCurrentImage() { 
        return thisImage;      
    }
    public Point getNextLocation() {
		Rectangle bounds = getBounds();
        return new Point(bounds.x + moveVector.x, 
                         bounds.y + moveVector.y);
    }
    public Rectangle getNextBounds() {
		Rectangle bounds = getBounds();
        Point nextLoc    = getNextLocation();
        return new Rectangle(nextLoc.x,    nextLoc.y, 
							 bounds.width, bounds.height);
    }
    public void  start          () { cellAdvanceTimer.start(); }
    
	protected boolean timeToMove() {
        return moveTimer.elapsedTime() > moveInterval;
    }
    protected boolean needsRepainting() {
		Rectangle bounds = getBounds();
        return this.needsRepainting(
					new Point(bounds.x, bounds.y));
    }
    public boolean needsRepainting(Point point) {
        return (lastPaintLocation.x != point.x ||
                lastPaintLocation.y != point.y);
    }	
	protected void advance() {
		Rectangle bounds = getBounds();
		this.container.blitBackgroundToWorkplace(bounds);
		setBounds(bounds.x + moveVector.x,
		          bounds.y + moveVector.y,
				  thisImage.getWidth(this), thisImage.getHeight(this));
		container.paintComponents(bounds.union(getBounds()), true);
		cellAdvanceTimer.reset();
    	  
	}
}
