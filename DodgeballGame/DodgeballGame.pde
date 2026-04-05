boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = false;

Player player;

void setup() {
  fullScreen();
  background(255);
  player = new Player(width/2, height/2);
}

void draw() {
  background(255);
  player.move();
  player.display();
}

void keyPressed() {
  if (key == 'w' || key == 'W')
    Up = true;
  if (key == 'a' || key == 'A')
    Left = true;
  if (key == 's' || key == 'S')
    Down = true;
  if (key == 'd' || key == 'D')
    Right = true;
}

void keyReleased(){
  if (key == 'w' || key == 'W')
    Up = false;
  if (key == 'a' || key == 'A')
    Left = false;
  if (key == 's' || key == 'S')
    Down = false;
  if (key == 'd' || key == 'D')
    Right = false;
}
