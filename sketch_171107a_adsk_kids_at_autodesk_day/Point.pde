
class Point {
 
  float x;
  float y;
  float z;
  long timestamp;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Point(float x, float y, long t) {
    this.x = x;
    this.y = y;
    this.timestamp = t;
  }
  
  float distanceTo(Point p) {
    return sqrt(pow(p.x - this.x, 2) + pow(p.y - this.y, 2));
  }
  
}