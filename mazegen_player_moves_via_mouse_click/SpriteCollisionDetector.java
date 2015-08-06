/*Thursday, April 5*/
/*935 AM*/
import java.awt.*;
import java.util.Enumeration;
import java.util.Vector;

public class SpriteCollisionDetector extends CollisionDetector {
    public SpriteCollisionDetector(CollisionArena arena) {
        super(arena);
    }
    public void detectCollisions() {
		Orientation or;
        Enumeration sprites = arena.getSprites().elements();
        Sprite      sprite;
		String thePlayer = "Neither";
		Point nl = new Point(0,0);
		Point onl = new Point(0,0);
        int   nextRightEdge=0, nextBottomEdge=0, wallRightEdge=0, wallBottomEdge=0;
        while(sprites.hasMoreElements()) {
          sprite = (Sprite)sprites.nextElement();
		  Enumeration otherSprites = arena.getSprites().elements();
            Sprite otherSprite;
            while(otherSprites.hasMoreElements()) {
              otherSprite=(Sprite)otherSprites.nextElement();
			  if (otherSprite != sprite)
			  {
				if (sprite instanceof Player)
				{			
				  thePlayer = "sprite";
				  nl     = sprite.getNextLocation ();
				  onl = otherSprite.getNextLocation();
				  //Point mv     = sprite.getMoveVector();
				  int   width  = sprite.getBounds().width;
				  int   height = sprite.getBounds().height;
				  nextRightEdge   = nl.x + width;
				  nextBottomEdge  = nl.y + height;
				  wallRightEdge = otherSprite.getBounds().width + onl.x;
				  wallBottomEdge =  otherSprite.getBounds().height + onl.y;
				}// END if (sprite instanceof Player)
				else if (otherSprite instanceof Player)
				{			
				  thePlayer = "otherSprite";
				  nl     = otherSprite.getNextLocation ();
				  onl = sprite.getNextLocation();
				  int   width  = otherSprite.getBounds().width;
				  int   height = otherSprite.getBounds().height;
				  nextRightEdge   = nl.x + width;
				  nextBottomEdge  = nl.y + height;
				  wallRightEdge = sprite.getBounds().width + nl.x;
				  wallBottomEdge =  sprite.getBounds().height + nl.y;
				} // END else if (otherSprite instanceof Player)			
				else thePlayer = "neither";
            	if (sprite.willIntersect(otherSprite))
				{
				  if (sprite instanceof Player)
				  {
				  	((Player)sprite).setHitWall(true);
					if (nextRightEdge >= onl.x) 
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.RIGHT);
						//System.out.println("Hit from RIGHT");
					}
					else if (nl.x< onl.x + otherSprite.getBounds().width)
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.LEFT);
						//System.out.println("Hit from LEFT");
					}
					else if (nextBottomEdge >= onl.y) 
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.TOP);
						//System.out.println("Hit from TOP");
					} 
					else if(nl.y< onl.y + otherSprite.getBounds().height)
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.BOTTOM);
					//	System.out.println("Hit from BOTTOM");
					}
				  } //END (sprite instanceof Player)
				  else if (otherSprite instanceof Player)	
				  {
				  	((Player)otherSprite).setHitWall(true);
					if (nextRightEdge >= onl.x) 
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.LEFT);
						//System.out.println("Hit from LEFT");
					}
					else if (nl.x< onl.x + otherSprite.getBounds().width)
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.RIGHT);
						//System.out.println("Hit from RIGHT");
					}
					else if (nextBottomEdge >= onl.y) 
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.BOTTOM);
						//System.out.println("Hit from BOTTOM");
					} 
					else if (nl.y< onl.y + otherSprite.getBounds().height)
					{
						arena.spriteCollision(sprite,otherSprite, Orientation.TOP);
						//System.out.println("Hit from TOP");
					}
				  } //END else if (otherSprite instanceof Player)	
                  else arena.spriteCollision(sprite,otherSprite, Orientation.EAST);
				} //END if (sprite.willIntersect(otherSprite))
			  }//END if (otherSprite != sprite)
            }//END while(otherSprites.hasMoreElements())
        }//END while(sprites.hasMoreElements())
    }//END public void detectCollisions()
}//END public class SpriteCollisionDetector extends CollisionDetector