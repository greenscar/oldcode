import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.awt.Font;
import javax.media.j3d.Transform3D;
import com.sun.j3d.utils.applet.MainFrame;
import com.sun.j3d.utils.universe.*;
import com.sun.j3d.utils.geometry.*;
import com.sun.j3d.utils.behaviors.picking.*;
import com.sun.j3d.utils.behaviors.mouse.*;
import com.sun.j3d.utils.image.TextureLoader;
import javax.media.j3d.*;
import javax.vecmath.*;

public class finalPart1 extends Applet
{
	public finalPart1()
	{
		setLayout(new BorderLayout());
		//STEP 1 CREATE Canvas3D
		Canvas3D canvas3d = new Canvas3D(null);
		add("Center", canvas3d);
		
		//STEP 2 CREATE SimpleUniverse
		SimpleUniverse simpleUni = new SimpleUniverse(canvas3d);
		
		//STEP 2a CUSTOMIZE SimpleUniverse
		simpleUni.getViewingPlatform().setNominalViewingTransform();
		
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
		BranchGroup objRoot = new BranchGroup();
		
	//CREATE BOUNDS FOR BACKGROUND
		BoundingSphere Bounds = new BoundingSphere(new Point3d(0,0,0), 1000);
	//END CREATE BOUNDS FOR BACKGROUND
		
	//CREATE BACKGROUND
		Color3f bgColor = new Color3f(0.4f, 0.4f, 0.4f);
		Background bg = new Background(bgColor);
		bg.setApplicationBounds(Bounds);
		objRoot.addChild(bg);
	//END CREATE BACKGROUND
		 
				 
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
		 * 			     attenuation - the attenutation (constant, linear,
		 *				 		quadratic) of the light
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
		 **/
		Vector3f DIRECTION = new Vector3f(-10.0f, -10.0f, -6.0f);
		Color3f WHITE = new Color3f(1f, 1f, 1f);
		
		AmbientLight ambLgt = new AmbientLight(WHITE);
		ambLgt.setInfluencingBounds(Bounds);
		DirectionalLight dirLgt = new DirectionalLight(WHITE, DIRECTION);
		dirLgt.setInfluencingBounds(Bounds);
		objRoot.addChild(ambLgt);
		objRoot.addChild(dirLgt);
	
	//END SET LIGHTING
		  
	//CREATE TRANSLATIONS
		//WILL MAKE THE SPHERES CHILDREN OF THESE TransformGroups
		
		Transform3D translate1 = new Transform3D();
		Vector3f translateVector1 = new Vector3f(-2f, 2f, -10.0f);
		translate1.setTranslation(translateVector1);
		TransformGroup objTranslate1 = new TransformGroup(translate1);
		
		Transform3D translate2 = new Transform3D();
		Vector3f translateVector2 = new Vector3f(2f, 2f, -10.0f);
		//SET CHANGES IN ORIGINAL OBJECT
		translate2.setTranslation(translateVector2);
		TransformGroup objTranslate2 = new TransformGroup(translate2);
		
		Transform3D translate3 = new Transform3D();
		Vector3f translateVector3 = new Vector3f(-2f, -2f, -10.0f);
		//SET CHANGES IN ORIGINAL OBJECT
		translate3.setTranslation(translateVector3);
		TransformGroup objTranslate3 = new TransformGroup(translate3);
		
		Transform3D translate4 = new Transform3D();
		Vector3f translateVector4 = new Vector3f(2f, -2f, -10.0f);
		//SET CHANGES IN ORIGINAL OBJECT
		translate4.setTranslation(translateVector4);
		TransformGroup objTranslate4 = new TransformGroup(translate4);
	
	//END CREATE TRANSLATIONS
	
	//CREATE APPEARANCE OBJECTS AND MATERIALS
		/**
		 * SET APPEARANCE FOR SPHERE TO BE CREATED
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
		Appearance app2 = new Appearance();
		Appearance app3 = new Appearance();
		Appearance app4 = new Appearance();
		Color3f pink = new Color3f(1.0f, 0.7f, 0.7f);
		Color3f purple = new Color3f(0.7f, 0.5f, 0.7f);
		Color3f red = new Color3f(1.0f, 0.0f, 0.0f);
		Color3f black = new Color3f(0.0f, 0.0f, 0.0f);
		//Material(ambientColor, emissiveColor, diffuseColor, specularColor);
		Material material1 = new Material(pink, black, black, black, 100);
		Material material2 = new Material(black, purple, black, black, 100);
		Material material3 = new Material(black, black, purple, black, 100);
		Material material4 = new Material(black, black, black, purple, 100);
		
		app1.setMaterial(material1);
		app2.setMaterial(material2);
		app3.setMaterial(material3);
		app4.setMaterial(material4);
	//END CREATE APPEARANCE OBJECTS AND MATERIALS
		
	//CREATE SPHERE OBJECTS USING ABOVE APPEARANCES
		
		objTranslate1.addChild(createSphere(1, 0,0,.5,app1));
		objRoot.addChild(objTranslate1);
		
		objTranslate2.addChild(createSphere(1, 0,0,.5,app2));
		objRoot.addChild(objTranslate2);
		
		objTranslate3.addChild(createSphere(1, 0,0,.5,app3));
		objRoot.addChild(objTranslate3);
		
		objTranslate4.addChild(createSphere(1, 0,0,.5,app4));
		objRoot.addChild(objTranslate4);
	
	//PERFORM OPTIMIZATIONS
		objRoot.compile();
	//END PERFORM OPTIMIZATIONS	 
		return objRoot;	
	}
	private Group createSphere(float radius, int xPos, int yPos, double scale, Appearance app)
	{
		 Transform3D t = new Transform3D();
		 t.set(scale, new Vector3d(xPos, yPos, 0.0));
		 TransformGroup objTrans = new TransformGroup();
		 Primitive obj = null;
		 obj = (Primitive) new Sphere(radius, Sphere.GENERATE_NORMALS | 
		 							Sphere.GENERATE_TEXTURE_COORDS, 40, app);
		 //add this obj to scene graph
		 objTrans.addChild(obj);
		 return objTrans;
	}
	
	public static void main(String[] args)
	{
		Frame frame = new MainFrame(new finalPart1(), 500, 500);
	}
}