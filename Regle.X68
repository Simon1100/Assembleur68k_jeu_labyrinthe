*-----------------------------------------------------------
* Title      : Règle du jeu à afficher
* Written by : Simon
*-----------------------------------------------------------

AFFICHER_CHAINE:
    MOVE.L  #REGLE_DU_JEU, A4
AFFICHER_CHAINE2:
    MOVE.B  (A4)+, D1
    JSR     AFFCAR 
    CMP.B   #0, D1
    BNE     AFFICHER_CHAINE2 
    
    RTS

    REGLE_DU_JEU: DC.L 'Appuyez sur les touches z, q, s, d pour se déplacer',0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
