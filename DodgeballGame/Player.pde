class Player {//player class
  Float speed = 10f;//variable for speed of movement
  PVector position;//vecotr for position of player
  PVector input;//vecotr to track player input
  
  PImage playerAvatar;//variable to define image used for player avatar

  Player(float x, float y) {//player constructor, argumnet are x and y position of player
    position = new PVector(x, y);//initializes postion vector as x and y 
    input = new PVector(0, 0);//initializes input at (0,0) cause no input yet
    imageMode(CENTER);//sets where image starts from
    playerAvatar = loadImage("playerAvatar.jpeg");//gets jpeg file of image and defines it as player avatar
    playerAvatar.resize(0, 80);//resizes the image
  }

  void move() {//move function
    input.set(0, 0);//sets the input back to 0 every frame so when player stops pressing instantly stops for smooth reactive movement
    if (Up)//if up=true which means w was pressed do this
      input.y -= 1;//subtracts 1 from current input y value
    if (Left)//if left=true which means a was pressed do this
      input.x -= 1;//subtracts 1 from current input x value
    if (Down)//if down=true which means s was pressed do this
      input.y += 1;//adds 1 to current input y value
    if (Right)//if right=true which means d was pressed do this
      input.x += 1;//adds 1 to current input x value

    //done like this with booleans as well for diagonals if added to position directly diagonal movement wouldnt work and it would be choppy
    input.normalize();//normalizes input so diagonal isnt faster than straight
    position.add(input.mult(speed));//adds inputXspeed to position each frame so it moves in the x and y direction base don the input/keys pressed

    position.x = constrain(position.x, 0, width);//doesnt let player leave screen on x axis
    position.y = constrain(position.y, 0, height);//doesnt let player leave screen on y axis
  }

  void display() {//draws player
    image(playerAvatar, position.x, position.y);//draws the image at players x and y position
  }
}
