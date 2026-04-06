//import org.gicentre.handy.*;

//HandyRenderer h;

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

int timerLength=7200;
int timerValue = 0;

void setup() {
  fullScreen();
  background(255);
  //h = new HandyRenderer(this);
  player = new Player(width/2, height/2);

  balls = new ArrayList<Dodgeball>();
}

void draw() {
  //h.setSeed(1234);
  
  if (playing) {
    background(255);
    player.move();
    player.display();

    timerValue+=1;

    if (timerValue>=timerLength) {
      playing = false;
      won = true;
    }

    spawnTimer += 1;
    if (spawnTimer >= spawnCooldown) {
      spawnDodgeball();
      spawnTimer = 0;
    }

    if (timerValue%600==0) {
      spawnSuperDodgeball();
      spawnCooldown-=5;
    }

    for (int i = 0; i < balls.size(); i++) {
      Dodgeball b = balls.get(i);
      b.move();
      b.display();
      if (b.offScreen()) {
        balls.remove(i);
      }
      if (b.ballHit(player.position.x, player.position.y, b.position.x, b.position.y)) {
        playing = false;
        lost = true;
      }
    }

    int remainingFrames = timerLength - timerValue;
    int secondsLeft = remainingFrames / 60;
    int minutes = secondsLeft / 60;
    int seconds = secondsLeft % 60;
    String timeText = minutes + ":" + nf(seconds, 2);

    fill(0);
    textAlign(RIGHT, TOP);
    textSize(50);
    text(timeText, width - 20, 20); 
  }


  if (lost) {
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    textSize(150);
    text("GAME OVER", width/2, height/2);
    textSize(50);
    text("Press r to restart", width/2, (height/2)+120);
  }

  if (won) {
    textAlign(CENTER, CENTER);
    fill(0, 255, 0);
    textSize(150);
    text("YOU WIN", width/2, height/2);
    textSize(50);
    text("Press r to restart", width/2, (height/2)+120);
  }
}

void spawnDodgeball() {
  int side = floor(random(4));
  ball = new Dodgeball(side, player.position, false);
  balls.add(ball);
}

void spawnSuperDodgeball() {
  int side = floor(random(4));
  ball = new Dodgeball(side, player.position, true);
  balls.add(ball);
}

void restartGame() {
  won = false;
  lost = false;
  playing = true;
  spawnCooldown = 60;
  timerValue = 0;
  balls.clear();
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

  if (key == 'r' || key == 'R' && (lost || won)) {
    restartGame();
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W')
    Up = false;
  if (key == 'a' || key == 'A')
    Left = false;
  if (key == 's' || key == 'S')
    Down = false;
  if (key == 'd' || key == 'D')
    Right = false;
}
