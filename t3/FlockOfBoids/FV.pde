class Face_vertex{
  ArrayList<Integer[]> face_list = new ArrayList<Integer[]>();
  ArrayList<PVector> vertex_list= new ArrayList<PVector>();

  float sc=3;
  PShape s;
 
  Face_vertex(){
    strokeWeight(2);
    stroke(color(0, 255, 0));
    
    // LISTA DE CARAS
    face_list.add(new Integer[]{0,1,3});
    face_list.add(new Integer[]{0,2,3});
    face_list.add(new Integer[]{2,3,5});
    face_list.add(new Integer[]{2,4,5});
    face_list.add(new Integer[]{0,1,7});
    face_list.add(new Integer[]{0,7,6});
    face_list.add(new Integer[]{0,6,2});
    face_list.add(new Integer[]{2,6,4});
    face_list.add(new Integer[]{6,7,5});
    face_list.add(new Integer[]{6,5,4});
    face_list.add(new Integer[]{7,1,3});
    face_list.add(new Integer[]{7,3,5});
    
    // LISTA DE VERTICES
    vertex_list.add(new PVector(-3,-3,0));
    vertex_list.add(new PVector(-3,-3,2));
    vertex_list.add(new PVector(3,-2,0));
    vertex_list.add(new PVector(3,-2,2));
    vertex_list.add(new PVector(3,2,0));
    vertex_list.add(new PVector(3,2,2));
    vertex_list.add(new PVector(-3,2,0));
    vertex_list.add(new PVector(-3,2,2));
    
    renderRetenido();
  }
  
  //modo retenido
  void renderRetenido(){
    s = createShape();
    s.beginShape(QUAD);
    for(int i=0; i<face_list.size(); i++){
      for(int j=0; j<=face_list.get(i).length; j++){
        PVector vertex = vertex_list.get(face_list.get(i)[j%3]);    //Obtener la coordenada del vertice adyacente actual
        s.vertex(vertex.x*sc,vertex.y*sc,vertex.z*sc);        
      }
    }  
    s.endShape();
  }

  //modo inmediato
  void renderInmediato(){
    beginShape(QUAD);
    for(int i=0; i<face_list.size(); i++){
      for(int j=0; j<=face_list.get(i).length; j++){
        PVector vertex = vertex_list.get(face_list.get(i)[j%3]);    //Obtener la coordenada del vertice adyacente actual
        vertex(vertex.x*sc,vertex.y*sc,vertex.z*sc);        
      }
    }
    endShape();
  }

  PShape getShape(){
    return s;
  }
}
