/*
 * PROGRAMMER: 	JAMES SANDLIN
 * CLASS:		ACS 356-01 
 * ASSIGNMENT:	FINAL PROJECT
 * LANGUAGE:	JAVA3D
 * DESCRIPTION: USING THE ARROW KEYS YOU CAN NAVIGATE ABOUT THE VIRTUAL
 *					WORLD
 *				USING THE MOUSE BUTTONS, YOU CAN ZOOM, ROTATE, AND 
 *					TRANSLATE THE SPHERE AND THE DUMBELL SHAPE
 *				LIGHTING IS USED TO CAUSE THE EFFECTS ON THE OBJECTS
 */
import COLOR;
import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import javax.media.j3d.Transform3D;
import com.sun.j3d.utils.applet.MainFrame;
import com.sun.j3d.utils.universe.*;
import com.sun.j3d.utils.geometry.*;
import com.sun.j3d.utils.picking.behaviors.*;
import com.sun.j3d.utils.behaviors.mouse.*;
import com.sun.j3d.utils.behaviors.keyboard.*;
import javax.media.j3d.*;
import javax.vecmath.*;
import java.util.Enumeration;

public class finalPart3 extends Applet
{
	public finalPart3()
	{
	
		setLayout(new BorderLayout());
		Canvas3D canvas3d = new Canvas3D(null);
		add("Center", canvas3d);		
		
		/*
		 * MOVE THE VIEWING PLATFORM BACK 7 INCHES
		 */
		SimpleUniverse simpleUni = new SimpleUniverse(canvas3d);
				
		BranchGroup scene = createSceneGraph(canvas3d, simpleUni);
		scene.compile();
		simpleUni.addBranchGraph(scene);
	}
	public BranchGroup createSceneGraph(Canvas3D canvas, SimpleUniverse simpleUni)
	{
		  	BranchGroup objRoot = new BranchGroup();
			TransformGroup objMouseMove = null;			
			Transform3D transform = new Transform3D();
			TransformGroup vpTrans = null;		
			
			//VARIABLES NEEDED FOR MOUSE LISTENER
			MouseTranslate myMouseTranslate = null;
			MouseZoom myMouseZoom = null;
			MouseRotate myMouseRotate = null;			
			
			//VARIABLES TO BE USED FOR PICKING
			PickTranslateBehavior pickTranslate = null;
        	PickRotateBehavior pickRotate = null;
			PickZoomBehavior pickZoom = null;
			        
		  	Point3d origen = new Point3d(0,0,0);
		  	BoundingSphere bounds = new BoundingSphere(origen, 1000);
			
/**************************** CREATE MATERIALS *********************************/			
			Appearance app1 = new Appearance();
		  	Material material1 = new Material(COLOR.medGrey, COLOR.black, 
		  							COLOR.blue, COLOR.red, 90);
		  	app1.setMaterial(material1);
			
			Appearance app2 = new Appearance();
		  	Material material2 = new Material(COLOR.medGrey, COLOR.black, 
		  							COLOR.green, COLOR.orange, 90);
		  	app2.setMaterial(material2);
/*************************** END CREATE MATERIALS ******************************/

/******************************* CREATE LAND ***********************************/
			Vector3f translateLand = new Vector3f();
			vpTrans = simpleUni.getViewingPlatform().getViewPlatformTransform();
			translateLand.set(0.0f, .3f, 30.0f);
			transform.setTranslation(translateLand);
			vpTrans.setTransform(transform);
			KeyNavigatorBehavior keyNavBeh = new KeyNavigatorBehavior(vpTrans);
			keyNavBeh.setSchedulingBounds(bounds);
			objRoot.addChild(keyNavBeh);			
/****************************** CREATE LIGHTING ********************************/
		
		 //CREATE VARIABLES	 	
			float concentration = 0.0f;
			float spreadAngle = (float)(Math.PI);
		  	Vector3f spotLocation = new Vector3f(0.0f, 0.0f, -10.0f);			
			Vector3f lightDirection = new Vector3f(1.0f, 0.0f, 0.0f);
			Point3f attenuation = new Point3f(1.0f, 0f, 0f);
			Point3f position = new Point3f(0.0f,0.0f,10.0f);			
		 //CREATE LIGHTS
			AmbientLight ambientLit = new AmbientLight(COLOR.white);
			DirectionalLight directionalLit = new DirectionalLight(COLOR.blue, lightDirection);
			DirectionalLight directionalLit2 = new DirectionalLight(COLOR.orange, lightDirection);
			SpotLight spotLit = new SpotLight(COLOR.green, position, attenuation, 
					spotLocation, spreadAngle, concentration);	
		 	SpotLight spotLit2 = new SpotLight(COLOR.red, position, attenuation, 
					spotLocation, spreadAngle, concentration);	
		 
		 //SET INFUENCING BOUNDS OF LIGHTS			
			ambientLit.setInfluencingBounds(bounds);
			directionalLit.setInfluencingBounds(bounds);
			spotLit.setInfluencingBounds(bounds);
			directionalLit2.setInfluencingBounds(bounds);
			spotLit2.setInfluencingBounds(bounds);
/**************************** END CREATE LIGHTING *****************************/

/******************************* CREATE TEXT **********************************/			
			Font3D font3d = new Font3D(new Font("Helvetica", Font.PLAIN, 10),
											new FontExtrusion());
			Text3D textGeom = new Text3D(font3d, new String("Java3D"),
											new Point3f(-10.0f, 3.0f, -50.0f));
			Shape3D textShape = new Shape3D(textGeom);
			objRoot.addChild(textShape);	
/**************************** CREATE MOUSE LISTENER ***************************/
		  	transform.setTranslation(new Vector3f(5.0f, 0.0f, -5.0f));
		  	objMouseMove = new TransformGroup(transform);
		  	objMouseMove.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		  	objMouseMove.setCapability(TransformGroup.ALLOW_TRANSFORM_READ);
		    objMouseMove.setCapability(TransformGroup.ENABLE_PICK_REPORTING);
/************************* END CREATE MOUSE LISTENER **************************/
			
		//	objMouseMove.addChild(spotLit);
			objMouseMove.addChild(directionalLit);
			objRoot.addChild(objMouseMove);
			objMouseMove.addChild(new Sphere(0.5f, app1));
/**************************** ENABLE MOUSE PICKING ****************************/
			pickTranslate = new PickTranslateBehavior(objRoot, canvas, bounds);
			objRoot.addChild(pickTranslate);
			
			pickRotate = new PickRotateBehavior(objRoot, canvas, bounds);
        	objRoot.addChild(pickRotate);
			
			pickZoom = new PickZoomBehavior(objRoot, canvas, bounds);
        	objRoot.addChild(pickZoom);
/************************** END ENABLE MOUSE PICKING **************************/

/**************************** CREATE MOUSE LISTENER ***************************/
		  	transform.setTranslation(new Vector3f(-5.0f, 0.0f, -5.0f));
		  	objMouseMove = new TransformGroup(transform);
		  	objMouseMove.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		  	objMouseMove.setCapability(TransformGroup.ALLOW_TRANSFORM_READ);
		    objMouseMove.setCapability(TransformGroup.ENABLE_PICK_REPORTING);
/************************* END CREATE MOUSE LISTENER **************************/

/***************************** CREATE ROTATOR**********************************/
			TransformGroup objSpin = new TransformGroup();
			Transform3D spinAxis = new Transform3D();
			objSpin.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
			Alpha alpha = new Alpha(-1, 4000);
			float radius = (float)(2*Math.PI);
			spinAxis.setRotation(new Quat4d(0.3d, 1.0d, 0.0d, 1d));
			RotationInterpolator rotOnX = new RotationInterpolator(alpha, objSpin, 
														spinAxis, 0, radius);
			rotOnX.setSchedulingBounds(bounds);
			objSpin.addChild(rotOnX);
/************************** END CREATE ROTATOR*********************************/


/****************** CREATE CYLINDER SHAPE AND ADD TO IMAGE ********************/
			objMouseMove.addChild(spotLit2);

			Transform3D translate = new Transform3D();
			Transform3D rotate = new Transform3D();
			
			translate.set(new Vector3f(0f, 3.0f, 0.0f));
			TransformGroup topTranslate = new TransformGroup(translate);
			Cone topCone = new Cone(2.0f, 2.0f);
			topCone.setAppearance(app2);          
			topTranslate.addChild(topCone);
			objMouseMove.addChild(topTranslate);
		
	// CREATE BOTTOMCONE
			translate.set(new Vector3f(0f, -3.0f, 0.0f));
			TransformGroup bottomTranslate = new TransformGroup(translate);
			Cone bottomCone = new Cone(2.0f, 2.0f);
			bottomCone.setAppearance(app2);
		// TURN THIS CONE UPSIDE DOWN
			rotate.rotZ(Math.PI);
			TransformGroup bottomRotate = new TransformGroup(rotate);
			bottomRotate.addChild(bottomCone);
			bottomTranslate.addChild(bottomRotate);
			objMouseMove.addChild(bottomTranslate);
		// END TURN THIS CONE UPSIDE DOWN
			objMouseMove.addChild(new Cylinder(0.6f, 5.7f, app2));
	// END CREATE BOTTOMCONE
			
	// CREATE ITEM TO ROTATE AROUND
			translate.set(new Vector3f(3.0f, -1.0f, 1.0f));
			TransformGroup electron = new TransformGroup(translate);
			Sphere electronSphere = new Sphere(0.6f, app1);
			electron.addChild(electronSphere);
			electron.addChild(directionalLit2);
			objSpin.addChild(electron);
	// END CREATE ITEM TO ROTATE AROUND			
			
			
			objMouseMove.addChild(objSpin);
			objRoot.addChild(objMouseMove);

/******************* CREATE CYLINDER SHAPE AND ADD TO IMAGE *******************/
			objRoot.addChild(createLand());
			objRoot.addChild(ambientLit);
			objRoot.compile();
			return objRoot;
	}
	
    Shape3D createLand(){
        LineArray landGeom = new LineArray(44, GeometryArray.COORDINATES
                                            | GeometryArray.COLOR_3);
        float l = -50.0f;
        for(int c = 0; c < 44; c+=4){

            landGeom.setCoordinate( c+0, new Point3f( -100.0f, -1.0f,  l ));
            landGeom.setCoordinate( c+1, new Point3f(  100.0f, -1.0f,  l ));
            landGeom.setCoordinate( c+2, new Point3f(   l   , -1.0f, -100.0f ));
            landGeom.setCoordinate( c+3, new Point3f(   l   , -1.0f,  100.0f ));
            l += 10.0f;
        }

        Color3f c = new Color3f(0.7f, 0.1f, 0.7f);
        for(int i = 0; i < 44; i++) landGeom.setColor( i, c);

        return new Shape3D(landGeom);
    }

	public static void main(String[] args)
	{
		Frame frame = new MainFrame(new finalPart3(), 500, 500);
	}
}
	
		