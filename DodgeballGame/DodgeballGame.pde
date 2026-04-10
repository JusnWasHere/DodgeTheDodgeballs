//import org.gicentre.handy.*;

//HandyRenderer h;

//all commented out h's are if you want to turn on hnady renderer, it works but lags out game and its already pretty tough so wouldnt recommend

//Booleans to track directional inputs(WASD)
boolean Up = false;
boolean Left = false;
boolean Down = false;
boolean Right = false;

ArrayList<Dodgeball> balls;//array list so that you can spawn as many balls as you want and have thme running at the same time
Dodgeball ball;//initializes dodgeball class

Player player;//initializes player class

int spawnCooldown = 60;//cooldown between dodgeballs spawning, 60 because there is 60 frames per second
int spawnTimer = 0;//timer that will count up to know when dosgeballs need to spawn

//Booleans to track game state
boolean playing = true;
boolean won = false;
boolean lost = false;

int timerLength=7200;//length of time that needs to pass before player wins, 7200 because its 120x60 and I want the player to have to survive for 2 minutes
int timerValue = 0;//timer that will count up and check when itr has reached length

void setup() {
  fullScreen();//makes canvas size the size of players screen/monitor
  background(255);//sets background to white
  //h = new HandyRenderer(this);
  player = new Player(width/2, height/2);//spawns player in middle of screen, using width and height variables because using fullscreen and dimensions vary

  balls = new ArrayList<Dodgeball>();//creates array list
}

void draw() {
  //h.setSeed(1234);

  if (playing) {//only runs the code when in "playing" state, this makes sure the player cant move, balls dont spawn, and timer goes when the player has won or lost and the game is paused
    background(255);//sets background to white every frame so trail isnt left behind by moving objects
    player.move();//runs move function in player class every frame so that the player character can always move when inputs are being detected
    player.display();//draws the player in the new position every frame so you can actually see the player character moving

    timerValue+=1;//increases the timer value by 1 every frame, which means 60 every second to keep track of time in game

    if (timerValue>=timerLength) {//checks if the timer value is greater than or equal to the length, basically activating when 2 minutes has passed
      playing = false;//makes playing state false pausing all functionality in its conditional statement
      won = true;//turns win to true activating win game state
    }

    spawnTimer += 1;//increases the timer value by 1 every frame, which means 60 every second. so 1 dodgeball spawns every second
    if (spawnTimer >= spawnCooldown) {//checks if the spawn timer value is greater than or equal to the cooldown length, basically activating every second
      spawnDodgeball();//runs the spawn dodgeball function, spawns a dodgeball
      spawnTimer = 0;//resets the timer so it doesnt continue to spawn dodgeballs every frame
    }

    if (timerValue%600==0) {//timerValue(7200)%600 will always equal 0 when its a multiple of 600 which divided by 60 is 10. basically checking every time 10 seconds has passed
      spawnSuperDodgeball();//runs the spawn super dodgeball function, spawns a super dodgeball
      spawnCooldown-=5;//reduces the spawn cooldown so every 10 seconds normal dodgeballs will continuosly spawn faster and faster increasing difficulty as time goes on
    }

    for (int i = 0; i < balls.size(); i++) {//runs for each ball in the array list no matter how many you add because of balls.size()
      Dodgeball b = balls.get(i);//declares b as the current ball its checking in the list so b represents very single one
      b.move();//runs the move function from the dodgeball class. needs to be ran every frame so that the position changes and if you didnt use a for loop would only run latest ball spawned
      b.display();//actually draws the ball at new position, needs to be ran every frame like this for same reason
      if (b.offScreen()) {//checks if offscreen function returned true which means the ball is offscreen
        balls.remove(i);//removes it from the list so its not taking up space running for no reason reducing lag
      }
      if (b.ballHit(player.position.x, player.position.y, b.position.x, b.position.y)) {//checks if ballhit is true between the player and the current ball its checking. basically checking if the ball hit the player
        playing = false;//changes playing state to false so it pauses
        lost = true;//changes loss state to true
      }
    }

    int remainingFrames = timerLength - timerValue;//calculates how many frames are left of the 7200 in this frame
    int secondsLeft = remainingFrames / 60;//divides the frames by 60 so its in seconds
    int minutes = secondsLeft / 60;//divides by 60 so it will return either a 1 or 0 since its minutes and it can't divide easily
    int seconds = secondsLeft % 60;//gets the remainder of the division for the seconds
    String timeText = minutes + ":" + nf(seconds, 2);//puts the minute value and seconds value in a string with ":". the nf() also adds a 0 in front of seconds if its less than 2 digits so it displays 1:09 instead of 1:9

    fill(0);//makes text black
    textAlign(RIGHT, TOP);//sets from what point the text will start from
    textSize(50);//sets the text size
    text(timeText, width - 20, 20);//displays/draws text and sets its position into the top right corner, again doesnt use exact values cause screen size can change
  }


  if (lost) {//checks if lost state is true which is activated when collision happens
    textAlign(CENTER, CENTER);//sets where text will start from
    fill(255, 0, 0);//sets text to red color
    textSize(150);//sets size of text
    text("GAME OVER", width/2, height/2);//displays/draws text in center using variables so always in center
    textSize(50);//sets size of smaller text
    text("Press r to restart", width/2, (height/2)+120);//displays/draws text in center using variables so always in center, then slightly down from that position
  }

  if (won) {//checks if wonstate is true which is activated when timer/countdown runs out
    textAlign(CENTER, CENTER);//sets where text will start from
    fill(0, 255, 0);//sets text to green color
    textSize(150);//sets size of text
    text("YOU WIN", width/2, height/2);//displays/draws text in center using variables so always in center
    textSize(50);//sets size of text
    text("Press r to restart", width/2, (height/2)+120);//displays/draws text in center using variables so always in center, then slightly down from that position
  }
}

void spawnDodgeball() {//spawns a new dodgeball
  int side = floor(random(4));//randomizes a number so side it spawns from is random between the 4 walls
  ball = new Dodgeball(side, player.position, false);//creates the dodgeball with a argument for side that represents the random number for the constructor, and argument for player.position so the dodgeball flies at them and a argument for if its super or not which is set to false here as its not one of the super ones
  balls.add(ball);//adds new ball to the array list
}

void spawnSuperDodgeball() {//spawns a new super dodgeball
  int side = floor(random(4));//randomizes a number so side it spawns from is random between the 4 walls
  ball = new Dodgeball(side, player.position, true);//creates the dodgeball with a argument for side that represents the random number for the constructor, and argument for player.position so the dodgeball flies at them and a argument for if its super or not which is set to true here as it is a super one
  balls.add(ball);//adds new ball to the array list
}

void restartGame() {//function to restart game, timer, spawn cooldown etc
  won = false;//changes win to false so win state code doesnt activate
  lost = false;//changes loss to false so loss state code doesnt activate
  playing = true;//changes playing back to true so game code starts running again
  spawnCooldown = 60;//resets spawn cooldown so its not the hardest difficulty at the beginning when you restart
  timerValue = 0;//resets timer value
  balls.clear();//gets rid of all current balls in array list since they were paused but still there when you win or lose
}

void keyPressed() {//checks if a key is pressed
  if (key == 'w' || key == 'W')//checks if w key is pressed
    Up = true;//when w is pressed or held up=true which matters in player class for movement
  if (key == 'a' || key == 'A')//checks if a key is pressed
    Left = true;//when a is pressed or held left=true which matters in player class for movement
  if (key == 's' || key == 'S')//checks if s key is pressed
    Down = true;//when s is pressed or held down=true which matters in player class for movement
  if (key == 'd' || key == 'D')//checks if d key is pressed
    Right = true;//when d is pressed or held right=true which matters in player class for movement

  if (key == 'r' || key == 'R' && (lost || won)) {//checks if r is pressed only when lost or won state is also active so you can't restart while currently playing
    restartGame();//activates restart game functions
  }
}

void keyReleased() {//checks when a key is released
  if (key == 'w' || key == 'W')//checks if w key is pressed
    Up = false;//when w key is released makes up=false so code doesnt constantly move position up or think your constantly pressing it
  if (key == 'a' || key == 'A')//checks if a key is pressed
    Left = false;//when a key is released makes left=false so code doesnt constantly move position up or think your constantly pressing it
  if (key == 's' || key == 'S')//checks if s key is pressed
    Down = false;//when s key is released makes down=false so code doesnt constantly move position up or think your constantly pressing it
  if (key == 'd' || key == 'D')//checks if d key is pressed
    Right = false;//when d key is released makes right=false so code doesnt constantly move position up or think your constantly pressing it
}
