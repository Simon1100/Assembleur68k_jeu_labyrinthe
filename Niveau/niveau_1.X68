*-----------------------------------------------------------
* Title      : Niveau 1
* Written by : Simon
* Date       : 02/12/2021
* Description:
*-----------------------------------------------------------
NIVEAU_1:
    
    MOVE.L #TAB1, A0 *On met dans A0 l'adresse du premier �l�ment du tableau correspondant � la pr�sence de murs en longueur
    MOVE.L #TAB2, A1 *On met dans A1 l'adresse du premier �l�ment du tableau correspondant � la pr�sence de murs en largeur
    
    
    *On met la couleur du fond de la fen�tre en noir  (c'est d�j� le cas par d�faut, pour des raisons de s�curit� on le laisse)
    MOVE.L  #$00000000, D1
    JSR     SET_FILL_COLOR
    MOVE.L #0,D1
    MOVE.L #0,D2
    MOVE.L #1280,D3
    MOVE.L #720,D4
    JSR  DRAW_FILL_RECT
    
    *On pr�cise la couleur dans laquelle devra �tre le contour
    MOVE.L  #$00FFFFFF, D1 
    JSR     SET_PEN_COLOR
    
    *On dessine le contour du labyrinthe
    MOVE.L #64,D1
    MOVE.L #36,D2
    MOVE.L #1216,D3
    MOVE.L #684,D4
    JSR DRAW_FILL_RECT
    
    *On place l'entr�e du labyrinthe en rouge (esth�tique)
    MOVE.L #$000000F2,D1
    JSR SET_PEN_COLOR
    MOVE.L #64,D1
    MOVE.L #36,D2
    MOVE.L #64,D3
    MOVE.L #108,D4
    JSR DRAW_LINE
    
    *On place la sortie du labyrinthe en bleu
    MOVE.L #$00F20000,D1
    JSR SET_PEN_COLOR
    MOVE.L #1216,D1
    MOVE.L #612,D2
    MOVE.L #1216,D3
    MOVE.L #684,D4
    JSR DRAW_LINE
    
    *On pr�cise la couleur dans laquelle devront �tre les murs : en blanc
    MOVE.L  #$00FFFFFF, D1 
    JSR     SET_PEN_COLOR
    
    
    *A partir d'ici on dessine les murs en longueur dans le labyrinthe (colonnes)
    
        *Coordonn�s du premier mur � dessiner = Mur compris entre 64 et 136 en x (64 et 136 r�serv� aux murs dessin� en largeur, on dessine � partir de 65 jusqu'� 135) *Voir image 1 et 2 en annexe
        
        *Coordonn�e 1
        MOVE.L #65,D1 
        MOVE.L #108,D2
        *Coordonn�e 2
        MOVE.L #135,D3
        MOVE.L #108,D4 
    
    
        MOVE.L #16,D6 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label I (16 fois car 1152/72 = 16 correspondant au nombre de colonne de carr�s : Dans ce niveau les carr�s font 72*72 px)
        
    I:
        MOVE.L #9,D5 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label SIL (648/72 = 9 correspondant au nombre de lignes de carr�s dans le labyrinthe)
    
    SIL:
        ADD.W #-1,D5
        CMP.W #0,D5 
        BEQ FINSIL *Si on a fini de compl�ter une colonne on s'appr�te � passer � la colonne suivante
        
        CMP.B #1,(A0) *On v�rifie � partir d'ici s'il y a un mur � dessiner (� l'aide du tableau pr�alablement remplie de ces informations)
        BNE ALORSIL *Si ce n'est pas le cas, on passe aux murs qui lui pr�c�dent pour v�rifier cette m�me condition et ainsi de suite...
        JSR DRAW_LINE 
        
    ALORSIL:
        *On incr�mente la position du mur � la position du prochain mur
        ADD.L #72,D2
        ADD.L #72,D4
        ADD.L #1,A0 *On incr�mente d'un octet la position dans le tableau (on se place � la case suivante du tableau)
        BRA SIL
        
    FINSIL:
        *On incr�mente la position du mur � la position du prochain mur (ici � lieu un changement de colonne)
        ADD.L #72,D1
        MOVE.L #108,D2
        ADD.L #72,D3
        MOVE.L #108,D4
        
        
        ADD.L #-1,D6
        CMP.L #0,D6
        BNE I *Si on n'a pas parcouru tous les murs en longueur on continue, sinon on continue dans le programme
        
              
    *A partir d'ici on dessine les murs en largeur dans le labyrinthe (lignes)
    
        *Coordonn�s du premier mur � dessiner = Mur compris entre 36 et 108 en y (36 et 108 reserv� aux murs dessin�s en longueur, on dessine � partir de 37 jusqu'� 107) *Voir image 1 et 2 en annexe

        *Coordonn�e 1
        MOVE.L #136,D1
        MOVE.L #37,D2
        *Coordonn�e 2
        MOVE.L #136,D3
        MOVE.L #107,D4
    
        MOVE.L #9,D6 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label I2 (9 fois car 648/72 = 9 correspondant on nombre de lignes de carr�s : Dans ce niveau les carr�s font 72*72 px)
        
    I2:
        MOVE.L #16,D5 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label SIL2 (1152/72 = 16 correspondant au nombre de colonnes de carr�s dans le labyrinthe)

    SIL2:
        ADD.L #-1,D5
        CMP.L #0,D5
        BEQ FINSIL2 *Si on a fini de compl�ter une ligne on s'appr�te � passer � la ligne suivante
        
        CMP.B #1,(A1) *On v�rifie � partir d'ici s'il y a un mur � dessiner (� l'aide du tableau pr�alablement remplie de ces informations)
        BNE ALORSIL2 *Si ce n'est pas le cas, on passe aux murs qui lui pr�c�dent pour v�rifier cette m�me condition et ainsi de suite...
        JSR DRAW_LINE
        
    ALORSIL2:
        *On incr�mente la position du mur � la position du prochain mur
        ADD.L #72,D1
        ADD.L #72,D3
        ADD.L #1,A1 *On incr�mente d'un octet la position dans le tableau (on se place � la case suivante du tableau)
        BRA SIL2
        
    FINSIL2:
        MOVE.L #136,D1
        ADD.L #72,D2
        MOVE.L #136,D3
        ADD.L #72,D4
        ADD.L #-1,D6
        CMP.L #0,D6
        BNE I2 *Si on n'a pas parcouru tous les murs en longueur on continue, sinon cela signifie que l'on a fini de dessiner le labyrinthe !
        
        
    RTS    

    ORG $2000
    TAB1: DC.B 1,1,1,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,1,0,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,0,0,0,0,1,0,0,0,1,0,1,0,0,1,0,0,0,1,1,0,1,0,0,0,1,0,0,1,1,1,1,0,0,1,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,0,1,1,0,0,1,1,1,1,1,0,1,0,0,1,0,0,0,0,1,0,1,1,1,1,1
    TAB1BIS: DC.B 1,0,0,0,0,0,0,1,0,1,0,1,0,0,1,0
  
    ORG $2300
    TAB2: DC.B 0,1,0,0,1,1,0,0,0,0,0,0,1,1,0,1,0,0,0,0,1,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,1,1,0,0,1,1,0,0,1,1,0,1,1,1,0,1,0,0,1,0,0,1,1,0,1,1,0,0,0,1,1,1,1,0,1,0,0,1,1,0,0,1,1,1,0,1,0,1,1,0,1,1,0,0,1,1,0,1,1,1,0,0,0,1,0,1,0,0,1,1,1,1,1
    TAB2BIS: DC.B 0,0,1,0,0,0,1,1,1,0,0,0,0,0,1,1


   

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
