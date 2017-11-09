
class Location {
  float x;
  float y;
  
  Location(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Size {
  float w;
  float h;
  
  Size(float w, float h) {
    this.w = w;
    this.h = h;
  }
}

class Frame {
  Location origin;
  Size size;
  
  Frame(float x, float y, float w, float h) {
    this.origin = new Location(x,y);
    this.size = new Size(w, h);
  }
}

class Button {
  
  String label = "Button";
  Frame frame;
  color backgroundColor = color(240);
  float borderThickness = 0.5;
  float borderColor = color(180);
  float padding = 5;
  
  Button(String label) {
    this.label = label; 
  }
  
  Button(String label, Frame frame) {
    this.label = label;
    this.frame = frame;
  }
  
  void click() {
    println("Button '" + label + "' was clicked");  
  }
  
  boolean isBelowMouse() {
    float p = padding;
    Location o = frame.origin;
    Size s = frame.size;
    float xmin = o.x - p;
    float ymin = o.y - p;
    float xmax = o.x + s.w + p;
    float ymax = o.y + s.h + p;
    
    if(mouseX > xmin && mouseX < xmax && mouseY > ymin && mouseY < ymax) {
      return true; 
    }
    
    return false;
  }
  
  void render() {
    pushMatrix();
    fill(backgroundColor);
    if(isBelowMouse()) {
      strokeWeight(borderThickness*1.5);
    } else {
      strokeWeight(borderThickness);
    }
    stroke(borderColor);
    rect(frame.origin.x, frame.origin.y, frame.size.w, frame.size.h);
    popMatrix();
  }
}