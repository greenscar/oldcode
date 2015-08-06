import COLOR;
import java.applet.Applet;
import java.awt.*;
import java.awt.Color;
import java.awt.event.*;
import com.sun.j3d.utils.applet.MainFrame;
import com.sun.j3d.utils.geometry.*;
import com.sun.j3d.utils.universe.*;
import com.sun.j3d.utils.behaviors.picking.*;
import com.sun.j3d.utils.image.TextureLoader;
import javax.media.j3d.*;
import javax.vecmath.*;
import javax.media.j3d.Transform3D;

public class final356 extends Applet implements ActionListener
{
	TransformGroup transformer;
	float angleX = 0.0f, angleY = 0.0f, angleZ = 0.0f;
	Transform3D trans3d = new Transform3D();
	Transform3D total3d = new Transform3D();
	Button xButton = new Button("RotateX");
	Button yButton = new Button("RotateY");
	Button zButton = new Button("RotateZ");
	
	public BranchGroup createSceneGraph()
	{
		//create Root of Branch Graph
		BranchGroup Root = new BranchGroup();
		
		//create transform group
		transformer = new TransformGroup();		
		//Enable TRANSFORM_WRITE so our behavior can modify it at run time
		transformer.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		//add transform group to the root of the subgraph
		Root.addChild(transformer);
		
		//Create a simple leaf node and add it to scene graph
		transformer.addChild(new ColorCube(0.4));

		
		return Root;
	}
	
	public final356()
	{
		this.setLayout(new BorderLayout());
		//GraphicsConfiguration config = SimpleUniverse.getPreferedConfiguration();
		/*
	 	 * Create a Canvas3D and add it into the Frame so 3D graphics
	 	 * 	can be rendered. 
	  	 * Java3D requires a heavyweight component Canvas3D into which 
	 	 * 	to render
	 	 */
		Canvas3D my3dCanvas = new Canvas3D(null);
		this.add("Center", my3dCanvas);
		
		Panel panel = new Panel();
		panel.add(xButton);
		panel.add(yButton);
		panel.add(zButton);
		panel.setBackground(Color.black);
		this.add("North", panel);
	
		xButton.addActionListener(this);
		yButton.addActionListener(this);
		zButton.addActionListener(this);
		
		//Create Scene and Attach to Virtual Univese
		BranchGroup scene = createSceneGraph();
		scene.setCapability(BranchGroup.ALLOW_BOUNDS_READ);
		SimpleUniverse myUniverse = new SimpleUniverse(my3dCanvas);
		myUniverse.addBranchGraph(scene);
		
		//Move back a little to view Universe
		ViewingPlatform myView = myUniverse.getViewingPlatform();
		TransformGroup myViewTransformGroup = myView.getViewPlatformTransform();
		Transform3D myViewTransform = new Transform3D();
		myViewTransform.setTranslation(new Vector3f(0.0f, 0.0f, 5.0f));
		myViewTransformGroup.setTransform(myViewTransform);
		
	}
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == xButton)
		{
			angleX += Math.toRadians(5.0f);
			trans3d.rotX(angleX);
		}
		else if (e.getSource() == yButton)
		{
			angleY += Math.toRadians(5.0f);
			trans3d.rotY(angleY);
		}
		else if (e.getSource() == zButton)
		{
			angleZ += Math.toRadians(5.0f);
			trans3d.rotZ(angleZ);
			
		}
		total3d.mul(trans3d);
		transformer.setTransform(total3d);
	}
	public static void main(String[] args)
	{
		new MainFrame(new final356(), 500, 400);
	}
}