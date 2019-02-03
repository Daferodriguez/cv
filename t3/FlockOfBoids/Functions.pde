class Functions{
  
  public List<Vector> puntos;
  
  public void setPoints(List<Vector> puntos){
    stroke(213,11,11);
    this.puntos = puntos;
  }
  
  public int factorial(int n){
    int factorial = 1;
    while ( n!=0) {
      factorial=factorial*n;
      n--;
    }
    return factorial;
  }
  
  public float combinatoria(int n,int i){
    float numerador = factorial(n);
    float denominador = factorial(i) * factorial(n-i);
    return numerador / denominador;
  }
  
  public float bernstein(float t, int n, int i){
    return combinatoria(n,i)*pow(t,i)*pow(1-t,n-i);
  }
  
  public void bezier(){
    int n = puntos.size();
    Vector aux = null;
    Vector punto_actual = puntos.get(0);
    //List<Vector> curva = new ArrayList<Vector>();
    
    for(float t=0; t<=1; t+=0.01){
      aux = new Vector(0, 0, 0);
      for (int i=0; i<n; i++){
      
        aux.add (Vector.multiply(puntos.get(i),  bernstein(t,n,i) ));

      }
      //System.out.println(punto_actual + " " + aux);
      //System.out.println("punto_actual: " );
      
      line(punto_actual.x(),punto_actual.y(),punto_actual.z(),aux.x(),aux.y(),aux.z());
      punto_actual = aux;
    }
  }
  
  private Vector m(int i) {
    return Vector.multiply( Vector.subtract( puntos.get(i+1), puntos.get(i-1) ), 0.5 );
  }
  
  public void hermite(){
  int n = puntos.size();
  Vector aux = null;
  Vector punto_actual = puntos.get(0);
  for (int i=1; i<n-2;i++){
    Vector P0 = puntos.get(i);
    Vector P1 = puntos.get(i+1);
    
    punto_actual = P0;
    Vector m0= m(i);
    Vector m1= m(i+1); 

    for(float t=0; t<=1; t+=0.01){  
      
      float h00 = 2*pow(t,3)-3*pow(t,2)+1;
      float h10 = pow(t,3)-2*pow(t,2)+t;
      float h01 = -2*pow(t,3)+3*pow(t,2);
      float h11 = pow(t,3)-pow(t,2);

      Vector aux1 = Vector.add(Vector.multiply(P0, h00),Vector.multiply(m0, h10));
      Vector aux2 = Vector.add(Vector.multiply(P1, h01),Vector.multiply(m1, h11));
      aux = Vector.add(aux1, aux2);
      
      line(punto_actual.x(),punto_actual.y(),punto_actual.z(),aux.x(),aux.y(),aux.z());
      punto_actual = aux;
      }  
        
      line(punto_actual.x(),punto_actual.y(),punto_actual.z(),P1.x(),P1.y(),P1.z());
    }
  }
  
  void Bezier3(){
    float pxf;
    float pyf;
    float pzf;
    
    float pxi = (puntos.get(0).x()+4*puntos.get(1).x()+puntos.get(2).x())/6;
    float pyi = (puntos.get(0).y()+4*puntos.get(1).y()+puntos.get(2).y())/6;
    float pzi = (puntos.get(0).z()+4*puntos.get(1).z()+puntos.get(2).z())/6;

    int n = puntos.size()-1;
        for(int i=0;i<=n-3;i++)
        {
          
          for(float t=0;t<=1;t=t+0.01)
          {
            float f1x=-puntos.get(i).x()+3*puntos.get(i+1).x()-3*puntos.get(i+2).x()+puntos.get(i+3).x();
            float f2x=3*puntos.get(i).x()-6*puntos.get(i+1).x()+3*puntos.get(i+2).x();
            float f3x=-3*puntos.get(i).x()+3*puntos.get(i+2).x();
            float f4x=puntos.get(i).x()+4*puntos.get(i+1).x()+puntos.get(i+2).x();
            pxf=(pow(t,3)*(f1x)+pow(t,2)*(f2x)+pow(t,1)*(f3x)+1*(f4x))/6;
            float f1y=-puntos.get(i).y()+3*puntos.get(i+1).y()-3*puntos.get(i+2).y()+puntos.get(i+3).y();
            float f2y=3*puntos.get(i).y()-6*puntos.get(i+1).y()+3*puntos.get(i+2).y();
            float f3y=-3*puntos.get(i).y()+3*puntos.get(i+2).y();
            float f4y=puntos.get(i).y()+4*puntos.get(i+1).y()+puntos.get(i+2).y();
            pyf=(pow(t,3)*(f1y)+pow(t,2)*(f2y)+pow(t,1)*(f3y)+1*(f4y))/6;
            
            float f1z=-puntos.get(i).z()+3*puntos.get(i+1).z()-3*puntos.get(i+2).z()+puntos.get(i+3).z();
            float f2z=3*puntos.get(i).z()-6*puntos.get(i+1).z()+3*puntos.get(i+2).z();
            float f3z=-3*puntos.get(i).z()+3*puntos.get(i+2).z();
            float f4z=puntos.get(i).z()+4*puntos.get(i+1).z()+puntos.get(i+2).z();
            pzf=(pow(t,3)*(f1z)+pow(t,2)*(f2z)+pow(t,1)*(f3z)+1*(f4z))/6;
            
            line(pxi,pyi,pzi,pxf,pyf,pzf);

            pxi=pxf;
            pyi=pyf;
            pzi=pzf;
          }
          
        } 
    }
    
    void splineCubicaNatural() {
    
    float ax[] = new float[8], bx[] = new float[8], cx[] = new float[8], dx[] = new float[8];
    float ay[] = new float[8], by[] = new float[8], cy[] = new float[8], dy[] = new float[8];
    float az[] = new float[8], bz[] = new float[8], cz[] = new float[8], dz[] = new float[8];
    
    float deriv[] = new float[8], gamma[] = new float[8], omega[] = new float[8]; 

    gamma[0] = .5;
    for(int i = 1; i < 7; ++i) gamma[i] = 1. / (4. - gamma[i-1]);
    gamma[7] = 1. / (2. - gamma[6]);
    
    omega[0] = 3. * (puntos.get(1).x()-puntos.get(0).x()) * gamma[0];
    for(int i = 1; i < 7; ++i) omega[i] = (3. * (puntos.get(i+1).x() - puntos.get(i-1).x()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (puntos.get(7).x()-puntos.get(6).x()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for(int i = 6; i>= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for(int i = 0; i < 7; ++i) {
      ax[i] = puntos.get(i).x();
      bx[i] = deriv[i];
      cx[i] = 3. * (puntos.get(i+1).x()-puntos.get(i).x()) - 2. * deriv[i] - deriv[i+1];
      dx[i] = 2. * (puntos.get(i).x() - puntos.get(i+1).x()) + deriv[i] + deriv[i+1];      
    }
    
    omega[0] = 3. * (puntos.get(1).y() - puntos.get(0).y()) * gamma[0];
    for (int i = 1; i < 7; ++i) omega[i] = (3. * (puntos.get(i+1).y() - puntos.get(i-1).y()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (puntos.get(7).y() - puntos.get(6).y()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for (int i = 6; i >= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for (int i = 0; i<7; ++i) {
      ay[i] = puntos.get(i).y();
      by[i] = deriv[i];
      cy[i] = 3. * (puntos.get(i+1).y() - puntos.get(i).y()) -2. * deriv[i] - deriv[i+1];
      dy[i] = 2. * (puntos.get(i).y() - puntos.get(i+1).y()) + deriv[i] + deriv[i+1];
    }
    
    omega[0] = 3. * (puntos.get(1).z() - puntos.get(0).z()) * gamma[0];
    for (int i = 1; i < 7; ++i) omega[i] = (3. * (puntos.get(i+1).z() - puntos.get(i-1).z()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (puntos.get(7).z() - puntos.get(6).z()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for (int i = 6; i >= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for (int i = 0; i<7; ++i) {
      az[i] = puntos.get(i).z();
      bz[i] = deriv[i];
      cz[i] = 3. * (puntos.get(i+1).z() - puntos.get(i).z()) -2. * deriv[i] - deriv[i+1];
      dz[i] = 2. * (puntos.get(i).z() - puntos.get(i+1).z()) + deriv[i] + deriv[i+1];
    }
    
    float xpx, ypx, zpx;
    
    for (int i = 0; i < 7+1; ++i) {

      float puntox = ax[i] + bx[i] + cx[i] + dx[i];
      float puntoy = ay[i] + by[i] + cy[i] + dy[i];
      float puntoz = az[i] + bz[i] + cz[i] + dz[i];
      
      
      for(float t=0; t<=1; t+=0.01){
        xpx = (float)(ax[i]+bx[i]*t+cx[i]*pow(t,2)+dx[i]*pow(t,3));
        ypx = (float)(ay[i]+by[i]*t+cy[i]*pow(t,2)+dy[i]*pow(t,3));
        zpx = (float)(az[i]+bz[i]*t+cz[i]*pow(t,2)+dz[i]*pow(t,3));
        
        line(puntox, puntoy, puntoz, xpx, ypx, zpx);
        
        puntox = xpx;
        puntoy = ypx;
        puntoz = zpx;
      }
    }
  }
}
