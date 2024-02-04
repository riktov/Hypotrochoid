/*
a hypotrochoid is a roulette traced by a point attached to a circle of radius r 
rolling around the inside of a fixed circle of radius R, 
where the point is a distance d from the center of the interior circle. 
*/
RotatingVector rollerDisk, rollerCenter ;
PGraphics pgPlot ;
int trackRadius, penRadius;

PVector prevPlotPt ;


void setup() {
  size(800, 800) ;
  
  int rollerRadius ;
  
  /*
  trackRadius == 2 * rollerRadius -> Ellipse
  trackRadius == 2 * rollerRadius, rollerRadius == penRadius -> Tusi Couple

  */
  trackRadius = 150 ;
  rollerRadius = 90 ;
  penRadius = 140;
    
  rollerCenter = new RotatingVector(trackRadius - rollerRadius, TWO_PI / -180, 0) ;
  
  //add 1 to account for the rotation it makes from orbiting
  float rotationRatio = -1 + ((1.0 * trackRadius) / rollerRadius) ;
  println("rotationRatio:" + rotationRatio) ;
  //rotationRatio = 2 / 3 ;
  rollerDisk = new RotatingVector(rollerRadius, -1 * rollerCenter.rotationSpeed * rotationRatio, 0) ;
  

  pgPlot = createGraphics(width, height) ;
  
}

void draw() {
  translate(width/2, height/2) ;  

  //draw background
  background(192, 127, 127) ;
  fill(255, 127, 127) ;

  stroke(64, 64, 255) ;
  strokeWeight(3) ;
  myCircle(0, 0, trackRadius * 2) ;
  
  PVector pvRoller = new PVector(rollerCenter.x, rollerCenter.y) ;
  PVector pvPen = new PVector(rollerDisk.x, rollerDisk.y) ;
  
  pvPen.setMag(penRadius) ;
  pvPen.add(pvRoller) ; //actuall add pen to roller, but same effect

  //translate(0, 0) ;  
  
  pgPlot.beginDraw() ;
  pgPlot.translate(width / 2, height/ 2) ;
//  pgPlot.circle(0, 0, 20) ;

  if(prevPlotPt != null) {
    pgPlot.stroke(255, 64, 64) ;
    pgPlot.strokeWeight(3) ;
    pgPlot.line(prevPlotPt.x, prevPlotPt.y, pvPen.x, pvPen.y) ;
  }
  prevPlotPt = pvPen.copy() ;
  
  //pgPlot.circle(pvPen.x, pvPen.y, 2) ;
  pgPlot.endDraw() ;
  
  image(pgPlot, width / -2, height / -2) ;
  
  
//  translate(width/2, height/2) ;  
  fill(64, 255, 127) ;
  stroke(0) ;
  myCircle(rollerCenter.x, rollerCenter.y, 2 * rollerDisk.mag()) ;
  //line(0, 0, rollerCenter.x, rollerCenter.y) ;
  line(rollerCenter.x, rollerCenter.y, pvPen.x, pvPen.y) ;
  
  stroke(255, 64, 64) ;
  fill(255, 64, 64) ;
  myCircle(pvPen.x, pvPen.y, 5) ;
  
  rollerCenter.advance() ;
  rollerDisk.advance() ;
  
}

//circle can not be used for Java -> JS
void myCircle(float x, float y, float d) {
  ellipse(x, y, d, d) ;
}


class RotatingVector extends PVector {
  float rotationSpeed ;
      
  RotatingVector(int radius, float rotSpeed, float initialAngle) {
    super(radius, 0) ;
    this.rotationSpeed = rotSpeed ;
    rotate(initialAngle) ;
  }
  
  void advance() {
    rotate(rotationSpeed) ;
  }
} ;
