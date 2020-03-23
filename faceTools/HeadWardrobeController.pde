public class HeadWardrobeController {
  int headIndex = 0;
  PImage selectedHead = heads.get(headIndex);
  
  public void drawHead(Mat grey) {
    MatOfRect faces = new MatOfRect();
    faceClassifier.detectMultiScale(grey, faces, 1.15, 3, 
      Objdetect.CASCADE_SCALE_IMAGE, 
      new Size(60, 60), new Size(200, 200));
    Rect [] facesArr = faces.toArray();
    
    for (Rect r : facesArr) {    
      image(selectedHead, r.x, r.y, r.width*1.2, r.height*1.2);
    }
  }
  
  public void checkIfHeadChanged() {
    if (isSpacePressed) {
      headIndex++;
      if (headIndex == heads.size()) {
         headIndex = 0;
      }
      
      selectedHead = heads.get(headIndex);
      delay(200);
    }
  }
  
  public void showControls() {
    fill(255, 0, 0);
    textFont(defaultFont);
    text("SPACE → Change head", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.90));
    text("Hold BACKSPACE → Remove head", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.94));
    text("ENTER → Change Mode", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.98)); 
    text("Head Wardrobe Mode", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.04));
  }
  
  public void run(Mat faceGrey) {
    if (!isBackspacePressed){
      drawHead(faceGrey);
    }
    
    checkIfHeadChanged();
    showControls();
  } 
}
