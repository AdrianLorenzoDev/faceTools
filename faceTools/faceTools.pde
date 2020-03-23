import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

boolean isEnterPressed = false;
boolean isBackspacePressed = false;
boolean isSpacePressed = false;

CascadeClassifier faceClassifier, leftEyeClassifier, rightEyeClassifier;

public static String[] headImages = { 
  "happyFace.png", 
  "robotFace.png", 
  "beardedFace.png"
};

ArrayList<PImage> heads;

boolean isInDrawMode = true;
PFont defaultFont;
Capture cam;
CVImage img;
FaceDrawerController faceDrawerController;
HeadWardrobeController headWardrobeController;

void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start(); 

  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);

  heads = new ArrayList();
  for (String path : headImages) {
    heads.add(loadImage(path));
  }

  faceClassifier = new CascadeClassifier(dataPath("haarcascade_frontalface_default.xml"));

  faceDrawerController = new FaceDrawerController();
  headWardrobeController = new HeadWardrobeController();
  defaultFont = createFont("Arial", 15);
}

void checkIfModeChanged() {
  if (isEnterPressed) {
    isInDrawMode = !isInDrawMode;
    delay(200);
  }
}

void draw() {
  if (cam.available()) {
    background(255);
    cam.read();

    img.copy(cam, 0, 0, cam.width, 
      cam.height, 0, 0,
      img.width, img.height);
    img.copyTo();

    Mat grey = img.getGrey();
    checkIfModeChanged();

    if (isInDrawMode) {
      Core.flip(grey, grey, +1);
      faceDrawerController.run(grey);
    } else {
      image(img, 0, 0);
      headWardrobeController.run(grey);
    }

    grey.release();
  }
}

void keyPressed() {
  if (key == ' ') {
    isSpacePressed = true;
  }

  if (key == ENTER || key == RETURN) {
    isEnterPressed = true;
  }

  if (key == BACKSPACE) {
    isBackspacePressed = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    isSpacePressed = false;
  }

  if (key == ENTER || key == RETURN) {
    isEnterPressed = false;
  }

  if (key == BACKSPACE) {
    isBackspacePressed = false;
  }
}

public float getRelativeToCanvasWidth(float rel) {
  return width * rel;
}

public float getRelativeToCanvasHeight(float rel) {
  return height * rel;
}
