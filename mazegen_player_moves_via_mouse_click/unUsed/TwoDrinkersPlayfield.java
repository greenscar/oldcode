import java.applet.Applet;
import java.net.URL;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

public class TwoDrinkersPlayfield extends Playfield 
                                  implements ItemListener {
    private Applet   applet;
	private boolean  collisionsEnabled = true;
    private URL      cb;
    private Sprite   moveFastSpinSlow, moveSlowSpinFast, wallSprite;
    private Sequence fastSpinSequence, 
                     slowSpinSequence,
                     fastBumpSequence,
                     slowBumpSequence,
					 wallSequence;	 
	Image[] spinImages = new Image[19];
    Image[] bumpImages = new Image[6];
	Vector walls = new Vector();
	boolean firstTime = true;
        
    public TwoDrinkersPlayfield(Applet applet) {
		this.applet = applet;
		cb          = applet.getCodeBase();
		makeSequencesAndSprites();
		addMouseListener(new MouseAdapter() {
			public void mousePressed (MouseEvent event) {
				if(running() == true) stop ();
				else                  start();
			}
		});
    }
    public void paintBackground(Graphics g) {
        Image bg = applet.getImage(cb, "gifs/background.gif");
        Util.wallPaper(this, g, bg);
		buildGrid(g);
    }
	
	private void buildGrid(Graphics g)
	{
		int imageHeight = 30;
		int imageWidth = 30;
		int windowWidth = 600;
		int windowHeight = 450;
		Dimension size = getSize();
		if (firstTime)
		{
			int x, y;
			for (x = 0; x<=windowWidth; x+=imageWidth)
			{
				//g.drawString(Integer.toString(x), x,10);
				g.drawLine(x,0,x, windowHeight); 
			}
			for (y = 0; y<=windowHeight; y+=imageHeight)
			{
				//g.drawString(Integer.toString(y), 0, y);
				g.drawLine(0,y, windowWidth, y); 
			}
			int num = (windowHeight*windowWidth)/(imageHeight*imageWidth);
			int counter = 0;
			System.out.println(num);
			for(y=0; y<windowHeight; y+=imageHeight)
			{
				for(x = 0; x<windowWidth;x += imageWidth)
				{
					String number = Integer.toString(counter);
					g.drawString(number, x+(imageWidth/4), y+(imageHeight/2));
					counter ++;
				}
			}
		}	
		firstTime = false;
	}
	
	public void itemStateChanged(ItemEvent event) {
	}
	
    public void spriteCollision(Sprite sprite, Sprite sprite2) {
		if (sprite instanceof Wall)
		{
			sprite2.reverse();
           	sprite2.play(fastBumpSequence, 3);
		}
		else if (sprite2 instanceof Wall)
		{
			sprite.reverse();
           	sprite.play(slowBumpSequence, 3);
		}
		else if(moveSlowSpinFast.getSequence() != 
		  			fastBumpSequence) {
            sprite.reverse();
            sprite2.reverse();
           	moveSlowSpinFast.play(fastBumpSequence, 3);
           	moveFastSpinSlow.play(slowBumpSequence, 3);
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
    private void makeSequencesAndSprites() {
		//loadCoffee();
		buildMaze1();
		for(int i = 0; i < walls.size(); i++)
		{
			add((Wall)walls.elementAt(i));
		}
		
		
    }
	private void buildMaze1()
	{
		putWall(0,180);
		putWall(200,280);
		putWall(281,291);
		putWall(292,297);
		putWall(219,299);
		putWall(19,199);
		putWall(1,10);
		putWall(10,18);
		putWall(48,68);
		putWall(50,51);
		putWall(42,47);
		putWall(82,102);
		putWall(83,86);
		putWall(121,126);
		putWall(162,167);
		putWall(201,206);
		putWall(242,247);
		putWall(128,268);
		putWall(88,90);
		putWall(110,250);
		putWall(251,255);
		putWall(235);
		putWall(192,198);
		putWall(151,157);
		putWall(52,112);
		putWall(113,117);
		putWall(34,74);
		putWall(56,96);
		putWall(38,58);
    }
	private void putWall(int sb)
	{
		putWall(sb, sb);
	}
	private void putWall(int startBox, int endBox)
	{
		int startY = (startBox / 20) * 30;
		int endY = (endBox / 20) * 30;
		int startX, endX;
		while (startBox>19)	startBox -= 20;
		startX = 30 * startBox;
		while (endBox>19) endBox -= 20;
		endX = 30 * endBox;
		System.out.println("startX,startY: (" 
				+ startX + "," + startY+")");
		System.out.println("endX,endY: (" 
				+ endX + "," + endY+")");
		Point sp = new Point(startX, startY);
		Point ep = new Point(endX, endY);
		walls.add(new Wall(this, sp, ep));
		
	}
	private void loadCoffee()
	{
			String  file;
		    for(int i=0; i < spinImages.length; ++i) {
            file = "gifs/spin";

            if(i < 10) file += "0" + i + ".gif";
            else       file += i + ".gif";

            spinImages[i] = applet.getImage(cb, file);
        }
        for(int i=0; i < bumpImages.length; ++i) {
            file = "gifs/bump0" + i + ".gif";
            bumpImages[i] = applet.getImage(cb, file);
        }
		
    	fastSpinSequence = new Sequence(this, spinImages);
        slowSpinSequence = new Sequence(this, spinImages);

        fastBumpSequence = new Sequence(this, bumpImages);
        slowBumpSequence = new Sequence(this, bumpImages);
			
        moveFastSpinSlow = 
            new Sprite(this, 
                slowSpinSequence, new Point(25, 75));

        moveSlowSpinFast = 
            new Sprite(this, 
                fastSpinSequence, new Point(250,250));
		
        fastSpinSequence.setAdvanceInterval(50);
        slowSpinSequence.setAdvanceInterval(300);

        fastBumpSequence.setAdvanceInterval(25);
        slowBumpSequence.setAdvanceInterval(200);
		
		moveFastSpinSlow.setMoveVector(new Point(2,0));
        moveSlowSpinFast.setMoveVector(new Point(-1,-1));

        moveSlowSpinFast.setMoveInterval(100);		

		add(moveFastSpinSlow);
        add(moveSlowSpinFast);
	}
}
