import frames.timing.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = false;
boolean antialiasing = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

float scale = 0;

void setup() {
  //use 2^n to change the dimensions
  size(500, 500, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();

  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));
  scale = width/pow(2, n);
  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}


// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.location converts from world to frame
  // here we convert v1 to illustrate the idea
  float x1 = frame.location(v1).x();
  float x2 = frame.location(v2).x();
  float x3 = frame.location(v3).x();
  float y1 = frame.location(v1).y();
  float y2 = frame.location(v2).y();
  float y3 = frame.location(v3).y();
  float centerx = (x3+x2+x1)/3; 
  float centery = (y3+y2+y1)/3;
  float distmax= max((sqrt(pow((centerx-x1),2)+pow((centery-y1),2))),(sqrt(pow((centerx-x2),2)+pow((centery-y1),2))),(sqrt(pow((centerx-x1),2)+pow((centery-y1),2))));
  
  if (debug) {
    gridHint = true;
    triangleHint = true;
    stroke(0, 255, 0);  
    point(x1, y1);
  
    stroke(0, 0, 255);
    point(x2, y2);
    stroke(255, 0, 0);
    point(x3, y3);
  }else{
    if(antialiasing){
      pushStyle();
      // punto que se encuentra en el medio (baricentro)
      //stroke(255);
      //point(round( (centerx)), round(centery));
      strokeWeight(0);
      fill(255, 0, 255);
      //subdivision del antialiasing 
      int antialiasing = 16;
      for (int x = -height/2; x < height; x++) {
        for (int y = -width/2; y < width; y++) {
          //se definen los colores del respectivo triangulo
          float color1 = 0;
          float color2 = 0;
          float color3 = 0;
          float shade= 0;
          for (float i = 0; i<1; i+=(float)1/antialiasing) {
            for (float j = 0; j<1; j+=(float)1/antialiasing) {
    
              float a, b, c;
              a = oriented(x1, x2, x+i+1/antialiasing/2, y1, y2, y+i+1/antialiasing/2);
              b = oriented(x2, x3, x+i+1/antialiasing/2, y2, y3, y+i+1/antialiasing/2);
              c = oriented(x3, x1, x+i+1/antialiasing/2, y3, y1, y+i+1/antialiasing/2);
              if (edgeFunction(v1, v2, v3) == true) {
    
                if (a < 0 && b < 0 && c < 0) {
                  color1+=a*255/(a+b+c)/(pow(antialiasing, 2));
                  color2+=b*255/(a+b+c)/(pow(antialiasing, 2));
                  color3+=c*255/(a+b+c)/(pow(antialiasing, 2));
                  shade=(sqrt(pow((x-centerx),2)+ pow((y-centery),2))*255)/distmax/(0.9*antialiasing);
                  color alpha = color(round(color1), round(color2), round(color3), round(shade));
                  fill(alpha);
                  rect(x, y, 1, 1);
                  //println("color ["+color1+", "+color2+ " ,"+ color3+ "] alpha "+ shade );
                }
              } else {
                if (a >= 0 && b >= 0 && c >= 0) {
                  color1+=a*255/(a+b+c)/(pow(antialiasing, 2));
                  color2+=b*255/(a+b+c)/(pow(antialiasing, 2));
                  color3+=c*255/(a+b+c)/(pow(antialiasing, 2));
                  shade=(sqrt(pow((x-centerx),2)+ pow((y-centery),2))*255)/distmax/(0.9*antialiasing);
                  color alpha = color(round(color1), round(color2), round(color3), round(shade));
                  fill(alpha);
                  rect(x, y, 1, 1);
                  //println("color ["+color1+", "+color2+ " ,"+ color3+ "] alpha "+ shade );
                }
              }
            }
          }
        }
      }
      popStyle();
      //println(alpha(get(int(centerx),int(centery))));
    }else{
      pushStyle();
      // punto que se encuentra en el medio (baricentro)
      //stroke(255);
      //point(round( (centerx)), round(centery));
      strokeWeight(0);
      fill(255, 0, 255);
      for (int x = -height/2; x < height; x++) {
        for (int y = -width/2; y < width; y++) {
          //se definen los colores del respectivo triangulo
          float color1 = 0;
          float color2 = 0;
          float color3 = 0;
          float shade= 0;
          for (float i = 0; i<1; i+=1) {
            for (float j = 0; j<1; j+=1) {
    
              float a, b, c;
              a = oriented(x1, x2, x+i+1/2, y1, y2, y+i+1/2);
              b = oriented(x2, x3, x+i+1/2, y2, y3, y+i+1/2);
              c = oriented(x3, x1, x+i+1/2, y3, y1, y+i+1/2);
              if (edgeFunction(v1, v2, v3) == true) {
    
                if (a < 0 && b < 0 && c < 0) {
                  color1+=a*255/(a+b+c);
                  color2+=b*255/(a+b+c);
                  color3+=c*255/(a+b+c);
                  shade=(sqrt(pow((x-centerx),2)+ pow((y-centery),2))*255)/distmax/(0.9);
                  color alpha = color(round(color1), round(color2), round(color3), round(shade));
                  fill(alpha);
                  rect(x, y, 1, 1);
                  //println("color ["+color1+", "+color2+ " ,"+ color3+ "] alpha "+ shade );
                }
              } else {
                if (a >= 0 && b >= 0 && c >= 0) {
                  color1+=a*255/(a+b+c);
                  color2+=b*255/(a+b+c);
                  color3+=c*255/(a+b+c);
                  shade=(sqrt(pow((x-centerx),2)+ pow((y-centery),2))*255)/distmax/(0.9);
                  color alpha = color(round(color1), round(color2), round(color3), round(shade));
                  fill(alpha);
                  rect(x, y, 1, 1);
                  //println("color ["+color1+", "+color2+ " ,"+ color3+ "] alpha "+ shade );
                }
              }
            }
          }
        }
      }
      popStyle();
      //println(alpha(get(int(centerx),int(centery))));
    }
  }
  
}

// true implica que es negativo=menor, false que es positivo=mayor
// 
boolean edgeFunction(Vector a, Vector b, Vector c) {
  return ((c.x() - a.x()) * (b.y() - a.y()) - (c.y() - a.y()) * (b.x() - a.x()) >= 0);
}
float oriented(float x1, float x2, float x3, float y1, float y2, float y3) {
  return (x1 - x3)*(y2 - y3) - (y1 - y3)*(x2 - x3);
}



void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == 'a')
    antialiasing = !antialiasing;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    scale = width/pow(2, n);
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    scale = width/pow(2, n);
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')  
    yDirection = !yDirection;
}
