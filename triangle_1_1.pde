float global = 0;
int line_num = 0;
float scale = 0;
float rotate = 0;
int translate_x = 0;
int translate_y = 0;
float triangle_coordinate_x = 0;
float triangle_coordinate_y = 0;
int press = 0;
float mouseXinit = 0;
float mouseYinit = 0;
int iter = 0;

float sizeX = 1500;
float sizeY = 1200;

float scaler = 0.9;
float extender = 11;


void setup() {
  frameRate(24);
  size(1500, 1200);
  background(255);
  noStroke();
  
  triangle_coordinate_x = sizeX/2 * (1/scaler);
  triangle_coordinate_y = sizeY/2* (1/scaler);
  

}

void draw() {
  
    background(255);
    
   
  
    
    //number of lines to draw
    if (keyPressed) {
      if (key == 'c') {
        extender--;
       
        
      }
      else if (key == 'x') {
        extender++;
        
      }
      
    }
    int num_draw = 500;
    
    //adjust the scale of the traingles
    
    scale(scaler);
    
    //Play with this number to change X extender
    
    
    if (keyPressed) {
      if (key == 'b') {
        print(scaler);
        triangle_coordinate_x =  triangle_coordinate_x - 10;
        triangle_coordinate_y = triangle_coordinate_y - 10;
        scaler = scaler + .01;
        
       
        
      }
      else if (key == 'B') {
        print(scaler);
        triangle_coordinate_x =  triangle_coordinate_x - 20;
        triangle_coordinate_y = triangle_coordinate_y - 20;
        scaler = scaler +.1;
      }
      else if (key == 'v') {
        print(scaler);
        triangle_coordinate_x =  triangle_coordinate_x + 10;
        triangle_coordinate_y = triangle_coordinate_y + 10;
        scaler = scaler - .01;
      }
      else if (key == 'V') {
        print(scaler);
        triangle_coordinate_x =  triangle_coordinate_x + 20;
        triangle_coordinate_y = triangle_coordinate_y + 20;
        scaler = scaler - .1;
      }
    }
   //Draws the triangles
   if(mousePressed){
     //iter = 0;
     
     iter++;
     
     if (iter == 1){
       
       mouseXinit = mouseX * (1/scaler);
       mouseYinit = mouseY * (1/scaler);
       ellipse(mouseXinit, mouseYinit, 5, 5);
       iter++;
     }
     if (iter > 1){
       ellipse(mouseXinit, mouseYinit, 5, 5);
       
       
       if(mouseX * (1/scaler)<mouseXinit ){
         triangle_coordinate_x = triangle_coordinate_x - 10;
       }
       if(mouseX * (1/scaler)>mouseXinit){
         triangle_coordinate_x = triangle_coordinate_x + 10;
       }
       if(mouseY * (1/scaler)>mouseYinit){
         triangle_coordinate_y = triangle_coordinate_y +10;
       }
       if(mouseY* (1/scaler)<mouseYinit){
         triangle_coordinate_y = triangle_coordinate_y -10;
       }
       
     }
       
       
       
     
     
   }
   else{
     iter = 0;
   }
   
   
   /* goes to center of triangle on click
    if (mousePressed){
  
      mouseXinit = mouseX;
      mouseYinit = mouseY;
      
      if(triangle_coordinate_x /(1/scaler) <mouseXinit ){
       triangle_coordinate_x = triangle_coordinate_x + 10;
      }
      if(triangle_coordinate_x/(1/scaler) >mouseXinit){
       triangle_coordinate_x = triangle_coordinate_x - 10;
      }
      if(triangle_coordinate_y/(1/scaler) >mouseYinit){
       triangle_coordinate_y = triangle_coordinate_y -10;
      }
      if(triangle_coordinate_y /(1/scaler)<mouseYinit){
       triangle_coordinate_y = triangle_coordinate_y +10;
      }
      //triangle_coordinate_x = mouseX+ triangle_coordinate_x;
      //triangle_coordinate_y = mouseY + triangle_coordinate_y;
    }
    else{
      //press = 0;
    }
    
    */
    
    int rotate_x = 100;
    int rotate_y = 100;
    
    int delay_time = 1;
    
    //adjust the scale of the base triangle
    int scale = 60;
    
    drawTarget(triangle_coordinate_x - global + translate_x + rotate_x, triangle_coordinate_y - global + translate_y + rotate_y,triangle_coordinate_x + scale+ global+ translate_x+ rotate_x ,triangle_coordinate_y + scale- global+ translate_y+ rotate_y,triangle_coordinate_x + scale- global+ translate_x- rotate_x,triangle_coordinate_y - scale + translate_y- rotate_y,num_draw, line_num, extender);
   
    //updates these variables each frame
    global = global + .03;
    delay(delay_time);
    rotate_x=rotate_x+100;
    rotate_y=rotate_y+100;
    line_num++; //draws next traingle
    //translate_x++; //moves the triangles x direction
    //translate_y++; //moves the triangles y diraction
   
    
    
  
}
float[] newPoint(float[] firstPoint, float[] secondPoint, float extender){
   //calculate slope
  
   //float slope = ((firstPoint[1] - firstPoint[0])/(secondPoint[1] - secondPoint[0]));
   float slope = ((firstPoint[1] - secondPoint[1])/(firstPoint[0] - secondPoint[0]));
   
   //extend in the x direction in the correct mannor based if we are going from right to left or left to right
   float xExtend = 0;
   if(firstPoint[0] - secondPoint[0] > 0){
     xExtend = -extender;
   }
   else{
     xExtend = extender;
   }
   //change the x coordinate: go past by 4 
   secondPoint[0] = secondPoint[0] + xExtend;
   //update the y direction based on the x direction
   secondPoint[1] = secondPoint[1] + (xExtend * slope);
   
   
   //calculate distance
   
   
   //return new Point
    
    return secondPoint;
}
void drawTarget(float pt1, float pt2, float pt3, float pt4, float pt5, float pt6, int num_iter, int line_num, float extender) {
  
  //initilize triangle pts
  float[] a = new float[2];
  a[0] = pt1;
  a[1] = pt2;
  
  float[] b = new float[2];
  b[0] = pt3;
  b[1] = pt4;
  
  float[] c = new float[2];
  c[0] = pt5;
  c[1] = pt6;
  
  //draw first triangle
  stroke(0);
  // makes wierd thing
  line(a[0], a[1], b[0], b[1]);
  line(b[0], b[1], c[0], c[1]);
  line(c[0], c[1], a[0], a[1]);
  b = newPoint(a, b, extender);
  line(b[0], b[1], a[0], a[1]);
  
  c = newPoint(b, c, extender);
  line(b[0], b[1], c[0], c[1]);
  
  a = newPoint(c, a, extender);
  line(c[0], c[1], a[0], a[1]);
  
  for(float i = 0; i < num_iter && i < line_num; i ++){
    
    b = newPoint(a, b,extender);
    line(b[0], b[1], a[0], a[1]);
  
    c = newPoint(b, c,extender);
    line(b[0], b[1], c[0], c[1]);
  
    a = newPoint(c, a,extender);
    line(c[0], c[1], a[0], a[1]);
    
  }
    //use pt slope form
    /*
    line(a[0], a[1], b[0], b[1]);
    b[0] = b[0] + 10;
    b[1] = b[1] + 10;
    line(b[0], b[1], c[0], c[1]);
    
    c[0] = c[0] + 10;
    c[1] = c[1] + 10;
    line(c[0], c[1], a[0], a[1]);
    */
  }
  
  
