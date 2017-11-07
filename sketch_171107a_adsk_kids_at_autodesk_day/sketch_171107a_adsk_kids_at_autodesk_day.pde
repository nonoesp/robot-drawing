
// Nono Martinez Alonso (nono.ma)
// Jose Luis Garcia del Castillo
// 171107

// MIT License

// TODO
// - dougles pecker (simplify polyline)
// - 

// A list of polylines to store the lines we draw
ArrayList<Polyline> polylines;

// A JSON array to serialize our drawing to JSON
JSONObject json;

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
  saveJSONObject(json, "data/new.json");
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

void mouseDragged(){
  long millis = millis();
  if(lastEventTimestamp < millis) {
    if(isDrawing) {
      activePolyline.addPoint(mouseX, mouseY, millis());
      lastEventTimestamp = millis;
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