int BLOCK_WIDTH = 40 ;

void setup() {
  size(200, 200) ;
}

void draw() {
  /*
  noStroke() ;
  strokeWeight(0) ;
  color colr ;

  int numCols = width / BLOCK_WIDTH ;
  int numRows = height / BLOCK_WIDTH ;

  for(int row = 0 ; row <numRows ; row++) {
    for(int col = 0 ; col < numCols ; col++) {
      if((col + row) % 2 == 0) {
        colr = color(255) ;
      } else {
        colr = color(0) ;
      }
      fill(colr) ;
      rect(col * BLOCK_WIDTH, row * BLOCK_WIDTH, BLOCK_WIDTH, BLOCK_WIDTH) ; 
    }  
  }
  */
  strokeWeight(1) ;
  stroke(0) ;
  line(0, 0, 200, 200) ;
  stroke(color(255, 63, 63)) ;
  line(0, 0, width, height) ;

}
