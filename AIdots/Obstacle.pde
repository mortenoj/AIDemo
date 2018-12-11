class Obstacle {

  float x, y, width, height;
  
  Obstacle(float _a, float _b, float _c, float _d) {
    x = _a;
    y = _b;
    width = _c;
    height = _d;
  }
  
  boolean hit(float x, float y) {
  
    float x1 = this.x;
    float x2 = this.x + this.width;
    float y1 = this.y;
    float y2 = this.y + this.height;
    
    if ((x1 <= x && x <= x2) && (y1 <= y && y <= y2)) {
      return true;
    }
    
    return false;
  }
  
  void show() {
    fill(0, 0, 255);
    rect(x, y, width, height);
  }
}
