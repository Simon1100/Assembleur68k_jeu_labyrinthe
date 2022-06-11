*-----------------------------------------------------------
* Title      : Affichage du curseur
* Written by : Simon
*-----------------------------------------------------------
 
*Permet d'effacer le curseur   
CURSEUR_NOIR: 
    *Initialiser la couleur du curseur (noir)
    MOVE.L  #$00000000, D1   
    JSR     SET_PEN_COLOR
    JSR     SET_FILL_COLOR
    
    *Initialiser les coordonnées du curseur
    MOVE    X1,D1 *abscisse haut gauche 
    MOVE    Y1,D2 *ordonnée haut gauche
    MOVE    X2,D3 *abscisse bas droite 
    MOVE    Y2,D4 *ordonnée bas droite
    
    *Effacer le curseur
    JSR     DRAW_FILL_RECT
    
    RTS
    
*Permet d'afficher la nouvelle position du curseur   
CURSEUR_VERT:
    *Initialiser la couleur du curseur (vert)
    MOVE.L  #$0000FF00, D1   
    JSR     SET_PEN_COLOR
    JSR     SET_FILL_COLOR
    
    *Initialiser les coordonnées du curseur
    MOVE    X1,D1 *abscisse haut gauche 
    MOVE    Y1,D2 *ordonnée haut gauche
    MOVE    X2,D3 *abscisse bas droite 
    MOVE    Y2,D4 *ordonnée bas droite 
    
    *Afficher le curseur
    JSR     DRAW_FILL_RECT 
    
    RTS
    



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
