*-----------------------------------------------------------
* Title      : Niveau 2
* Written by : Simon
* Date       : 22/12/2021
*-----------------------------------------------------------
NIVEAU_2:

    MOVE.L  #C0, A0 *On met dans A0 l'adresse du premier élément du tableau correspondant à la présence de murs en longueur
    MOVE.L  #L0, A1 *On met dans A1 l'adresse du premier élément du tableau correspondant à la présence de murs en largeur

  
    *On met la couleur du fond de la fenêtre en noir
    MOVE.L  #$00000000, D1
    JSR     SET_FILL_COLOR
    MOVE    #0,D1
    MOVE    #0,D2
    MOVE    #1280,D3
    MOVE    #720,D4
    JSR     DRAW_FILL_RECT 
    
    *Couleur du contour (blanc)
    MOVE.L  #$00FFFFFF, D1 
    JSR     SET_PEN_COLOR
    
    *Contour du labyrinthe
    MOVE    #64,D1
    MOVE    #36,D2
    MOVE    #1216,D3
    MOVE    #684,D4
    JSR     DRAW_FILL_RECT
    
    *Ligne d'entrée du labyrinthe (rouge) : 
    MOVE    #$000000F2,D1
    JSR     SET_PEN_COLOR
    
    MOVE    #64,D1
    MOVE    #324,D2
    MOVE    #64,D3
    MOVE    #360,D4
    JSR     DRAW_LINE
    
    *Ligne de sortie du labyrinthe (bleu) : 
    MOVE.L  #$00F20000,D1
    JSR     SET_PEN_COLOR
    
    MOVE    #1216,D1
    MOVE    #288,D2
    MOVE    #1216,D3
    MOVE    #324,D4
    JSR     DRAW_LINE
    
    *On précise la couleur dans laquelle devront être les murs : en blanc
    MOVE.L  #$00FFFFFF, D1 
    JSR     SET_PEN_COLOR
    
  
    *A partir d'ici on dessine les murs en longueur dans le labyrinthe (colonnes)
        
        *Coordonnés du premier mur à dessiner = Mur compris entre 64 et 136 en x (64 et 136 réservés aux murs dessinés en largeur, on dessine à partir de 65 jusqu'à 135) *Voir image 1 et 2 en annexe
        
        
        *Coordonnée 1
        MOVE.L  #65,D1
        MOVE.L  #72,D2
        *Coordonnée 2
        MOVE.L  #99,D3 
        MOVE.L  #72,D4
    
    
        MOVE.L  #32,D6 *On précise le nombre de fois que l'on va itérer la boucle à partir du label BOUCLE_COLONNES (32 fois car 1152/36 = 32 correspondant au nombre de colonne de carrés : Dans ce niveau les carrés font 36*36 px)

    BOUCLE_COLONNES:
        MOVE.L  #18,D5 *On précise le nombre de fois que l'on va itérer la boucle à partir du label SIL5 (648/36 = 18 correspondant au nombre de lignes de carrés dans le labyrinthe)

    SIL5:
        SUB.B   #1,D5
        CMP.B   #0,D5
        BEQ     COLONNE_SUIVANTE *Si on a fini de compléter une colonne on s'apprête à passer à la colonne suivante
        
        CMP.B   #1,(A0) *On vérifie à partir d'ici s'il y a un mur à dessiner (à l'aide du tableau préalablement remplie de ces informations)
        BNE     POSITION_SUIVANTE *Si ce n'est pas le cas, on passe aux murs qui lui précèdent pour vérifier cette même condition et ainsi de suite...
        JSR     DRAW_LINE
        
    POSITION_SUIVANTE:
        *On incrémente la position du mur à la position du prochain mur
        ADD.L   #36,D2 
        ADD.L   #36,D4
        ADD.L   #1,A0  *On incrémente d'un octet la position dans le tableau (on se place à la case suivante du tableau)
        BRA     SIL5
           
    COLONNE_SUIVANTE:
        *On incrémente la position du mur à la position du prochain mur (ici à lieu un changement de colonne)
        ADD.L   #36,D1  
        ADD.L   #36,D3
        MOVE.L  #72,D2   
        MOVE.L  #72,D4 
        
        SUB.B   #1,D6
        CMP.B   #0,D6
        BNE     BOUCLE_COLONNES  *Si on n'a pas parcouru tous les murs en longueur on continue, sinon on continue dans le programme

               
    *A partir d'ici on dessine les murs en largeur dans le labyrinthe (lignes)
    
            *Coordonnés du premier mur à dessiner = Mur compris entre 36 et 72 en y (36 et 72 réservés aux murs dessinés en longueur, on dessine à partir de 37 jusqu'à 71) *Voir image 1 et 2 en annexe

        *Coordonné 1
        MOVE.L  #100,D1
        MOVE.L  #37,D2
        *Coordonné 2
        MOVE.L  #100,D3
        MOVE.L  #71,D4
    
        MOVE.L  #18,D6 *On précise le nombre de fois que l'on va itérer la boucle à partir du label BOUCLE_LIGNES (18 fois car 648/36 = 18 correspondant on nombre de lignes de carrés : Dans ce niveau les carrés font 36*36 px)
    
    BOUCLE_LIGNES:
        MOVE.L  #32,D5 *On précise le nombre de fois que l'on va itérer la boucle à partir du label SIL6 (1152/36 = 32 correspondant au nombre de colonnes de carré dans le labyrinthe)
    
    SIL6:
        SUB.B   #1,D5
        CMP.B   #0,D5
        BEQ     LIGNE_SUIVANTE Si on a fini de compléter une ligne on s'apprête à passer à la ligne suivante
        
        CMP.B   #1,(A1) *On vérifie à partir d'ici s'il y a un mur à dessiner (à l'aide du tableau préalablement remplie de ces informations)
        BNE     PROCHAINE_POSITION *Si ce n'est pas le cas, on passe aux murs qui lui précèdent pour vérifier cette même condition et ainsi de suite...
        JSR     DRAW_LINE
        
    PROCHAINE_POSITION:
        *On incrémente la position du mur à la position du prochain mur
        ADD.L   #36,D1
        ADD.L   #36,D3
        ADD.L   #1,A1 *On incrémente d'un octet la position dans le tableau (on se place à la case suivante du tableau)
        BRA     SIL6
        
    LIGNE_SUIVANTE:
        MOVE.L  #100,D1 
        ADD.L   #36,D2  
        MOVE.L  #100,D3 
        ADD.L   #36,D4 
        
        SUB.B   #1,D6
        CMP.B   #0,D6
        BNE     BOUCLE_LIGNES *Si on n'a pas parcouru tous les murs en longueur on continue, sinon cela signifie que l'on a fini de dessiner le labyrinthe !

        
    RTS
 
    ORG $4000
    
    *Colonnes :  1 = mur, 0 = pas de mur
    C0: DC.B 0,1,0,0,1,0,0,1,1,0,0,0,0,0,1,1,1,0,0,1,0,0,0,0,1,0,0,0,1,1,0,1,0,0,0,1,0,1,0,1,0,1,1,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,1,0,0,0,0,1
    C1: DC.B 1,1,0,1,0,1,0,0,1,0,0,0,1,0,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,1,0,1,1,0,1,0,0,0,0,0,0,0,0,0,1,1
    C2: DC.B 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0,1,0,0,1,0,1,1,1,0,0,1,0,1,0,0,1,1,1,0,0,1,0,0,1,0,0,1,0,0,1,0,1
    C3: DC.B 0,0,0,0,1,0,0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,0,1,1,0,0,0,1,0,1,1,0,0,1,1,0,0,1,0,0,0,1,0,1,0,0,0,1,1,1,1,0,0,0,0,1,0,0,1,0,0,1,1,0,1,1,0,0
    C4: DC.B 0,0,1,1,0,0,0,0,1,1,0,1,1,1,0,0,0,0,0,0,1,0,0,1,1,0,1,0,0,1,1,0,0,0,0,0,0,1,0,1,0,0,0,1,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,1,1,0   
    C5: DC.B 0,0,1,0,1,1,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,1,1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,1,0
    C6: DC.B 0,0,1,1,0,0,1,0,0,0,0,1,0,0,0,1,1,1,0,1,0,1,0,0,1,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,1,0,1,1,0,1,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,1,0,1,0,1,0,0
    C7: DC.B 1,0,0,1,0,1,0,1,1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,1,1,0,1,0,1,0,1,0,0,0,0,1,1,0,1,1,1,1,1,0,1,0,1,0,0,1,0
    
    ORG $4300
    
    *Lignes :  1 = mur, 0 = pas de mur
    L0: DC.B 1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,0,0,1,0,0,1,0,1,1,1,1,0,1,1,1,1,1,1,1,0,1,0,1,1,1,0,0,1,0,0,1,0,1,0,1,0,1,0
    L1: DC.B 0,0,0,0,1,0,0,0,1,1,1,0,0,1,0,1,1,1,0,1,0,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,1,0,1,0,1,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,1,1,0,1
    L2: DC.B 0,1,1,1,1,1,0,0,0,0,1,0,0,1,0,0,1,0,1,0,1,0,1,1,0,0,0,0,1,1,0,1,1,0,0,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,1,0,0,1,0,0,0,1,0,1
    L3: DC.B 0,0,1,1,0,1,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,1,0,1,0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,0,1,1,0,0,1,0,0,0,1,1,0,0
    L4: DC.B 0,1,1,1,1,1,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,1,1,0,1,0,1,1,1,0,1,0,0,1,0,1,1,0,0,0,1,0,1,0,0,1,0,0,0,1,0,1,1,0,1,0,0
    L5: DC.B 0,1,1,1,1,0,1,1,0,0,0,1,0,0,0,1,0,0,1,1,1,1,1,0,1,0,0,1,0,0,0,1,0,0,1,0,1,0,1,1,1,1,0,0,1,1,1,1,1,0,1,0,1,0,1,0,0,0,0,1,1,1    
    L6: DC.B 0,1,0,1,0,1,0,1,1,1,1,0,0,1,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,1,0,0,0,0,0,0,1,1
    L7: DC.B 1,0,1,1,1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,1,1,0,1,0,0,1,0,0,1,0,0,1,0,1,1,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1    
    L8: DC.B 0,1,0,0,1,0,1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,0,0,1,0,0,1,0

       
    




















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
