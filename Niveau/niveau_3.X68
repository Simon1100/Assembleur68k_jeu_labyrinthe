*-----------------------------------------------------------
* Title      : Niveau 3
* Written by : Simon
* Date       : 02/12/2021
*-----------------------------------------------------------
NIVEAU_3:
    
    MOVE.L #TAB3, A0 *On met dans A0 l'adresse du premier �l�ment du tableau correspondant � la pr�sence de murs en longueur
    MOVE.L #TAB4, A1 *On met dans A1 l'adresse du premier �l�ment du tableau correspondant � la pr�sence de murs en largeur

    
    *On met la couleur du fond de la fen�tre en noir 
    MOVE.L  #$00000000, D1
    JSR     SET_FILL_COLOR
    MOVE.L #0,D1
    MOVE.L #0,D2
    MOVE.L #1280,D3
    MOVE.L #720,D4
    JSR DRAW_FILL_RECT
    
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
    MOVE.L #648,D2
    MOVE.L #64,D3
    MOVE.L #684,D4
    JSR DRAW_LINE
    
    *On place la sortie du labyrinthe en bleu
    MOVE.L #$00F20000,D1
    JSR SET_PEN_COLOR
    MOVE.L #1216,D1
    MOVE.L #36,D2
    MOVE.L #1216,D3
    MOVE.L #72,D4
    JSR DRAW_LINE
    
    *On pr�cise la couleur dans laquelle devront �tre les murs : en blanc
    MOVE.L  #$00FFFFFF, D1 
    JSR     SET_PEN_COLOR
    
    
    *A partir d'ici on dessine les murs en longueur dans le labyrinthe (colonnes)
    
        *Coordonn�s du premier mur � dessiner = Mur compris entre 64 et 100 en x (64 et 100 r�serv�s aux murs dessin�s en largeur, on dessine � partir de 65 jusqu'� 99) *Voir image 1 et 2 en annexe

        *Coordonn�e 1
        MOVE.L #65,D1
        MOVE.L #72,D2
        *Coordonn�e 2
        MOVE.L #99,D3
        MOVE.L #72,D4
    
    
        MOVE.L #32,D6 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label I3 (32 fois car 1152/36 = 32 correspondant au nombre de colonne de carr�s : Dans ce niveau les carr�s font 36*36 px)
        
    I3:
        MOVE.L #18,D5 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label SIL3 (648/36 = 18 correspondant au nombre de lignes de carr�s dans le labyrinthe)
    
    SIL3:
        ADD.W #-1,D5 
        CMP.W #0,D5
        BEQ FINSIL3 *Si on a fini de compl�ter une colonne on s'appr�te � passer � la colonne suivante
        
        CMP.B #1,(A0) *On v�rifie � partir d'ici s'il y a un mur � dessiner (� l'aide du tableau pr�alablement remplie de ces informations)
        BNE ALORSIL3 *Si ce n'est pas le cas, on passe aux murs qui lui pr�c�dent pour v�rifier cette m�me condition et ainsi de suite...
        JSR DRAW_LINE
        
    ALORSIL3:
        *On incr�mente la position du mur � la position du prochain mur
        ADD.L #36,D2
        ADD.L #36,D4
        ADD.L #1,A0  *On incr�mente d'un octet la position dans le tableau (on se place � la case suivante du tableau)
        BRA SIL3
        
        
    FINSIL3:
        *On incr�mente la position du mur � la position du prochain mur (ici � lieu un changement de colonne)
        ADD.L #36,D1
        MOVE.L #72,D2
        ADD.L #36,D3
        MOVE.L #72,D4
        
        ADD.L #-1,D6
        CMP.L #0,D6
        BNE I3 *Si on n'a pas parcouru tous les murs en longueur on continue, sinon on continue dans le programme
        
        
    *A partir d'ici on dessine les murs en largeur dans le labyrinthe (lignes)
    
        *Coordonn�s du premier mur � dessiner = Mur compris entre 36 et 72 en y (36 et 72 r�serv�s aux murs dessin�s en longueur, on dessine � partir de 37 jusqu'� 71) *Voir image 1 et 2 en annexe

        *Coordonn�e 1
        MOVE.L #100,D1
        MOVE.L #37,D2
        *Coordonn�e 2
        MOVE.L #100,D3
        MOVE.L #71,D4
    
        MOVE.L #18,D6 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label I4 (18 fois car 648/36 = 18 correspondant on nombre de lignes de carr� : Dans ce niveau les carr�s font 36*36 px)
        
    I4:
        MOVE.L #32,D5 *On pr�cise le nombre de fois que l'on va it�rer la boucle � partir du label SIL4 (1152/36 = 32 correspondant au nombre de colonnes de carr� dans le labyrinthe)

    SIL4:
        ADD.L #-1,D5
        CMP.L #0,D5
        BEQ FINSIL4 Si on a fini de compl�ter une ligne on s'appr�te � passer � la ligne suivante
        
        CMP.B #1,(A1) *On v�rifie � partir d'ici s'il y a un mur � dessiner (� l'aide du tableau pr�alablement remplie de ces informations)
        BNE ALORSIL4 *Si ce n'est pas le cas, on passe aux murs qui lui pr�c�dent pour v�rifier cette m�me condition et ainsi de suite...
        JSR DRAW_LINE
        
    ALORSIL4:
        *On incr�mente la position du mur � la position du prochain mur
        ADD.L #36,D1
        ADD.L #36,D3
        ADD.L #1,A1 *On incr�mente d'un octet la position dans le tableau (on se place � la case suivante du tableau)
        BRA SIL4
        
    FINSIL4:
        MOVE.L #100,D1
        ADD.L #36,D2 
        MOVE.L #100,D3
        ADD.L #36,D4
        ADD.L #-1,D6
        CMP.L #0,D6
        BNE I4 *Si on n'a pas parcouru tous les murs en longueur on continue, sinon cela signifie que l'on a fini de dessiner le labyrinthe !

       

 
    RTS
   
    
    ORG $3000
    TAB3: DC.B 1,1,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,1,1,1,1,1,0,0,1,0,0,1,0,0,1,0,0,0,0,1,1,1,0,0,0,0,0,1,0,1,1,1,1,0,0,0,0,1,1,1,0,0,1,1,0,1,0,0,1,1,1,0,1,1,0,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,1,1,1,0,0,1,1,1,0,1,1,1,0,0,1,1,1,1,1,0,0,1,0,0,1,0,0,0
    TAB3BIS: DC.B 0,1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,0,1,0,0,0,1,0,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,0,1,0,0,1,1,1,0,0,1,0,0,0,0,0,1,0,0,1,1,0,0,1,0,0,1,1,1,1,1,0,0
    TAB3BIS2: DC.B 1,1,1,1,0,0,1,1,0,0,1,1,1,1,0,1,1,0,0,1,1,1,1,1,0,1,0,1,1,0,1,0,0,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,1,1,0,0,1,0,0,1,1,1,1,1,1,0,1,0,1,1,1,1,0,1,1,0,1,0,0,0,1,0,1,0,1,0,1,1,1,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1,0
    TAB3BIS3: DC.B 1,1,0,1,1,1,1,0,0,1,1,1,1,1,0,1,1,1,1,1,0,0,1,0,0,1,1,1,0,1,1,0,0,0,0,1,0,1,1,0,1,1,0,0,1,0,0,0,0,1,1,0,1,1,0,0,1,0,1,1,0,0,1,0,1,1,1,0,0,0,1,1,1,0,0,1,0,1,1,1,1,0,1,0,0,1,0,0,1,1,1,0,0,1,1,0,1,1,1,1,1,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1
    TAB3BIS4: DC.B 1,1,0,0,1,0,1,1,0,0,0,1,0,1,0,0,1,1,0,0,1,0,0,1,0,0,1,1,0,0,1,1,0,1,1,0,0,0,1,1,0,1,1,1,0,0,0,0,1,1,1,0,1,0,1,0,1,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0

    ORG $3300
    TAB4: DC.B 0,1,0,0,1,0,0,0,0,1,0,0,0,1,0,1,0,0,1,1,0,0,1,1,0,0,0,0,1,0,0,1,1,0,1,0,0,1,0,0,0,0,1,1,0,0,1,0,0,0,1,0,1,1,1,1,0,0,1,0,1,0,1,1,0,0,0,1,1,0,0,1,1,1,0,1,0,0,0,0,0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,1,1,0,0,1,1,0,1,0,0,0,1,0,0,0,0,0,1,1,0,1,0,1
    TAB4BIS: DC.B 1,1,0,0,0,1,1,1,0,0,0,0,0,0,1,1,0,1,1,0,0,0,1,0,0,1,0,0,1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,0,0,1,1,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,1,1,0,0,1,0,1,0,1,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,1,0,1,0,0,1,1,0,0,0
    TAB4BIS2: DC.B 0,1,1,1,0,0,0,1,1,0,0,0,1,0,1,0,0,1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,1,0,1,1,1,1,1,0,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,1,0,1,0,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,0,0,1,1,1,0,1,1,0,0,1,0,0,1,0,0
    TAB4BIS3: DC.B 0,1,1,0,1,1,1,1,0,0,0,0,1,0,0,1,1,1,1,0,0,0,1,1,1,0,0,1,0,0,1,0,0,0,1,1,0,1,1,1,1,0,0,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1,0,0,1,0,0,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,1,1,1,1
    TAB4BIS4: DC.B 1,0,1,1,1,0,1,0,0,1,0,0,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,1,0,0,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,1,1,1,0,1


    





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
