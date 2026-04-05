boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = false;

ArrayList<Dodgeball> balls;
Dodgeball ball;

Player player;

int spawnCooldown = 60;
int spawnTimer = 0;

boolean playing = true;
boolean won = false;
boolean lost = false;

void setup() {
  fullScreen();
  background(255);
  player = new Player(width/2, height/2);
  
  balls = new ArrayList<Dodgeball>();
}

void draw() {
  background(255);
  player.move();
  player.display();
  
  spawnTimer += 1;
  if(spawnTimer >= spawnCooldown){
    spawnDodgeBall();
    spawnTimer = 0;
  }
  
  for (int i = 0; i < balls.size(); i++) {
    Dodgeball b = balls.get(i);
    b.move();
    b.display();
    if(b.ballHit(player.position.x, player.position.y, b.position.x, b.position.y)){
      playing = false;
      lost = true;
    }
  }
  
  if(lost){
    fill(255, 0, 0);
    textSize(150);
    text("GAME OVER", width/2, height/2);
    textSize(100);
    text("Press r to restart", (width/2), (height/2)+50);
  }
  
}

void spawnDodgeBall(){
  int side = floor(random(4));
  ball = new Dodgeball(side, player.position, false);
  balls.add(ball);
  
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
    
  if(key == 'r' || key == 'R' && lost || won){
    //restartGame();
  }
  
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
