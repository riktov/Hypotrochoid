PVector ptStart ;
PVector vecStep ;
float col = 127 ;
float colR = 127 ;
float colG = 127 ;
float colB = 127 ;
float weight = 5 ;


void setup() {
  size(800, 800) ;  
  ptStart = new PVector(width / 2, height / 2) ;
  vecStep = new PVector(10, 10) ;
  
  //startFromCenter() ;
  startFromRandomEdge() ;
}

void startFromCenter() {
  ptStart.x = width / 2 ;
  ptStart.y = height / 2 ;
  
  vecStep.rotate(TWO_PI * random(-1, 1)) ;
}

void startFromRandomEdge() {
  ptStart.x = random(width) ;
  ptStart.y = random(height) ;

  vecStep.rotate(TWO_PI * random(-1, 1)) ;
    
  int edge = int(random(4)) ; //0,1,2,3

  switch(edge) {
    case 0 :
      ptStart.x = 0 ;
      break ;
    case 1 :
      ptStart.x = width ;
      break ;
    case 2 :
      ptStart.y = 0 ;
      break ;
    case 3 :
      ptStart.y = height ;
      break ;
    
  }

}

float clip(float val, float minVal, float maxVal) {
  return min(max(val, minVal), maxVal) ;
}

float clip255(float val) {
  return clip(val, 0, 255) ;
}

void draw() {
  vecStep.rotate(PI * random(-0.05, 0.05)) ;
  vecStep.setMag(random(1, 15)) ;
  
  PVector ptEnd = PVector.add(ptStart, vecStep) ;
  
  col = clip255(col + random(-2, 2)) ;

  colR = clip255(colR + random(-2, 2)) ;
  colG = clip255(colG + random(-2, 2)) ;
  colB = clip255(colB + random(-2, 2)) ;
  
  stroke(colR, colG, colB) ;
  //stroke(col) ;
  
  weight = clip(weight + random(-1, 1), 1, 10) ;
  
  strokeWeight(weight) ;
  
  drawSegment(ptStart.x, ptStart.y, ptEnd.x, ptEnd.y, weight, color(colR, colG, colB)) ;
  //line(ptStart.x, ptStart.y, ptEnd.x, ptEnd.y) ;
  //vLast = new PVector(vLast.x + v.x, vLast.y + v.y) ;
  ptStart = ptEnd ;
  
  if(ptEnd.x < 0) {
    ptEnd.x = width ;
  }
  if(ptEnd.x > width) {
    ptEnd.x = 0 ;
  }
  if(ptEnd.y < 0) {
    ptEnd.y = height ;
  }
  if(ptEnd.y > height) {
    ptEnd.y = 0 ;
  }
}

void drawSegment(float x1, float y1, float x2, float y2, float weight, color col) {
  strokeWeight(weight) ;
  stroke(col) ;
  line(x1, y1, x2, y2) ;  
  
  //calculate the edges of the segment
  PVector pvSeg = new PVector(x2 - x1, y2 - y1) ;
  
  //if the vector points left, the top edge is a positive HALF_PI rotation.
  //if it points right, the top edge is a negative
  
  PVector ptEdgeTop = pvSeg.copy() ;
  
  if(x2 < x1) { //pointing left, positive
    ptEdgeTop.rotate(HALF_PI) ;
  } else {
    ptEdgeTop.rotate(HALF_PI * -1) ;
  }
  ptEdgeTop.setMag(weight / 2) ;
  
  PVector ptEdgeBottom = ptEdgeTop.copy() ;
  ptEdgeBottom.rotate(PI) ;
  
  strokeWeight(2) ;
  //stroke(0) ;
  
  //calculate highlight/shade
  
  PVector angledColor = pvSeg.copy() ;
  angledColor.normalize() ;
  
  float intensity = abs(angledColor.x) ; //0 ~ 1

  float brightness = (intensity * 0.5) + 1 ; //1.0 ~ 1.5
  float darkness = 1 - (intensity * 0.5) ; //1.0 ~ 0.5
  
  //println("Brightness " + brightness) ;
  
  color litColor = color(red(col) * brightness, green(col) * brightness, blue(col) * brightness) ;
  
  stroke(litColor) ;
  line(x1 + ptEdgeTop.x, y1 + ptEdgeTop.y, x2 + ptEdgeTop.x, y2 + ptEdgeTop.y) ;

  color shadeColor = color(red(col) * darkness, green(col) * darkness, blue(col) * darkness) ;

  stroke(shadeColor) ;
  line(x1 + ptEdgeBottom.x, y1 + ptEdgeBottom.y, x2 + ptEdgeBottom.x, y2 + ptEdgeBottom.y) ;
  //line(pvEdge2.x, pvEdge2.y, ptEnd2.x, ptEnd2.y) ;  

}
