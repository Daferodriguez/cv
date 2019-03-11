/**
 * Space Navigator
 * by Jean Pierre Charalambos.
 *
 * This demo shows how to control your scene shapes using a Space Navigator
 * (3D mouse), with 6 degrees-of-freedom (DOFs). It requires the GameControlPlus
 * library and a Space Navigator and it has been tested only under Linux.
 */
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
ControlDevice device; // my SpaceNavigator
ControlSlider snXPos; // Positions
ControlSlider snYPos;
ControlSlider snZPos;
ControlSlider snXRot; // Rotations
ControlSlider snYRot;
ControlSlider snZRot;

ControlButton button1; // A
ControlButton button2; // B
ControlButton button3; // X
ControlButton button4; // Y
ControlButton button5; // LB
ControlButton button6; // RB
ControlButton button7; // BACK
ControlButton button8; // START

// frames stuff:
Scene scene;
boolean snPicking;
Shape s, shp;
Shape[] shapes;
boolean rot = false;
PShape sh;
PImage tex;

void setup() {
  size(720, 640, P3D);
  //openXbox360Controller();
  scene = new Scene(this);
  scene.setRadius(1500);
  scene.fit(1);
  tint(255, 255, 255, 255);
  s = new Shape(scene, loadShape("rocket.obj"));
  shapes = new Shape[20];
  textureMode(NORMAL);
  tex = loadImage("bump.png");
  for (int i = 0; i < shapes.length; i++) {
    shapes[i] = new Shape(scene, getSphere());
    //shapes[i].setPosition(0,1200,1200);
    scene.randomize(shapes[i]);
  }
  smooth();
}

PShape getSphere() {
  noStroke();
  sh = createShape(SPHERE, 40);
   sh= sh.getTessellation();
  sh.setTexture(tex);
  float posu=tex.width*tex.height;
  println(posu);
  for(int i =0;i<sh.getVertexCount();i++){
  int which = (int)random(sh.getVertexCount());
  color r1 = -1*int(red(tex.pixels[(int) (which*posu/sh.getVertexCount())])+green(tex.pixels[(int) (which*posu/sh.getVertexCount())])+blue(tex.pixels[(int) (which*posu/sh.getVertexCount())])/3);
  PVector r = new PVector(0,0,(r1/30));
  println(r);
   //shp.setTextureUV(which, random(1), random(1));
  sh.setVertex(which, PVector.add(sh.getVertex(which),r));
  }
  return sh;
}

void draw() {
  background(0);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  //scene.drawAxes();
  scene.traverse();
  //xbox360Interaction();
  if (rot) {
    moveRocketX();
  }

  /*
  buttonPressed();
   if (snPicking)
   xbox360Picking();
   else
   xbox360Interaction();
   */
}

void mouseMoved() {
  scene.cast();
}

void keyPressed() {
  if (key == ' ')
    snPicking = !snPicking;
  if (key == 's') {
    if (!rot) {
      pushMatrix();
      scene.rotate("XBOXNAV", PI/2, 0, 3*PI/2);
      scene.translate(-250, 0, 0);
      rot = true;
      popMatrix();
    }
  }
}

void mouseClicked() {
  scene.cast("XBOXNAV");
  scene.eye().setReference(scene.track("XBOXNAV"));
}

void buttonPressed() {
  if (button1.pressed()) {
    snPicking = !snPicking;
  }
}

void openXbox360Controller() {
  println(System.getProperty("os.name"));
  control = ControlIO.getInstance(this);
  String os = System.getProperty("os.name").toLowerCase();

  device = control.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");// magic name for linux
  if (device == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  //device.setTolerance(5.00f);
  device.setTolerance(0.5);
  snXPos = device.getSlider(0);
  snYPos = device.getSlider(1);
  snZPos = device.getSlider(2);
  snXRot = device.getSlider(3);
  snYRot = device.getSlider(4);
  button1 = device.getButton(0);
  button2 = device.getButton(1);
  button3 = device.getButton(2);
  button4 = device.getButton(3);
  button5 = device.getButton(4);
  button6 = device.getButton(5);
  button7 = device.getButton(6);
  button8 = device.getButton(7);

  //button2 = device.getButton(1);
}

void moveRocketX() {
  for (int i = 0; i < shapes.length; i++) {
    //shapes[i].setPosition(0,1200,1200);
    Frame f = new Frame(shapes[i]);
    if (f.position().y() < -200) {
      shapes[i].setPosition(0, random(3000, 3200), random(-1500, 1500));
    }
    shapes[i].translate(0, -10, 0);
  }
}

void xbox360Interaction() {
  //scene.translate("XBOXNAV", 2 * snXPos.getValue(), 2 * snYPos.getValue(), 2 * snZPos.getValue());
  scene.translate("XBOXNAV", 2 * snYPos.getValue(), 2 * snZPos.getValue(), 0);
  //scene.rotate("XBOXNAV", -snXRot.getValue() * 5 * PI / width, snYRot.getValue() * 5 * PI / width, 0);
}

void xbox360Picking() {
  float x = map(snXPos.getValue(), -.8f, .8f, 0, width);
  float y = map(snYPos.getValue(), -.8f, .8f, 0, height);
  // update the space navigator tracked frame:
  scene.cast("XBOXNAV", x, y);
  // draw picking visual hint
  pushStyle();
  strokeWeight(3);
  stroke(0, 255, 0);
  scene.drawCross(x, y, 30);
  popStyle();
}
