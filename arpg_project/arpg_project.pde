import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

/** Options **/
boolean diag = false; //Active ou non le déplacement en diagonale | NOTE : contraintes non-openworld non mis en place pour le déplacement en diagonale
boolean OpenWorld = false; //Contraintes de déplacements hors de la fenêtre désactivés ou non
/** Options **/

float money = 0;

Player myPlayer;
PImage myPlayer_sprite;
String skin;
int skin_sprites, skin_sprite_speed;
float player_speed;
int attack_speed;
boolean right = false, left = false, down = false, up = false;
boolean player_colide_r = false, player_colide_l = false, player_colide_d = false, player_colide_u = false;
boolean attack_colide = false;

Attack myAttack;
PImage myPlayer_attack;
String temp_direction;
boolean attack_0 = false;

World myWorld;
PImage background;
PImage chest_lock, chest_open;
PImage explode;

void setup() {
  /** Paramètres **/
  size(600, 600); //Taille de la fenêtre
  skin = "Jack"; //Nom du personnage choisis
  smooth();

  /** Caractéristique des personnages **/
  if (skin == "Jack") {
    skin_sprites = 9; //Nombre d'animations disponibles
    skin_sprite_speed = 5; //Vitesse d'animation lors de déplacements
    player_speed = 4.2; //Vitesse du joueur
    attack_speed = 2;
  } else if (skin == "kevin") {
    skin_sprites = 9;
    skin_sprite_speed = 5;
    player_speed = 4.2;
    attack_speed = 2;
  } else {
    println("Error setup skin");
  }

  /** Initialisation **/
  myPlayer_sprite = loadImage(skin+"\\"+"down"+"_"+"01"+".png");
  myPlayer = new Player(width/2-myPlayer_sprite.width, height/2-myPlayer_sprite.height, skin_sprites, skin_sprite_speed, player_speed);
  myAttack = new Attack(myPlayer.xpos, myPlayer.ypos, attack_speed);
  myWorld = new World(0);
  myWorld.addLevel();
  chest_lock = loadImage("chest_lock.png");
  chest_open = loadImage("chest_open.png");
  explode = loadImage("explode.png");
}

void draw() {
  background(background);
  myWorld.displayTerrain();
  myPlayer.display();
  myPlayer.move(right, left, down, up);
  myAttack.display();
  //println(colide_r, colide_l, colide_d, colide_u);
  player_colide_r = false;
  player_colide_l = false;
  player_colide_d = false;
  player_colide_u = false;
  //println(attack_colide);
  
  textSize(14);
  fill(255,55,0);
  text("Niveau : "+myWorld.level, 10, 20);
  text("Personnage : "+skin, 10, 20+20);
  text("Argent : "+nf(money,0,2)+"$", 10, 20+40);
}