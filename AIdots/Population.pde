
class Population {
  Dot[] dots;
  float fitnessSum;
  int generation = 1;
  int bestDot = 0;
  
  int minStep = 500;
  
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }
  
  void show() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].show();
    }
  }
  
  void addObstacle(float a, float b, float c, float d) {
    obstacles.add(new Obstacle(a, b, c, d));
  }
  
  
  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else if (hitObstacle(dots[i].pos.x, dots[i].pos.y)) {
        dots[i].dead = true;
      } else { 
        dots[i].update();
      }
    }
  }
  
  boolean hitObstacle(float x, float y) {
    
    for (int i = 0; i < obstacles.size(); i++) {
      if (obstacles.get(i).hit(x, y)) {
        return true;
      }
    }
    return false;
  }
  
  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  
  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }
  
  void naturalSelection() {
    int nextgen = generation + 1;
    println("Current generation: " + nextgen);
    
    // dots for new generation
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].getBaby();
    newDots[0].isBest = true;
    
    for (int i = 1; i < newDots.length; i++) {
      // select parent based on fitness
      Dot parent = selectParent();
      
      // get baby from parent
      newDots[i] = parent.getBaby();
    }
    
    dots = newDots.clone();
    generation++;
  }
  
  void mutateBabies() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
    
  
  }
  
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }
  
  
  Dot selectParent() {
    // Random value which is more likely to be in the dot with the largest fitness
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for (int i = 0; i< dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }
    return null;
  }

  void setBestDot() {
    // Finding the best dot in order to put the best dot directly into the next generation
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    
    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
    }
  }
  

  
}
