Population dots;
PVector goal = new PVector(400, 10);

void setup() {
  size(800,800);
  dots = new Population(400);
  
  dots.addObstacle(200, 200, 800, 10);
  dots.addObstacle(0, 400, 600, 10);
  dots.addObstacle(200, 600, 800, 10);
}




void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  for (int i = 0; i < dots.obstacles.size(); i++) {
    dots.obstacles.get(i).show();
  }
  
  // Goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  if (dots.allDotsDead()) {
    // genetic algorithm
    dots.calculateFitness();
    dots.naturalSelection();
    dots.mutateBabies();
  } else {
    // Draw dots
    dots.update();
    dots.show();
  }
  
}
