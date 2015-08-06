/*
 * PROGRAMMER: 	James Sandlin
 * COURSE: 		ACS 356-01
 * ASSIGNMENT:	Final Project
 * SEMESTER:	Fall 2000
 * DATE:		12/04/2000
 * WHAT I DO:	A cylinder rotating on the Z axis with a 
 *					directional located at (1,0,0)
 *					and a spotlight located at (0,0,-6)
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
import javax.media.j3d.*;
import javax.vecmath.*;

public class finalPart2 extends Applet
{
	public finalPart2()
	{
	
		setLayout(new BorderLayout());
		Canvas3D canvas3d = new Canvas3D(null);
		add("Center", canvas3d);		
		
		/*
		 * MOVE THE VIEWING PLATFORM BACK 7 INCHES
		 */
		SimpleUniverse simpleUni = new SimpleUniverse(canvas3d);
		ViewingPlatform myView = simpleUni.getViewingPlatform();
		TransformGroup myViewTransformGroup = myView.getViewPlatformTransform();
		Transform3D myViewTransform = new Transform3D();
		myViewTransform.setTranslation(new Vector3f(0.0f, 0.0f, 15.0f));
		myViewTransformGroup.setTransform(myViewTransform);
		
		
		BranchGroup scene = createSceneGraph(canvas3d);
		scene.compile();
		simpleUni.addBranchGraph(scene);
	}
	public BranchGroup createSceneGraph(Canvas3D canvas)
	{
		  	BranchGroup objRoot = new BranchGroup();
		
/****************************** DEFINE MATERIALS ********************************/
		/**
		 * Appearance.setMaterial(Material material) 
         * 		--- Sets the material that will be used to draw an 
		 *			object.
		 * Material(Color3f ambientColor, Color3f emissiveColor, 
		 *			Color3f diffuseColor, Color3f specularColor, 
		 *			float shininess) 
		 *		--- Defines the material to be used as an argument for 
		 *			setMaterial(Material material
		 *		---	ambientColor -> color reflected off surface in 
		 *							ambient light
		 *		---	emissiveColor -> color of light surface emits
		 *		---	diffuseColor -> color of material when illuminated
		 *		---	specularColor -> color of material under direct light
		 *		--- shininess -> NOT SHINY 1 <= X =< 128 VERY SHINY
		 */
			Appearance app1 = new Appearance();
			Material material1 = new Material(COLOR.medGrey, COLOR.black, 
									COLOR.blue, COLOR.red, 128);
		  	app1.setMaterial(material1);
			Appearance app2 = new Appearance();
			Material material2 = new Material(COLOR.medGrey, COLOR.litGrey, 
									COLOR.green, COLOR.orange, 128);
		  	app2.setMaterial(material2);
/*************************** END DEFINE MATERIALS ********************************/
				  
/********************* CREATE BOUNDING SPHERE SPECIFYING REGION ******************/
		/*
		 * THE BoundingSphere SPECIFIES WHERE IN YOUR SCENEGRAPH YOUR EFFECTS OCCUR
		 */
			Point3d origen = new Point3d(0,0,0);
		  	BoundingSphere bounds = new BoundingSphere(origen, 100);
/***************** END CREATE BOUNDING SPHERE SPECIFYING REGION ******************/
		
/******************************** CREATE LIGHTING **********************************/
						 
	//SET LIGHTING
		/**
		 * AmbientLight -> light that seems to come from all directions. 
		 *				   AmbientLight(Color3f color) 
		 * DirectionalLight -> has parallel light rays that travel in 
		 *					   one direction along the specified vector.
		 *					   DirectionalLight(Color3f color, 
		 *										Vector3f direction) 
		 * PointLight -> an attenuated light source at a fixed point in 
		 *				 space that radiates light equally in all 
		 *				 directions away from the light source.
		 *				 PointLight(Color3f color, Point3f position, 
		 *				 			Point3f attenuation) 
         *				 position - the position of the light in three-
		 *				 		space
		 * 			     attenuation - the attenutation [DEF: the intensity 
		 *							   of a light source varying by the 
		 *							   distance between the visual object and 
		 *					           Directional Light Source]
		 *							   (constant,linear,quadratic) of the light
		 *						
		 * SpotLight -> an attenuated light source at a fixed point in 
		 *				space that radiates light in a specified direction
		 *				from the light source
		 *				SpotLight(Color3f color, Point3f position, 
		 *						  Point3f attenuation, Vector3f direction,
		 *						  float spreadAngle, float concentration) 
		 *				Direction - The axis of the cone of light
		 *				Spread angle - The angle in radians between the 
		 *						direction axis and a ray along the edge 
		 *						of the cone.
		 *				Concentration - how quickly the light intensity 
		 *						attenuate ( 0 <= x <= 128)
		 * 
		 */	
		 //CREATE VARIABLES	 	
			float concentration = 0.0f;
			float spreadAngle = (float)(Math.PI);
		  	Vector3f spotLocation = new Vector3f(0.0f, 0.0f, -10.0f);			
			Vector3f lightDirection = new Vector3f(1.0f, 0.0f, 0.0f);
			Point3f attenuation = new Point3f(1.0f, 0f, 0f);
			Point3f position = new Point3f(0.0f,0.0f,10.0f);			
		 //CREATE LIGHTS
			AmbientLight ambientLit = new AmbientLight(COLOR.medGrey);
			DirectionalLight directionalLit = new DirectionalLight(COLOR.blue, lightDirection);
			DirectionalLight directionalLit2 = new DirectionalLight(COLOR.blue, lightDirection);
			SpotLight spotLit = new SpotLight(COLOR.red, position, attenuation, 
					spotLocation, spreadAngle, concentration);	
		 //SET INFUENCING BOUNDS OF LIGHTS			
			ambientLit.setInfluencingBounds(bounds);
			directionalLit.setInfluencingBounds(bounds);
			spotLit.setInfluencingBounds(bounds);
/****************************** END CREATE LIGHTING ********************************/
		 	  
/****************************** SPIN OBJECT ********************************/			 
		  	// RotationInterpolator(alpha, target, axisOfRotation, minAngle, maxAngle)
		  	Alpha alpha = new Alpha(-1, 4000);
		  	float radius = (float)(2*Math.PI);	
			TransformGroup objSpin = new TransformGroup();
		  	Transform3D rotateAxis = new Transform3D();
		 /*
		  * SET CAPABILITIES OF objSpin SO IT CAN BE WRITTEN TO
		  */
		  	objSpin.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
			objSpin.setCapability(TransformGroup.ALLOW_TRANSFORM_READ);
		 /*
		  * SET THE AXIS OF ROTATION TO THE Z AXIS
		  */
			rotateAxis.setRotation(new Quat4d(0d, 0d, 1d, 1d));
		 /**
		  * CREATE AN INSTANCE OF RotationInterpolator HOLDING THE PROPERTIES CREATED
		  *		AND USE IT AS THE PARENT OF THE ITEM YOU WISH TO SPIN 
		  */
		  	RotationInterpolator rotator = new RotationInterpolator(alpha, 
		  										objSpin, rotateAxis, 0, radius);
		  	rotator.setSchedulingBounds(bounds);
			objSpin.addChild(rotator);		
/****************************** END SPIN OBJECT ********************************/

/****************************** TRANSLATE OBJECT ********************************/
		/**
		 * THIS MUST BE CREATED SO THE MOUSE CAN BE USED TO MOVE OBJECTS AROUND
		 */
		  	Transform3D translate = new Transform3D();
		  	translate.setTranslation(new Vector3f(5.0f, 5.0f, -5.0f));
		  	TransformGroup objTranslate = new TransformGroup(translate);
			objTranslate.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
			objTranslate.setCapability(TransformGroup.ALLOW_TRANSFORM_READ);
			objTranslate.setCapability(TransformGroup.ENABLE_PICK_REPORTING);

			PickRotateBehavior pickRotate = 
					new PickRotateBehavior(objRoot, canvas, bounds);
			objRoot.addChild(pickRotate);
			
		//ADD LIGHTS AS CHILDREN HERE SO THEY WILL BE MOVED WITH OBJECT
			objTranslate.addChild(ambientLit);
			objTranslate.addChild(directionalLit);
			objTranslate.addChild(spotLit);
				
/****************************** END TRANSLATE OBJECT *****************************/
			
/***************************** CREATE MOUSE LISTENER *****************************/
			
			MouseTranslate myMouseTranslate = new MouseTranslate();
			myMouseTranslate.setTransformGroup(objTranslate);
			myMouseTranslate.setSchedulingBounds(bounds);
			
			MouseZoom myMouseZoom = new MouseZoom();
			myMouseZoom.setTransformGroup(objTranslate);
			myMouseZoom.setSchedulingBounds(bounds);
			
			MouseRotate myMouseRotate = new MouseRotate();
   			myMouseRotate.setTransformGroup(objTranslate);
   			myMouseRotate.setSchedulingBounds(bounds);
			
   			objTranslate.addChild(myMouseRotate);
			objTranslate.addChild(myMouseTranslate);
			objTranslate.addChild(myMouseZoom);
						
/*************************** END CREATE MOUSE LISTENER ***************************/
			objSpin.addChild(new Cylinder(1, 3, app1));
			objTranslate.addChild(objSpin);		  
		  	objRoot.addChild(objTranslate);
	
			//objSpin.addChild(new Sphere(.5f, app2));
			//translate.setTranslation(new Vector3f(-5.0f, -5.0f, -5.0f));
		  	//objTranslate = new TransformGroup(translate);			
		  	//objTranslate.addChild(new Sphere(.5f, app2));		  
			//objRoot.addChild(objTranslate);
			
		  	objRoot.compile();	
			
		    return objRoot;
		  
	}	
	public static void main(String[] args)
	{
		Frame frame = new MainFrame(new finalPart2(), 500, 500);
	}
}