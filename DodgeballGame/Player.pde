class Player {
  Float speed = 10f;
  PVector position;
  PVector input;

  Player(float x, float y) {
    position = new PVector(x, y);
    input = new PVector(x, y);
  }

  void move() {
    input.set(0, 0);
    if (Up)
      input.y -= 1;
    if (Left)
      input.x -= 1;
    if (Down)
      input.y += 1;
    if (Right)
      input.x += 1;

    input.normalize();
    position.add(input.mult(speed));

    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }

  void display() {
    fill(0);
    ellipse(position.x, position.y, 15, 15);
  }
}
