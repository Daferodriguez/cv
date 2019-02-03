class Vertex_vertex{
  ArrayList<PVector> coordenadas= new ArrayList<PVector>();
  ArrayList<Integer[]> vert_adj = new ArrayList<Integer[]>();
  PShape s;  
  float sc;

  Vertex_vertex(){
    strokeWeight(2);
    stroke(color(0, 255, 0));
    
    //coordenadas
    coordenadas.add(new PVector(-3,-3,0));
    coordenadas.add(new PVector(-3,-3,2));
    coordenadas.add(new PVector(3,-2,0));
    coordenadas.add(new PVector(3,-2,2));
    coordenadas.add(new PVector(3,2,0));
    coordenadas.add(new PVector(3,2,2));
    coordenadas.add(new PVector(-3,2,0));
    coordenadas.add(new PVector(-3,2,2));
    
    //vertices adjacentes
    vert_adj.add(new Integer[]{0,1,3});
    vert_adj.add(new Integer[]{0,6,2});
    vert_adj.add(new Integer[]{0,1,6});
    vert_adj.add(new Integer[]{1,0,3});
    vert_adj.add(new Integer[]{1,7,3});
    vert_adj.add(new Integer[]{1,7,0});
    vert_adj.add(new Integer[]{2,0,3});
    vert_adj.add(new Integer[]{2,4,3});
    vert_adj.add(new Integer[]{2,0,4});
    vert_adj.add(new Integer[]{3,2,5});
    vert_adj.add(new Integer[]{3,1,2});
    vert_adj.add(new Integer[]{3,1,5});
    vert_adj.add(new Integer[]{4,5,2});
    vert_adj.add(new Integer[]{4,6,2});
    vert_adj.add(new Integer[]{4,5,6});
    vert_adj.add(new Integer[]{5,4,3});
    vert_adj.add(new Integer[]{5,4,7});
    vert_adj.add(new Integer[]{5,7,3});
    vert_adj.add(new Integer[]{6,7,4});
    vert_adj.add(new Integer[]{6,7,0});
    vert_adj.add(new Integer[]{6,0,4});
    vert_adj.add(new Integer[]{7,1,6});
    vert_adj.add(new Integer[]{7,6,5});
    vert_adj.add(new Integer[]{7,1,5});
    
    sc = 3;
    renderRetenido();
  }


  void renderRetenido(){
    s = createShape();
    s.beginShape(QUAD);

    for (int i=0; i< vert_adj.size();i++){    //Itera sobre los vertices
      for(int j=0; j<= vert_adj.get(i).length; j++){    //Itera sobre los vertices adyacentes
        PVector cor = coordenadas.get(vert_adj.get(i)[j%3]);    //Obtener la coordenada del vertice adyacente actual
        s.vertex(cor.x*sc,cor.y*sc,cor.z*sc);    
      }
    }
    s.endShape();
  }
  
  void renderInmediato(){
    beginShape(QUAD);

    for (int i=0; i< vert_adj.size();i++){    //Itera sobre los vertices
      for(int j=0; j<= vert_adj.get(i).length; j++){    //Itera sobre los vertices adyacentes
        PVector cor = coordenadas.get(vert_adj.get(i)[j%3]);    //Obtener la coordenada del vertice adyacente actual
        vertex(cor.x*sc,cor.y*sc,cor.z*sc);    
      }
    }
    endShape();
  }
  
  PShape getShape(){
    return s;
  }
}
