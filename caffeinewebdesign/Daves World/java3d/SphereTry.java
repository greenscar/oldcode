/*
 * PROGRAMMER: 	James Sandlin
 * COURSE: 		ACS 356-01
 * ASSIGNMENT:	Final Project
 * SEMESTER:	Fall 2000
 * DATE:		12/04/2000
 * WHAT I DO: A sphere that responds to mouse clicks/movement
 */
 
import COLOR;
import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import javax.media.j3d.Transform3D;
import com.sun.j3d.utils.applet.MainFrame;
import com.sun.j3d.utils.universe.*;
import com.sun.j3d.utils.geometry.*;
import com.sun.j3d.utils.behaviors.picking.*;
import com.sun.j3d.utils.behaviors.mouse.*;
import com.sun.j3d.utils.image.TextureLoader;
import javax.media.j3d.*;
import javax.vecmath.*;


public class SphereTry extends Applet
{
	public SphereTry()
	{
		setLayout(new BorderLayout());
		//STEP 1 CREATE Canvas3D
		Canvas3D canvas3d = new Canvas3D(null);
		add("Center", canvas3d);
		
		//STEP 2 CREATE SimpleUniverse
		SimpleUniverse simpleUni = new SimpleUniverse(canvas3d);
		
		//STEP 2a CUSTOMIZE SimpleUniverse
		//MOVE YOURSELF BACK 
		ViewingPlatform myView = simpleUni.getViewingPlatform();
		TransformGroup myViewTransformGroup = myView.getViewPlatformTransform();
		Transform3D myViewTransform = new Transform3D();
		myViewTransform.setTranslation(new Vector3f(0.0f, 0.0f, 5.0f));
		myViewTransformGroup.setTransform(myViewTransform);
		
		//simpleUni.getViewingPlatform().setNominalViewingTransform();
		
		//STEP 3 CONSTRUCT content branch graph
		BranchGroup scene = createSceneGraph(simpleUni);
		
		//STEP 4 COMPILE content branch graph
		//			Locale of SimpleUniverse
		scene.compile();
		
		//STEP 5 INSERT content branch graph into
		simpleUni.addBranchGraph(scene);
	}
	public BranchGroup createSceneGraph(SimpleUniverse su)
	{ 		 
		 //CREATE ROOT OF BRANCH GRAPH
		 BranchGroup objRoot = new BranchGroup();
		 BoundingSphere mouseBounds = null;
		 TransformGroup vpTrans = null;
		 
		 vpTrans = su.getViewingPlatform().getViewPlatformTransform();
		 
		 
		 //CREATE TRANSFORM GROUP TO SCALE ALL OBJECTS
		 TransformGroup objScale = new TransformGroup();
		 Transform3D t3d = new Transform3D();
		 t3d.setScale(.5);
		 objScale.setTransform(t3d);
		 objRoot.addChild(objScale);
		 
		 //CREATE BOUNDS FOR BACKGROUND AND BEHAVIORS
		 mouseBounds = new BoundingSphere(new Point3d(0,0,0), 400);
		 
		 //CREATE BACKGROUND
		 Background bg = new Background(COLOR.darkGrey);
		 bg.setApplicationBounds(mouseBounds);
		 objRoot.addChild(bg);
		 
		 //CREATE OBJECTS WITH BEHAVIOR AND ADD TO SCENE GRAPH
		 /*
		  * Material(COLOR3f ambientCOLOR, COLOR3f emissiveCOLOR, 
		  *			COLOR3f diffuseCOLOR, COLOR3f specularCOLOR, 
		  *			float shininess) 
		  */
		 Appearance app = new Appearance();
		 app.setMaterial(new Material(COLOR.red, COLOR.medGrey, 
		 					COLOR.blue, COLOR.orange, 30.0f));
				 
		 //SET LIGHTING
		 Vector3f lDir1 = new Vector3f(5.0f, 5.0f, -5.0f);
		  
		 /*
		  * IN THE FOLLOWING LINES, I HAD AN AMBIENT LIGHT, HOWEVER, I DID NOT
		  * LIKE THE RESULTS IT GAVE ME SO I JUST DOCUMENTED IT OUT SO I MAY
		  * USE IT LATER
		  */ 
		 //AmbientLight aLgt = new AmbientLight(COLOR.white);
		 //aLgt.setInfluencingBounds(mouseBounds);
		 //objRoot.addChild(aLgt);
		 DirectionalLight lgt1 = new DirectionalLight(COLOR.white, lDir1);
		 lgt1.setInfluencingBounds(mouseBounds);
		 objRoot.addChild(lgt1);
	      
		 objScale.addChild(createSphere(3f, app));
		 
		 MouseTranslate myMouseTranslate = new MouseTranslate(MouseBehavior.INVERT_INPUT);
		 myMouseTranslate.setTransformGroup(vpTrans);
		 myMouseTranslate.setSchedulingBounds(mouseBounds);
		 objRoot.addChild(myMouseTranslate);
		 
		 //PERFORM OPTIMIZATIONS
		 objRoot.compile();
		 
		 return objRoot;
	}
	private Group createSphere(float radius, Appearance app)
	{
		 TransformGroup objTrans = new TransformGroup();
		 objTrans.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		 Primitive obj = null;
		 obj = (Primitive) new Sphere(radius, Sphere.GENERATE_NORMALS | 
		 							Sphere.GENERATE_TEXTURE_COORDS, 40, app);
		 //add this obj to scene graph
		 objTrans.addChild(obj);
		 return objTrans;
	}
	
	public static void main(String[] args)
	{
		Frame frame = new MainFrame(new SphereTry(), 500, 500);
	}
}