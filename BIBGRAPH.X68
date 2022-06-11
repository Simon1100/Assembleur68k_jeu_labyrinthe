*-----------------------------------------------------------
* Title      : BIBGRAPH.X68
*-----------------------------------------------------------

* Initialise la couleur du crayon
SET_PEN_COLOR: 
    MOVE    #80, D0
    TRAP    #15
    RTS
 
* Initialise la couleur du remplissage
SET_FILL_COLOR: 
    MOVE    #81, D0
    TRAP    #15
    RTS

* Dessine un pixel
DRAW_PIX:
    MOVE    #82, D0
    TRAP    #15
    RTS

* Rècupère dans D0.L la couleur du pixel 
GET_PIX_COLOR: 
    MOVE    #83, D0
    TRAP    #15
    RTS

*Dessine une ligne avec la couleur du crayon de X,Y à X2,Y2
DRAW_LINE:
    MOVE    #84, D0
    TRAP    #15
    RTS

*Dessine une ligne avec la couleur du crayon de la position actuelle à X,Y
DRAW_TO:
    MOVE    #85, D0
    TRAP    #15
    RTS

*Dessine un rectangle plein avec couleur du crayon pour le contour et couleur de remplissage
DRAW_FILL_RECT: 
    MOVE    #87, D0
    TRAP    #15
    RTS

*Dessine une ellipse pleine avec couleur du crayon pour le contour et couleur de remplissage
DRAW_FILL_ELLIPSE: 
    MOVE    #88, D0
    TRAP    #15
    RTS

*Définir la largeur du crayon en pixel  
WIDTH_PEN:
    MOVE    #93, D0
    TRAP    #15
    RTS
 
*Définit le mode de dessin en fonction de la valeur de D1.B
DRAW_MODE: 
    MOVE    #92, D0
    TRAP    #15
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
