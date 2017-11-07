

class Polyline {
  
 ArrayList<Point> points = new ArrayList<Point>();
 
 void addPoint(float x, float y, long t) {
   points.add(new Point(x,y,t));
 }
 
 void render() {
   
  noFill();
  beginShape();
  for(Point p : points) {
    vertex(p.x, p.y);
  }
  endShape();
  
 }
 
 JSONArray toJSONArray() {
   JSONArray jsonPolyline = new JSONArray();
   Point previousPoint = null;
    for(Point p : points) {
      JSONObject jsonPoint = new JSONObject();
      float speed = 0;
      float length = 0;
      if(previousPoint != null) {
        length = p.distanceTo(previousPoint);
        speed = length / (p.timestamp - previousPoint.timestamp);
      }
      // x, y, z
      jsonPoint.setFloat("x",p.x);
      jsonPoint.setFloat("y",p.y);
      jsonPoint.setFloat("z",p.z);
      // speed
      jsonPoint.setFloat("s",speed); // px/ms
      // length
      jsonPoint.setFloat("l",length);
      // timestamp
      jsonPoint.setFloat("t",p.timestamp);
      
      // add Point to Polyline
      jsonPolyline.append(jsonPoint);
      
      previousPoint = p;
    }
    return jsonPolyline;
 }
 
}