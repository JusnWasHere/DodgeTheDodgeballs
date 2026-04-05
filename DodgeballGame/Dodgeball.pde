class Dodgeball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector direction;
  Float speed;
  Boolean isSuper = false;

  Dodgeball(int s, PVector playerPosition, boolean superBall) {
    isSuper = superBall;
    direction = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    if (s==0)
      position = new PVector(random(width), -20);
    if (s==1)
      position = new PVector(random(width), height+20);
    if (s==2)
      position = new PVector(+20, random(height));
    if (s==3)
      position = new PVector(width+20, random(height));

    direction = PVector.sub(playerPosition, position);
    direction.normalize();

    if (isSuper)
      speed = 15f;
    else
      speed = 6f;

    velocity = PVector.mult(direction, speed);
    acceleration = PVector.mult(direction, 0.1);
  }

  void move() {
    velocity.add(acceleration);
    position.add(velocity);
  }

  void display() {
    if (isSuper) {
      fill(0, 0, 255);
      ellipse(position.x, position.y, 30, 30);
    } else {
      fill(255, 0, 0);
      ellipse(position.x, position.y, 20, 20);
    }
  }

  boolean offScreen() {
    if (position.x < -80 || position.x > width + 80 || position.y < -80 || position.y > height + 80)
      return true;// if it is the boolean is true
    return false;
  }

  boolean ballHit(float pX, float pY, float bX, float bY) {
    return dist(pX, pY, bX, bY) <= 20;
  }
}
