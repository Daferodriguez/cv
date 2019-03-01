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

void setup() {
  size(720, 640, P3D);
  openXbox360Controller();
  scene = new Scene(this);
  scene.setRadius(1500);
  scene.fit(1);
  Shape[] shapes = new Shape[50];
  for (int i = 0; i < shapes.length; i++) {
    tint(random(0,255), random(0,255), random(0,255), random(150,255));
    shapes[i] = new Shape(scene, loadShape("rocket.obj"));
    scene.randomize(shapes[i]);
  }
  smooth();
}

void draw() {
  background(0);
  scene.drawAxes();
  scene.traverse();
  xbox360Interaction();
  buttonPressed();
  if (snPicking)
    xbox360Picking();
  else
    xbox360Interaction();
}

void xbox360Interaction(){
  scene.translate("XBOXNAV", 2 * snXPos.getValue(), 2 * snYPos.getValue(), 2 * snZPos.getValue());
  scene.rotate("XBOXNAV", -snXRot.getValue() * 5 * PI / width, snYRot.getValue() * 5 * PI / width, 0);
}

void spaceNavigatorPicking() {
  float x = map(snXPos.getValue(), -.8f, .8f, 0, width);
  float y = map(snYPos.getValue(), -.8f, .8f, 0, height);
  // update the space navigator tracked frame:
  scene.cast("SPCNAV", x, y);
  // draw picking visual hint
  pushStyle();
  strokeWeight(3);
  stroke(0, 255, 0);
  scene.drawCross(x, y, 30);
  popStyle();
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

void spaceNavigatorInteraction() {
  scene.translate("SPCNAV", 10 * snXPos.getValue(), 10 * snYPos.getValue(), 10 * snZPos.getValue());
  scene.rotate("SPCNAV", -snXRot.getValue() * 20 * PI / width, snYRot.getValue() * 20 * PI / width, snZRot.getValue() * 20 * PI / width);
}

void mouseMoved() {
  scene.cast();
}

void mouseDragged() {
  if (mouseButton == LEFT)
    scene.spin();
  else if (mouseButton == RIGHT)
    scene.translate();
  else
    scene.scale(scene.mouseDX());
}

void mouseWheel(MouseEvent event) {
  scene.moveForward(event.getCount() * 20);
}

void keyPressed() {
  if (key == ' ')
    snPicking = !snPicking;
}

void mouseClicked(){
    scene.cast("XBOXNAV");
}

void buttonPressed(){
    if(button1.pressed()){
      snPicking = !snPicking;
    }
}

void openSpaceNavigator() {
  println(System.getProperty("os.name"));
  control = ControlIO.getInstance(this);
  String os = System.getProperty("os.name").toLowerCase();
  if (os.indexOf("nix") >= 0 || os.indexOf("nux") >= 0)
    device = control.getDevice("3Dconnexion SpaceNavigator");// magic name for linux
  else
    device = control.getDevice("SpaceNavigator");//magic name, for windows
  if (device == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  //device.setTolerance(5.00f);
  snXPos = device.getSlider(0);
  snYPos = device.getSlider(1);
  snZPos = device.getSlider(2);
  snXRot = device.getSlider(3);
  snYRot = device.getSlider(4);
  snZRot = device.getSlider(5);
  //button1 = device.getButton(0);
  //button2 = device.getButton(1);
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
  snZRot = device.getButton(5);
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
