
/* Nono Martinez Alonso (nono.ma)
 * Jose Luis Garcia del Castillo
 * 171107
 * Open-sourced under the MIT License
 */

// A list of polylines to store the lines we draw
ArrayList<Polyline> polylines;

// A list of UI buttons
ArrayList<Button> buttons;
Button exportButton;
Button newButton;
Button undoButton;
float buttonWidth = 60;
float buttonHeight = 23;

// A JSON array to serialize our drawing to JSON
JSONObject json;

// Distance between points
float pointDistance = 4;

boolean shouldSaveFrame = false;

void setup() {
  // Processing setup
  size(800,600);
  //fullScreen(); 
  pixelDensity(displayDensity());
  // Add UI buttons
  buttons = new ArrayList<Button>();
  
  exportButton = new Button("Export", new Frame(50, 50, buttonWidth, buttonHeight), "EXPORT");
  newButton = new Button("New", new Frame(50, 80, buttonWidth, buttonHeight), "NEW");
  undoButton = new Button("Undo", new Frame(50, 110, buttonWidth, buttonHeight), "UNDO");
  
  buttons.add(exportButton);
  buttons.add(newButton);
  buttons.add(undoButton);
  
  // Init drawing
  cleanup();
}

void draw() {
  background(255);
  for(Polyline p : polylines) { p.render(); }
  if(!shouldSaveFrame) {
    // Render controls (only when we are not exporting the frame)
    for(Button b : buttons) { b.render(); }
  } else {
    // Save a snapshot of the current drawing
    String date = str(year()).substring(2)+""+nf(month(),2)+""+nf(day(),2)+"_"+hour()+""+minute()+""+second();
    saveFrame("data/"+date+"_drawing.jpg");
    shouldSaveFrame = false;
  }
}

void updateUI() {
  if(polylines.size() == 0) {
    exportButton.isEnabled = false;
    newButton.isEnabled = false;
    undoButton.isEnabled = false;
  } else {
    exportButton.isEnabled = true;
    newButton.isEnabled = true;
    undoButton.isEnabled = true;
  }
}

// COMMANDS

// Empty existing polylines
void cleanup() {
  polylines = new ArrayList<Polyline>();
  updateUI();
}

// If there are polylines, remove last one
void undo() {
  int count = polylines.size();
  if(count > 0) {
    polylines.remove(count-1);
  }
  updateUI();
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
  
  shouldSaveFrame = true;
  String date = str(year()).substring(2)+""+nf(month(),2)+""+nf(day(),2)+"_"+hour()+""+minute()+""+second();
  saveJSONObject(json, "data/"+date+"_drawing.json");
  print("Saved JSON file and image!\n\r");
}

boolean isDrawing = false;
Polyline activePolyline;

void mousePressed() {
  
   isButtonPressed = false;
   for(Button b : buttons) {
     if(b.isBelowMouse()) {
       isButtonPressed = true;
     }
   }
   
  if(mouseButton == LEFT && !isButtonPressed) {
    isDrawing = true;
    activePolyline = new Polyline();
    polylines.add(activePolyline);
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {  
    isDrawing = false;
  }
  updateUI();
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

boolean isButtonPressed = false;

void mouseClicked() {
 if(mouseButton == RIGHT) {
       undo();
 }
 if(mouseButton == CENTER) {
   cleanup(); 
 }
 if(mouseButton == LEFT) {
   for(Button b : buttons) {
     if(b.isBelowMouse()) {
       
       b.click();
       
       if(b.action == "EXPORT") {
         export();
       } else if(b.action == "NEW") {
         cleanup();
       } else if(b.action == "UNDO") {
         undo();
       }
     }
   }
 }
}

void keyPressed() {
  if(keyCode == 83) {
    export();
  }
}