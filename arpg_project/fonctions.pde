void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      right = true;
    } else if (keyCode == LEFT) {
      left = true;
    } else if (keyCode == DOWN) {
      down = true;
    } else if (keyCode == UP) {
      up = true;
    }
  }
  if (key == 'l') {
    myWorld.addLevel();
  }
  if (key == '0') {
    if (!attack_0) {
      temp_direction = myPlayer.direction();
      myPlayer_attack = loadImage("attack"+"\\"+"attack_0_"+temp_direction+".png");
      myAttack = new Attack(myPlayer.xpos, myPlayer.ypos, attack_speed);
      attack_0 = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      right = false;
    } else if (keyCode == LEFT) {
      left = false;
    } else if (keyCode == DOWN) {
      down = false;
    } else if (keyCode == UP) {
      up = false;
    }
  }
}

void check_playerColide(float x1, float y1, float x2, float y2) {
    float xpos = myPlayer.xpos + myPlayer_sprite.width/1.5;
    float ypos = myPlayer.ypos + myPlayer_sprite.height/1.1;
  
    if (xpos + player_speed > x1 && xpos + player_speed < x2 && ypos > y1 && ypos < y2) { 
      player_colide_r = true;
    }
    
    if (xpos - player_speed > x1 && xpos - player_speed < x2 && ypos > y1 && ypos < y2) {
      player_colide_l = true;
    }
    
    if (xpos > x1 && xpos < x2 && ypos + player_speed > y1 && ypos + player_speed < y2) { 
      player_colide_d = true;
    }
    
    if (xpos > x1 && xpos < x2 && ypos - player_speed > y1 && ypos - player_speed < y2) {
      player_colide_u = true;
    }
}

boolean check_attackColide(float x1, float y1, float x2, float y2, int attack) {
    float xpos = 0;
    float ypos = 0;
    
    if (attack == 0) {
      if (temp_direction == "right") {
      xpos = myAttack.xpos+myPlayer_sprite.width+myAttack.i_attack;
      ypos = myAttack.ypos+myPlayer_sprite.height/4;
      } else if (temp_direction == "left") {
      xpos = myAttack.xpos-myPlayer_sprite.width-myAttack.i_attack;
      ypos = myAttack.ypos+myPlayer_sprite.height/4;
      } else if (temp_direction == "down") {
      xpos = myAttack.xpos+myPlayer_sprite.width/4;
      ypos = myAttack.ypos+myPlayer_sprite.height+myAttack.i_attack;
      } else if (temp_direction == "up") {
      xpos = myAttack.xpos+myPlayer_sprite.width/4;
      ypos = myAttack.ypos-myPlayer_sprite.height/2-myAttack.i_attack;
      }
    }
  
    if (xpos > x1 && xpos < x2 && ypos > y1 && ypos < y2) { 
      //attack_colide = true;
      return true;
    }
    return false;
    //return attack_colide;
}