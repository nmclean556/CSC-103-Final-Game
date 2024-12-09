



//not important right now
class Buttons{
  
  int bx;
  int by;
  int bw;
  int bh;
  color bc;
  
  boolean clicked;
  
  Buttons(int x, int y, int w, int h, color c){  
    bx = x;
    by = y;
    bw = w;
    bh = h;
    bc = color(c);  
    
    
    
  }
  
  void render(){
     
  fill(bc);
  rect(bx, by, bw, bh, 25);
    
}

boolean isPressed(){
    int top = by - bh / 2;
    int bottom = by + bh / 2;
    int left = bx - bw / 2;
    int right = bx + bw / 2;
  
  if (mouseX < right &&
      mouseX >left &&
      mouseY > top &&
      mouseY < bottom){ 
        println("true");
        
        return true;      
        
  }
  else{
    return false; 
  }
  
}  
 
}
