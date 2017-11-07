

class Polyline {
  
 ArrayList<PVector> points = new ArrayList<PVector>();
 
 void addPoint(float x, float y) {
   points.add(new PVector(x,y));
 }
 
 void render() {
   
   noFill();
  beginShape();
  for(PVector p : points) {
    vertex(p.x, p.y); 
  }
  endShape();
  
 }
 
}