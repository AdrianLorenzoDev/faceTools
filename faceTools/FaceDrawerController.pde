import java.util.ArrayList;

public class FaceDrawerController {
  private final ArrayList<PVector> points = new ArrayList();
  private final int maxPoints = 2000;
  
  private final float circleSize = 12;
  
  public void addFacePosition(Mat grey) {
    MatOfRect faces = new MatOfRect();
    faceClassifier.detectMultiScale(grey, faces, 1.15, 3, 
      Objdetect.CASCADE_SCALE_IMAGE, 
      new Size(60, 60), new Size(200, 200));
    Rect [] facesArr = faces.toArray();
    
    if (facesArr.length > 0) {  
      if (isSpacePressed){
        if (points.size() == maxPoints) {
          points.remove(maxPoints-1);
        }
        points.add(0,
          new PVector(
            facesArr[0].x + facesArr[0].width/2,
            facesArr[0].y + facesArr[0].height/2
          )
        );
      } else {
        circle(
          facesArr[0].x + facesArr[0].width/2, 
          facesArr[0].y + facesArr[0].height/2, 
          circleSize
        );
      }
    }
    
    faces.release();
  }
  
  public void checkIfRemovePoints(){
    if (isBackspacePressed) {
      points.removeAll(points); 
    }
  }
  
  public void drawPoints() {
    for (PVector point : points) {
      fill(0);
      circle(point.x, point.y, circleSize); 
    }
  }
  
  public void showControls() {
    fill(0);
    textFont(defaultFont);
    text("Hold SPACE → Draw", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.90));
    text("BACKSPACE → Delete points", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.94));
    text("ENTER → Change Mode", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.98)); 
    text("Face Drawer Mode", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.04));
  }
  
  public void run(Mat faceGrey) {
    addFacePosition(faceGrey);
    checkIfRemovePoints();
    drawPoints();
    showControls();
  }
}
