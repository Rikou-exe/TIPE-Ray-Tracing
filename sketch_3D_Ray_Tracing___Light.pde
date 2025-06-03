import java.lang.Math;
import java.util.ArrayList;
    class Vecteur
    {
        public double[] coordonees = new double[3];
        public Vecteur(double x, double y, double z)
        {
            this.coordonees[0] = x;
            this.coordonees[1] = y;
            this.coordonees[2] = z;
        }
        public Vecteur()
        {
            coordonees[0] = 0;
            coordonees[1] = 0;
            coordonees[2] = 0;
        }
        public Vecteur(Vecteur ini)
        {
            this.coordonees = ini.coordonees;
        }

        public Vecteur Difference(Vecteur A, Vecteur B)
        {
          return new Vecteur(A.coordonees[0]-B.coordonees[0],A.coordonees[1]-B.coordonees[1],A.coordonees[2]-B.coordonees[2]);
        }
        public double Scalaire(Vecteur A, Vecteur B)
        {
            double res = A.coordonees[0] * B.coordonees[0] + A.coordonees[1] * B.coordonees[1] + A.coordonees[2] * B.coordonees[2];
            return res;
        }
        public double Norme(Vecteur A)
        {
            double res = Math.sqrt(Math.pow(A.coordonees[0], 2) + Math.pow(A.coordonees[1], 2) + Math.pow(A.coordonees[2], 2));
            return res;
        }
        public double Angle(Vecteur A, Vecteur B)
        {
            double res = Math.acos(Scalaire(A, B) / (Norme(A) * Norme(B)));
            return res;
        }
        public Vecteur Produit_Vectoriel(Vecteur A, Vecteur B)
        {
         double[] res = new double[3];
         res[0] = A.coordonees[1] * B.coordonees[2] - A.coordonees[2] * B.coordonees[1];
         res[1] = A.coordonees[2] * B.coordonees[0] - A.coordonees[0] * B.coordonees[2];
         res[2] = A.coordonees[0] * B.coordonees[1] - A.coordonees[1] * B.coordonees[0];
         return new Vecteur(res[0], res[1], res[2]);
          
        }
    }
    
    public Vecteur multi(double sca,  Vecteur B)
    {
      double x = sca*B.coordonees[0];
      double y=sca*B.coordonees[1];
      double z=sca*B.coordonees[2];
      return new Vecteur(x, y, z);
    }
    
    class Matrice3D
    {
        public Vecteur[] Matrice = new Vecteur[3];

        public Matrice3D()
        {
            
        }
        public Matrice3D(Vecteur A, Vecteur B, Vecteur C)
        {
            Matrice[0] = A; Matrice[1] = B; Matrice[2] = C;
        }
        public Matrice3D(double a, double b, double c, double d, double e, double f, double g, double h, double i)
        {
            Vecteur A = new Vecteur(a, b, c); Vecteur B = new Vecteur(d, e, f);Vecteur C = new Vecteur(g, h, i);
            Matrice[0] = A; Matrice[1] = B; Matrice[2] = C;
        }
        public Vecteur Mult(Matrice3D M, Vecteur A) 
        {
            Vecteur result = new Vecteur();
            for (int i = 0; i<3; i++)
            {
                for (int j = 0; j<3; j++)
                {
                    result.coordonees[i] = A.coordonees[j] * M.Matrice[i].coordonees[j] + result.coordonees[i];
                }
            }
            return result;
        }
        public Matrice3D Mult(Matrice3D M, Matrice3D M2)
        {
            Vecteur A = M2.Matrice[0]; Vecteur B = M2.Matrice[1]; Vecteur C = M2.Matrice[2];
            Matrice3D resultat = new Matrice3D();
            resultat.Matrice[0] = Mult(M, A);
            resultat.Matrice[1] = Mult(M, B);
            resultat.Matrice[2] = Mult(M, C);
            return resultat;
        }

        public Matrice3D RotationX(Matrice3D Ini, double angleRad)
        {

            Matrice3D MRX = new Matrice3D(1, 0, 0, 0, Math.cos(angleRad), -Math.sin(angleRad), 0, Math.sin(angleRad), Math.cos(angleRad));
            return Mult(Ini, MRX);
        }
        public Matrice3D RotationX(double angleRad)
        {
            return new Matrice3D(1, 0, 0, 0, Math.cos(angleRad), -Math.sin(angleRad), 0, Math.sin(angleRad), Math.cos(angleRad));
        }
        public Matrice3D MatriceID()
        {
            return new Matrice3D(1, 0, 0, 0, 1, 0, 0, 0, 1);
        }
        public Matrice3D RotationY(Matrice3D Ini, double angleRad)
        {

            Matrice3D MRY = new Matrice3D(Math.cos(angleRad), 0, Math.sin(angleRad), 0, 1, 0, -Math.sin(angleRad), 0, Math.cos(angleRad));
            return Mult(Ini, MRY);
        }
        public Matrice3D RotationY(double angleRad)
        {
            return new Matrice3D(Math.cos(angleRad), 0, Math.sin(angleRad), 0, 1, 0, -Math.sin(angleRad), 0, Math.cos(angleRad));
        }
        public Matrice3D RotationZ(Matrice3D Ini, double angleRad)
        {

            Matrice3D MRZ = new Matrice3D(Math.cos(angleRad), -Math.sin(angleRad), 0, Math.sin(angleRad), Math.cos(angleRad), 0, 0, 0, 1);
            return Mult(Ini, MRZ);
        }
        public Matrice3D RotationZ(double angleRad)
        {
            return new Matrice3D(Math.cos(angleRad), -Math.sin(angleRad), 0, Math.sin(angleRad), Math.cos(angleRad), 0, 0, 0, 1);
        }

        public Matrice3D MatriceHomot(double Zoom)
        {
            return new Matrice3D(Zoom, 0, 0, 0, Zoom, 0, 0, 0, Zoom);
        }
    }


final class Plan
{
  public double a;
  public double b;
  public double c;
  public double d; // ax + by + cz + d
  
  public Plan(double A, double B, double C, double D){
    a= A;
    b=B;
    c=C;
    d=D;
  }
    public Plan(){
    this(0, 0, 0, 0);
  }
}
final class Triangle
{
 public Vecteur A = new Vecteur(); 
 public Vecteur B = new Vecteur(); 
 public Vecteur C = new Vecteur();
 public int red = 255;
 public int green = 255;
 public int blue = 255;
 public Triangle()
 {
   
 }
 public Triangle(Vecteur a, Vecteur b, Vecteur c)
 {
   A = a;
   B=b;
   C=c;
 }
 public void set_color(int r, int g, int b)
 {
   red = r;
   green=g;
   blue=b;
 }
 public Plan get_Plan()
 {
   Vecteur normal = A.Produit_Vectoriel(A.Difference(B, A), A.Difference(C,A));
   return new Plan(A.coordonees[0], A.coordonees[1], A.coordonees[2], -(A.coordonees[0]*normal.coordonees[0] + A.coordonees[1]*normal.coordonees[1] + A.coordonees[2]*normal.coordonees[2]) ) ;
 }

}
  final class Rayon
  {
     public Vecteur A = new Vecteur();
     public Vecteur B = new Vecteur();
     public double x_dir;
     public double y_dir;
     public double z_dir;
     public ArrayList<Triangle> seen = new ArrayList<Triangle>();
     public ArrayList<Vecteur> Inter = new ArrayList<Vecteur>();
     public void get_coef_dir()
     {
       x_dir = B.coordonees[0] - A.coordonees[0];
       y_dir = B.coordonees[1] - A.coordonees[1];
       z_dir = B.coordonees[2] - A.coordonees[2];
     }
     public void get_Intersection_with_Triangle(Triangle Tri)
     {
       //System.out.print("ok");
       Plan P = Tri.get_Plan();
       Vecteur u = A.Difference(Tri.B, Tri.A);
       Vecteur v = A.Difference(Tri.C, Tri.A);
       Vecteur n = B.Produit_Vectoriel(u, v);
       Vecteur r = new Vecteur(x_dir, y_dir, z_dir);
       Vecteur O_tr = A.Difference(A, Tri.A);
       double inter = A.Scalaire(n, r);
       
       double Ir = -A.Scalaire(n, O_tr)/inter;
       double Iu = A.Scalaire(A.Produit_Vectoriel( O_tr, v ), r)/inter;
       double Iv = A.Scalaire(A.Produit_Vectoriel( u, O_tr ), r)/inter;
       //System.out.print(Iv);
       if (   0<= Iu && Iu<=1 && 0<= Iv && Iv<=1 && 0<= Ir && Iu+Iv<=1 ) //Si cette condition est vérifiée, alors le rayon touche le triangle
       {
         seen.add(Tri);
         // Récupérons la position du point touché
           Inter.add(new Vecteur( Tri.A.coordonees[0] + multi( Iu, u).coordonees[0] + multi(Iv, v).coordonees[0],Tri.A.coordonees[1] + multi( Iu, u).coordonees[1] + multi(Iv, v).coordonees[1], Tri.A.coordonees[2] + multi( Iu, u).coordonees[2] + multi(Iv, v).coordonees[2]  ));
       }
       
     }
     public int[] get_color(ArrayList<Triangle> U, ArrayList<Light> L, double base_lumi)
     {
       seen = new ArrayList<Triangle>();
       Inter = new ArrayList<Vecteur>();
       for (Triangle i : U) 
       {
         get_Intersection_with_Triangle(i);
       }
       int n = seen.size();
       if (n == 0) 
       {
         int[] co = new int[3];
         co[0]= 0;
         co[1]= 0;
         co[2]= 0;
         return co;
       }
       else {
         double min = A.Norme( A.Difference(A, Inter.get(0)));
         Vecteur inter = new Vecteur();
         Triangle surface = new Triangle();
         int[] color_min = new int[3];
         color_min[0] = seen.get(0).red;
         color_min[1] = seen.get(0).green;
         color_min[2] = seen.get(0).blue;
         for ( int i=0; i< n; i++)
         {
           double no = A.Norme( A.Difference(A, Inter.get(i)));
           if ( no <= min)
           {
             color_min[0] = seen.get(i).red;
             color_min[1] = seen.get(i).green;
             color_min[2] = seen.get(i).blue;
             min = no;
             inter = Inter.get(i);
             surface = seen.get(i);
           }
         }
       Vecteur u = A.Difference(surface.B, surface.A);
       Vecteur v = A.Difference(surface.C, surface.A);
       Vecteur no = B.Produit_Vectoriel(u, v);
       double lumi = 0;
       
       for (Light i : L) 
       {
         Rayon patate = new Rayon();
         patate.A = inter;
         patate.B = i.Position;
         patate.get_coef_dir();
         int b = 0;
         Vecteur OM = A.Difference(patate.B, patate.A);
         double nOM = A.Norme(OM);
         for (Triangle j : U)
         {
           if (j.A != surface.A || j.B != surface.B || j.C != surface.C)
           {
             patate.get_Intersection_with_Triangle(j);
           }
         }
         for (Vecteur j : patate.Inter)
         {
           if (nOM > A.Norme(A.Difference(patate.A, j)))
           {

             b = 1;
           }
         }
         if (b == 0)
         {
           double cosangle = Math.abs(A.Scalaire(no, OM)/(A.Norme(no)* nOM));
           //System.out.print(cosangle);
           lumi = lumi + cosangle * i.intensite;
           lumi= get_coef_light(lumi, base_lumi);
         }
       }
       color_min[0] = (int)((double)color_min[0] * lumi);
       color_min[1] = (int)((double)color_min[1] * lumi);
       color_min[2] = (int)((double)color_min[2] * lumi);
       return color_min;
       }
     }
     
  }
  public class Light
{
  public Vecteur Position = new Vecteur();
  public double intensite = 1;
  public Light(Vecteur a, double i)
 {
   Position = a;
   intensite = i;
 }
}
public double get_coef_light( double power, double base_lum)
{
  return (Math.atan(power) * (1-base_lum) * (2/Math.PI) ) + base_lum;
}
 
public ArrayList<Rayon> get_rays(Vecteur Position, double angle_cam_z, double angle_cam_Oxy, double distance_cam_screen, int width_screen, int heigth_screen, double igw, double igh)
{
  ArrayList<Rayon> res = new ArrayList<Rayon>();
  for (int i = -width_screen; i< width_screen; i++)
  {
    for (int j = -heigth_screen; j< heigth_screen; j++)
    {
      Matrice3D truc = new Matrice3D();
      
      Vecteur v = new Vecteur(distance_cam_screen, i*(igw/width_screen), j*(igh/heigth_screen));
      Vecteur pt = truc.Mult(truc.RotationZ(angle_cam_Oxy), truc.Mult(truc.RotationY(angle_cam_z), v) );
      Rayon r = new Rayon();
      r.A = Position;
      r.B = new Vecteur(Position.coordonees[0] - pt.coordonees[0], Position.coordonees[1] - pt.coordonees[1], Position.coordonees[2] - pt.coordonees[2]);
      r.get_coef_dir();
      res.add(r);
    }
  }
  return res;
}
 
public void print_screen(int nb_pixel_h, int nb_pixel_l, int hauteur, int largeur, Vecteur Position, double angle_cam_z, double angle_cam_Oxy, double distance_cam_screen, ArrayList<Triangle> U, double igw, double igh, ArrayList<Light> L, double base_lumi)
{
  ArrayList<Rayon> rays = get_rays(Position,  angle_cam_z, angle_cam_Oxy, distance_cam_screen, nb_pixel_l, nb_pixel_h, igw, igh);
  int k = 0;
  float w = largeur/(2*nb_pixel_l);
  float h = hauteur/(2*nb_pixel_h);
  
  for (int i = -nb_pixel_l; i<nb_pixel_l; i++)
  {
   for (int j = -nb_pixel_h; j<nb_pixel_h; j++)
   {
     Rayon r = rays.get(k);
     k++;
     int[] c = r.get_color(U, L, base_lumi);
     stroke(c[0], c[1], c[2]);
     fill(c[0], c[1], c[2]);
     rect( (nb_pixel_l+i)*w, (nb_pixel_h+j)*h, w, h);
   }
  }
  
  
}
public Rayon ray = new Rayon();
public ArrayList<Triangle> Univers = new ArrayList<Triangle>();
public ArrayList<Light> Lumieres = new ArrayList<Light>();
public Vecteur Player = new Vecteur(50, 0, 0);
public int HAUTEUR = 50;
public int LARGEUR = 50;
public double h_screen = 10; //les tailles de l'écran dans le programme
public double w_screen = 10;
public double distance_cam_screen = 10;
public double angle_cam_Oxy = 0;
public double angle_cam_z = 0;

Light lulu2 = new Light(new Vecteur(60, 0, 0), 2);
Light lulu = new Light(new Vecteur(0, 200, 0), 0);
Light lulu3 = new Light(new Vecteur(0, 0, 90), 0);
Light lulu4 = new Light(new Vecteur(10, 10, 10), 0);

Triangle A = new Triangle( new Vecteur(30, 30, 30), new Vecteur(30, -30, -30) , new Vecteur(30, -30, 30));
Triangle B = new Triangle( new Vecteur(30, 30, 30), new Vecteur(30, -30, -30) , new Vecteur(30, 30, -30));
Triangle A2 = new Triangle( new Vecteur(-30, 30, 30), new Vecteur(-30, -30, -30) , new Vecteur(-30, -30, 30));
Triangle B2 = new Triangle( new Vecteur(-30, 30, 30), new Vecteur(-30, -30, -30) , new Vecteur(-30, 30, -30));

Triangle A3 = new Triangle( new Vecteur(30, 30, 30), new Vecteur(-30, 30, 30) , new Vecteur(30, -30, 30));
Triangle B3 = new Triangle( new Vecteur(-30, 30, 30), new Vecteur(-30, -30, 30) , new Vecteur(30, -30, 30));

Triangle A4 = new Triangle( new Vecteur(30, 30, -30), new Vecteur(-30, 30, -30) , new Vecteur(30, -30, -30));
Triangle B4 = new Triangle( new Vecteur(-30, 30, -30), new Vecteur(-30, -30, -30) , new Vecteur(30, -30, -30));


Triangle A5 = new Triangle( new Vecteur(30, 30, 30), new Vecteur(30, 30, -30) , new Vecteur(-30, 30, -30));
Triangle B5 = new Triangle( new Vecteur(30, 30, 30), new Vecteur(-30, 30, 30) , new Vecteur(-30, 30, -30));

Triangle A6 = new Triangle( new Vecteur(30, -30, 30), new Vecteur(30, -30, -30) , new Vecteur(-30, -30, -30));
Triangle B6 = new Triangle( new Vecteur(30, -30, 30), new Vecteur(-30, -30, 30) , new Vecteur(-30, -30, -30));



void setup()
{
  size(800, 800);
  fill(204);
  A.set_color(25, 125, 0);
  B.set_color(25, 125, 0);
  
  A2.set_color(125, 125, 25);
  B2.set_color(125, 125, 25);
  
  A3.set_color(255, 0, 0);
  B3.set_color(255, 0, 0);
 
  A4.set_color(0, 255, 0);
  B4.set_color(0, 255, 0);
  
  A5.set_color(0, 0, 255);
  B5.set_color(0, 0, 255);
  
  //A6.set_color(255, 0, 255);
  //B6.set_color(255, 0, 255);
  Lumieres.add(lulu);
  Lumieres.add(lulu2);
  Lumieres.add(lulu3);
  Lumieres.add(lulu4);
  Univers.add(A);
  Univers.add(B);
  Univers.add(A2);
  Univers.add(A3);
  Univers.add(B2);
  Univers.add(B3);
  Univers.add(B4);
  Univers.add(A4);
  Univers.add(B5);
  Univers.add(A5);
  Univers.add(B6);
  Univers.add(A6);
}

public Vecteur rotationZ(Vecteur v, double angle)
{
  Matrice3D truc = new Matrice3D();
  return truc.Mult(truc.RotationZ(angle), v);
}
public Vecteur rotationY(Vecteur v, double angle)
{
  Matrice3D truc = new Matrice3D();
  return truc.Mult(truc.RotationY(angle), v);
}
void draw() {
  background(0);
  ray.A = new Vecteur(50, 0, 0);
  ray.B = new Vecteur(30, 0, 0);
  ray.get_coef_dir();
  //int[] l = ray.get_color(Univers, Lumieres, 0.3);
  //System.out.print(l[0]);
  print_screen(HAUTEUR, LARGEUR, 800, 800, Player, angle_cam_z, angle_cam_Oxy, distance_cam_screen, Univers, w_screen, h_screen, Lumieres, 0.5);
  Lumieres.get(0).Position = rotationZ(Lumieres.get(0).Position, 0.01);
  Lumieres.get(0).Position = rotationY(Lumieres.get(0).Position, 0.02);
  Lumieres.get(1).Position = rotationZ(Lumieres.get(1).Position, 0.04);
  Lumieres.get(2).Position = rotationY(Lumieres.get(2).Position, 0.05);
}


void keyPressed() {
  if (key == 'z' || key == 'Z')
  {
        Player = rotationZ(rotationY(rotationZ(Player, -angle_cam_Oxy), 0.05), angle_cam_Oxy);
        angle_cam_z= angle_cam_z + 0.05;
  }
    if (key == 's' || key == 'S')
    {
        Player = rotationZ(rotationY(rotationZ(Player, -angle_cam_Oxy), -0.05), angle_cam_Oxy);
        angle_cam_z= angle_cam_z - 0.05;
    }
    if (key == 'q' || key == 'Q')
    {
        Player = rotationZ(Player, 0.05);
        angle_cam_Oxy= angle_cam_Oxy + 0.05;
    }
    if (key == 'd' || key == 'D')
    {
        Player = rotationZ(Player, -0.05);
        angle_cam_Oxy=angle_cam_Oxy - 0.05;
    }
    if (key == 'a' || key == 'A')
    {
      
      Player = multi(0.95, Player);

    }
        
    if (key == 'e' || key == 'E')
    {
      Player = multi(1.05, Player);
    }
    
  
}
