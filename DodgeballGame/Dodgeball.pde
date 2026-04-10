class Dodgeball {//creates dodgeball class
//vectors for dodgeball 
  PVector position;//the actual position of the dodgeball
  PVector velocity;//the velocity is the x and y each frame that the ball.position moves towards
  PVector acceleration;//increases the velocity vector each frame so ball gets faster over time(in this case can also be used for gravity and other things)
  PVector direction;//the vector that will launch the ball.position towards the players position(before they move doesnt follow them)
  Float speed;//the initial speed of how many pixels per frame it moves
  Boolean isSuper = false;//bolean to check if ball is super or not

  Dodgeball(int s, PVector playerPosition, boolean superBall) {//dodgeball constructor, int s is for random side, playerposition is position of player, boolean superball is to check if ball should be super or not
    isSuper = superBall;//declares that isSuper boolean and superBall are the same
    direction = new PVector(0, 0);//initializes direction vector
    velocity = new PVector(0, 0);//initializes velocity vector
    acceleration = new PVector(0, 0);//initializes acceleration vector

    if (s==0)//checks if random s variable is 0
      position = new PVector(random(width), -20);//sets ball position to a random place at top of the screen within the screen size/width
    if (s==1)//checks if random s variable is 1
      position = new PVector(random(width), height+20);//sets ball position to a random place at bottom of the screen within the screen size/width
    if (s==2)//checks if random s variable is 2
      position = new PVector(+20, random(height));//sets ball position to a random place left of the screen within the screen size/height
    if (s==3)//checks if random s variable is 3
      position = new PVector(width+20, random(height));//sets ball position to a random place right of the screen within the screen size/height

    direction = PVector.sub(playerPosition, position);//subtracts balls position from player position to get the direction they are in in vecotr form
    direction.normalize();//normalize makes it a unit vector/makes it to length 1 so that going diagonal is not faster than going in a straight direction
    
    //if ball is super it goes faster
    if (isSuper)//checks if isSuper=true
      speed = 15f;//makes speed 15
    else//does this if isSuper=false
      speed = 6f;//makes speed 6

    velocity = PVector.mult(direction, speed);//makes velocity direction vector times the speed so it goes that direction every frame by that many pixels
    acceleration = PVector.mult(direction, 0.1);//makes acceleration the same velocity x 0.1 so it will only add 0.1 tovelocity every frame in the same direction so it just speeds it up doesnt change its direction
  }

  void move() {//move function
    velocity.add(acceleration);//adds accelertation to velocity every frame increasing it
    position.add(velocity);//adds the velocity to current position moving it towards direction
  }

  void display() {//draws the dodgeballs
    //strokeWeight(0.5);
    if (isSuper) {//checks if isSuper=true
      fill(139, 0, 0);//if super makes dodgeball dark red color
      ellipse(position.x, position.y, 40, 40);//draws the ellipse at current position 40x40 pixels(bigger than normal dodgeball)
    } else {//does this if isSuper=false
      fill(255, 0, 0);//if normal makes dodgeball light/bright red color
      ellipse(position.x, position.y, 30, 30);//draws the ellipse at current position 30x30 pixels
    }
  }

  boolean offScreen() {//will return true or false depending on if ball is off screen or not
    if (position.x < -80 || position.x > width + 80 || position.y < -80 || position.y > height + 80)//checks if the x and y position of ball is greater than the height or width + or - 80
      return true;//if it is return true and ball is deleted in main
    return false;//if it isnt(balls are still on screen return false so doesnt delete them
  }

  boolean ballHit(float pX, float pY, float bX, float bY) {//checks if ball hit player, argument are for player x and y position and ball x and y position
    return dist(pX, pY, bX, bY) <= 30;//will return true if the x and y position of player and ball are within 30pixels of eachother
  }
}
