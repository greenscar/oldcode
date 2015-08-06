/* MazeGenTest.java */
/* 04/03/01 8PM */
import java.net.URL;
import java.applet.Applet;
import java.awt.*;
import java.awt.Panel;

public class MazeGenTest extends Applet {
	public void init() {
		this.resize(600,670);
		setLayout(new BorderLayout());
		add(new Label("MazeGen")); 
		add(new MazeGenTestPanel(this), "Center");
		add(new SouthPanel(this), "South");
    } 
	
}
class SouthPanel extends Panel
{
	public SouthPanel(Applet applet){
		TextArea ta = new TextArea("Your code here", 10, 15, TextArea.SCROLLBARS_VERTICAL_ONLY);
		Button buildIt = new Button("Build It");
		//setLayout(new BorderLayout());
		add(buildIt, "North");
		add(ta, "Center");
	}
	public void update(Graphics g) {
		paint(g);
	}
}
	

class MazeGenTestPanel extends Panel {
    public MazeGenTestPanel(Applet applet) {
        setLayout(new BorderLayout());
        add(new MazeGenPlayfield(applet), "Center"); 
    }
	public void update(Graphics g) {
		paint(g);
	}
}
