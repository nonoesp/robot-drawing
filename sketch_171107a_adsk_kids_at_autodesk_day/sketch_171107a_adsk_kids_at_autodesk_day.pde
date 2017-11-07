
// Nono Martinez Alonso (nono.ma)
// Jose Luis Garcia del Castillo
// 171107

// MIT License

// TODO
// - dougles pecker (simplify polyline)
// - 

// A list of polylines to store the lines we draw
ArrayList<Polyline> polylines;

// A JSONObject to serialize our drawing to JSON
JSONObject json = new JSONObject();

void setup() {
  // Processing setup
  size(800,600);
  pixelDensity(displayDensity());
  // Init drawing
  cleanup();
}

void draw() {
  background(255);
  for(Polyline p : polylines) { p.render(); }
}

// Empty existing polylines
void cleanup() {
  polylines = new ArrayList<Polyline>();
}

// If there are polylines, remove last one
void undo() {
  int count = polylines.size();
  if(count > 0) {
    polylines.remove(count-1);
  }
}

boolean isDrawing = false;
Polyline activePolyline;

void mousePressed() {
  if(mouseButton == LEFT) {
    isDrawing = true;
    activePolyline = new Polyline();
    polylines.add(activePolyline);
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {  
    isDrawing = false;
  }
}

void mouseDragged(){
  print("x:" + mouseX + "\n\r");
  if(isDrawing) {
    activePolyline.addPoint(mouseX, mouseY);
  }
}

void mouseClicked() {
 if(mouseButton == RIGHT) {
   undo();
 }
 if(mouseButton == CENTER) {
   cleanup(); 
 }
}