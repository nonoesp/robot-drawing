
/* Nono Martinez Alonso (nono.ma)
 * Jose Luis Garcia del Castillo
 * 171107
 * Open-sourced under the MIT License
 */

// A list of polylines to store the lines we draw
ArrayList<Polyline> polylines;

// A JSON array to serialize our drawing to JSON
JSONObject json;

// Distance between points
float pointDistance = 4;

void setup() {
  // Processing setup
  fullScreen(); 
  pixelDensity(displayDensity());
  //size(800,600);
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

void export() {
  json = new JSONObject();
  JSONArray jsonArray = new JSONArray();
  for(Polyline p : polylines) {
    JSONObject j = new JSONObject();
    j.setJSONArray("points", p.toJSONArray());
    //j.setInt("x",1);
    jsonArray.append(j);
  }
  json.setJSONArray("polylines",jsonArray);
  saveJSONObject(json, "data/drawing.json");
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

long lastEventTimestamp = 0;
Point lastPoint = null;

void mouseDragged(){
  long millis = millis();
  if(lastEventTimestamp < millis) {
    if(isDrawing) {
      Point p = new Point(mouseX, mouseY, millis);
      if(lastPoint == null || lastPoint.distanceTo(p) > pointDistance) {
        activePolyline.addPoint(p);
        lastEventTimestamp = millis;
        lastPoint = p;
      }
    }
  }
}

void mouseClicked() {
 if(mouseButton == RIGHT) {
     if(mouseX < 150) {
       export();
       print("Saved JSON file!\n\r");
     } else {
       undo();
     }
 }
 if(mouseButton == CENTER) {
   cleanup(); 
 }
}

void keyPressed() {
  export();
  print("Saved JSON file!\n\r");
}