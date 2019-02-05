class Player { 
  float xpos;
  float ypos;
  int skin_sprites;
  int sprite_speed;
  float speed;

  int temp_i_sprite = 0, i_sprite = 1;
  String move_sprite = "down";

  Player(float tempXpos, float tempYpos, int tempSkin_sprites, int tempSprite_speed, float tempSpeed) { 
    xpos = tempXpos;
    ypos = tempYpos;
    skin_sprites = tempSkin_sprites;
    sprite_speed = tempSprite_speed;
    speed = tempSpeed;
  }

  void display() {
    myPlayer_sprite = loadImage(skin+"\\"+move_sprite+"_"+nf(i_sprite, 2, 0)+".png");
    image(myPlayer_sprite, xpos, ypos);
  }

  void move(boolean right, boolean left, boolean down, boolean up) {
    if (right && !left && !down && !up && (xpos + speed < (width - myPlayer_sprite.width) || OpenWorld) && !player_colide_r) { //Droite
      xpos = xpos + speed;
      move_sprite = "right";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (!right && left && !down && !up && (xpos - speed > 0 || OpenWorld) && !player_colide_l) { //Gauche
      xpos = xpos - speed;
      move_sprite = "left";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (!right && !left && down && !up && (ypos + speed < (height - myPlayer_sprite.height) || OpenWorld) && !player_colide_d) { //Bas
      ypos = ypos + speed;
      move_sprite = "down";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (!right && !left && !down && up && (ypos - speed > 0 || OpenWorld) && !player_colide_u) { //Haut
      ypos = ypos - speed;
      move_sprite = "up";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (right && !left && down && !up && diag) { //Droite + Bas
      xpos = xpos + speed/2;
      ypos = ypos + speed/2;
      move_sprite = "down";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (right && !left && !down && up && diag) { //Droite + Haut
      xpos = xpos + speed/2;
      ypos = ypos - speed/2;
      move_sprite = "up";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (!right && left && down && !up && diag) { //Gauche + Bas
      xpos = xpos - speed/2;
      ypos = ypos + speed/2;
      move_sprite = "down";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } else if (!right && left && !down && up && diag) { //Gauche + Haut
      xpos = xpos - speed/2;
      ypos = ypos - speed/2;
      move_sprite = "up";
      temp_i_sprite++;
      if (temp_i_sprite >= sprite_speed) {
        i_sprite++;
        temp_i_sprite = 0;
      }
    } 

    if (i_sprite > skin_sprites) {
      i_sprite = 1;
    }

    /** "OpenWorld" **/
    if (OpenWorld) {
      if (xpos > (width - myPlayer_sprite.width)) {
        xpos = 0;
      } else if (xpos < 0) {
        xpos = width - myPlayer_sprite.width;
      } else if (ypos > (height - myPlayer_sprite.height)) {
        ypos = 0;
      } else if (ypos < (0 - myPlayer_sprite.height)) {
        ypos = height - myPlayer_sprite.height;
      }
    }
  }

  String direction() {
    return move_sprite;
  }
}

class Attack {
  float xpos, ypos;
  int speed;

  int temp_i_attack = 0, i_attack = 5;

  Attack(float tempXpos, float tempYpos, int tempAttack_speed) {
    xpos = tempXpos;
    ypos = tempYpos;
    speed = tempAttack_speed;
  }

  void display() {
    if (attack_0) {
      myAttack.attack_0();
    }
  }

  void attack_0() {
    if (temp_direction == "right" && xpos+myPlayer_sprite.width+i_attack < width+30) {
      image(myPlayer_attack, xpos+myPlayer_sprite.width+i_attack, ypos+myPlayer_sprite.height/4); 
      temp_i_attack++;
      if (temp_i_attack >= speed) {
        i_attack = i_attack + 20;
        temp_i_attack = 0;
      }
    } else if (temp_direction == "left" && xpos-myPlayer_sprite.width-i_attack > 0-30) {
      image(myPlayer_attack, xpos-myPlayer_sprite.width-i_attack, ypos+myPlayer_sprite.height/4);
      temp_i_attack++;
      if (temp_i_attack >= speed) {
        i_attack = i_attack + 20;
        temp_i_attack = 0;
      }
    } else if (temp_direction == "down" && ypos+myPlayer_sprite.height+i_attack < height+30) {
      image(myPlayer_attack, xpos+myPlayer_sprite.width/4, ypos+myPlayer_sprite.height+i_attack);
      temp_i_attack++;
      if (temp_i_attack >= speed) {
        i_attack = i_attack + 20;
        temp_i_attack = 0;
      }
    } else if (temp_direction == "up" && ypos-myPlayer_sprite.height/2-i_attack > 0-30) {
      image(myPlayer_attack, xpos+myPlayer_sprite.width/4, ypos-myPlayer_sprite.height/2-i_attack);
      temp_i_attack++;
      if (temp_i_attack >= speed) {
        i_attack = i_attack + 20;
        temp_i_attack = 0;
      }
    } else {
      attack_0 = false;
      i_attack = 0;
    }
  }
}

class World {
  int level;
  int x1 = int(random(50, width-50)), x2 = int(random(50, width-50));
  int y1 = int(random(50, height-50)), y2 = int(random(50, height-50));
  float tempMoney;

  boolean chest1 = true, chest2 = true;

  World(int tempLevel) {
    level = tempLevel;
  }

  void displayTerrain() {
    if (!check_attackColide(x1-5, y1, x1+30, y1+21, 0) && chest1) {
      image(chest_lock, x1, y1);
      check_playerColide(x1-5, y1, x1+30, y1+21);
    } else if (check_attackColide(x1-5, y1, x1+30, y1+21, 0) && chest1) {
      //attack_colide = false;
      image(explode, x1-10, y1-10);
      chest1 = false;
      tempMoney = random(100,300);
      money = money + tempMoney;
      println("Boom ! Tu viens d'obtenir "+nf(tempMoney,0,2)+"$ en ouvrant le coffre n°1 !");
      println("Tu as maintenant "+nf(money,0,2)+"$ sur toi !");
    } else if (!chest1) {
      image(chest_open, x1, y1);
      check_playerColide(x1-5, y1, x1+30, y1+21);
    }
    
    if (!check_attackColide(x2-5, y2, x2+30, y2+21, 0) && chest2) {
      image(chest_lock, x2, y2);
      check_playerColide(x2-5, y2, x2+30, y2+21);
    } else if (check_attackColide(x2-5, y2, x2+30, y2+21, 0) && chest2) {
      //attack_colide = false;
      image(explode, x2-10, y2-10);
      chest2 = false;
      tempMoney = random(100,300);
      money = money + tempMoney;
      println("Boom ! Tu viens d'obtenir "+nf(tempMoney,0,2)+"$ en ouvrant le coffre n°2 !");
      println("Tu as maintenant "+nf(money,0,2)+"$ sur toi !");
    } else if (!chest2) {
      image(chest_open, x2, y2);
      check_playerColide(x2-5, y2, x2+30, y2+21);
    }

    //fill(255,0,0);
    //rect(x1, y1, 30, 21);
    //rect(x2, y2, 30, 21);
    //fill(255,255,0);
    //rect(myPlayer.xpos + myPlayer_sprite.width/2, myPlayer.ypos + myPlayer_sprite.height/1.2, 5, 5);
  }

  void setBackground() {
    if (level <= 7) {
      background = loadImage("background"+"\\"+"bg_"+nf(level, 2, 0)+".png");
      background.resize(width, height);
    } else {
      println("Error - level max !");
    }
  }

  void addLevel() {
    if (level <= 7) {
    level++;
    x1 = int(random(50, width-50));
    x2 = int(random(50, width-50));
    y1 = int(random(50, height-50));
    y2 = int(random(50, height-50));
    chest1 = true;
    chest2 = true;
    myWorld.setBackground();
    } else {
      println("Error - level max !");
    }
  }
}