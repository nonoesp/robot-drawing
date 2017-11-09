
/* Nono Martinez Alonso (nono.ma)
 * Jose Luis Garcia del Castillo
 * 171107
 * Open-sourced under the MIT License
 */

// A list of polylines to store the lines we draw
ArrayList<Polyline> polylines;

// A list of UI buttons
ArrayList<Button> buttons;

// A JSON array to serialize our drawing to JSON
JSONObject json;

// Distance between points
float pointDistance = 4;

void setup() {
  // Processing setup
  size(800,600);
  //fullScreen(); 
  pixelDensity(displayDensity());
  // Add button
  buttons = new ArrayList<Button>();
  buttons.add(new Button("test", new Frame(50, 50, 100, 20)));
  // Init drawing
  cleanup();
}

void draw() {
  background(255);
  for(Polyline p : polylines) { p.render(); }
  for(Button b : buttons) { b.render(); }
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
  
  
  String date = str(year()).substring(2)+""+nf(month(),2)+""+nf(day(),2)+"_"+hour()+""+minute()+""+second();
  saveJSONObject(json, "data/"+date+"_drawing.json");
  saveFrame("data/"+date+"_drawing.jpg");
  print("Saved JSON file and image!\n\r");
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
     } else {
       undo();
     }
 }
 if(mouseButton == CENTER) {
   cleanup(); 
 }
 if(mouseButton == LEFT) {
   for(Button b : buttons) {
     if(b.isBelowMouse()) {
       b.click();
     }
   }
 }
}

void keyPressed() {
  if(keyCode == 83) {
    export();
  }
}