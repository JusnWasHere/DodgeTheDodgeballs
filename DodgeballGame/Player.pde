class Player {
  PVector position;
  PVector input;

  Player(float x, float y){
    position = new PVector(x,y);
    input = new PVector(width/2,height/2);
  }
  
  void move(){
    if(Up)
      input.y -= 1;
    if(Left)
      input.x -= 1;
    if(Down)
      input.y += 1;
    if(Right)
      input.x += 1;
    
    input.normalize();
    position = input.mult(1);
  }
  
  void display(){
    fill(0);
    ellipse(position.x,position.y,15,15);
  }
}
