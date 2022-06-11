*-----------------------------------------------------------
* Title      : Collisions
* Written by : Simon
* Description: Gérer les collisions entre le curseur et les murs du labyrinthe
*-----------------------------------------------------------

*Nous vérifions la présence de pixel blanc (mur), dans une zone de 5 pixels devant la direction du curseur.

ColliDroite: *(Vérification de collision avec un mur quand il y a un déplacement vers la droite)
    *On récupère les coordonnées du curseur (haut gauche) 
    MOVE.W  X1,D1 
    MOVE.W  Y1,D2
 
    EOR.L   D7,D7 *Nous mettons la valeur de D7 à zéro. D7 permet de vérifier la présence de pixel blanc à 5 niveaux de distance de la direction du curseur.
    
    SUB.W   #1,D2 *Nous allons vérifier grâce à D2 si à chaque niveau de hauteur du curseur on touche un pixel blanc (mur) (on soustrait ici 1 puisque l'on ajoute 1 au début du label SI2)
    ADD.W   #13,D1 *Nous nous plaçons ici à l'extrémité droite du curseur

*Boucle SI1 permettant de vérifier la présence de pixel blanc à 5 niveaux de distance du curseur.
SI1: 
    ADD.W   #1,D1 
    ADD.L   #1,D7
    MOVE.L  #14,D5 *On vérifie sur toute la longueur du curseur s'il peut y avoir une collision avec un mur    
SI2:
    ADD.W   #1,D2
    ADD.L   #-1,D5
    CMP.L   #0,D5
    BEQ     FINSI2 *Si toute la longueur du curseur a été vérifié on termine la boucle
    
    JSR     GET_PIX_COLOR
    CMP     #0, D0
    BEQ     SI2  *Si on remarque la présence d'un pixel blanc dans la zone à vérifier, on colle le curseur au mur qui est censé rentrer en collision à la prochaine avancé de celui-ci et on retourne au programme principal
    SUB.W   #6,X1
    SUB.W   #6,X2
    ADD.W   D7,X1
    ADD.W   D7,X2
    BRA     FINSI1

FINSI2:
    ADD.W   #-14,D2 *On rénitialise D2 afin de réitérer la vérification de la présence de pixel blanc devant cette zone qui vient d'être vérifié
    CMP.L   #5, D7
    BNE     SI1
    
FINSI1:
    RTS
    
    
ColliGauche: *(Vérification de collision avec un mur quand il y a un déplacement vers la gauche)
    *On récupère les coordonnées du curseur (haut gauche)
    MOVE    X1,D1
    MOVE    Y1,D2

    EOR.L   D7,D7 *Nous mettons la valeur de D7 à zéro. D7 permet de vérifier la présence de pixel blanc à 5 niveaux de distance de la direction du curseur.
    
    SUB  #1,D2 *Nous allons vérifier grâce à D2 si à chaque niveau de hauteur du curseur on touche un pixel blanc (mur) (on soustrait ici 1 puisque l'on ajoute 1 au début du label SI4)

*Boucle SI3 permettant de vérifier la présence de pixel blanc à 5 niveaux de distance du curseur.
SI3:
    ADD     #-1,D1
    ADD     #1,D7
        
    MOVE.L  #14,D5 *On vérifie sur toute la longueur du curseur s'il peut y avoir une collision avec un mur
    
SI4:
    ADD.L   #1,D2
    ADD.W   #-1,D5
    CMP.W   #0,D5
    BEQ     FINSI4 *Si toute la longueur du curseur a été vérifié on termine la boucle
    
    JSR     GET_PIX_COLOR
    CMP     #0, D0
    BEQ     SI4 *Si on remarque la présence d'un pixel blanc dans la zone à vérifier, on colle le curseur au mur qui est censé rentrer en collision à la prochaine avancé de celui-ci et on retourne au programme principal
    ADD     #6,X1 
    ADD     #6,X2
    SUB.W   D7,X1
    SUB.W   D7,X2
    BRA     FINSI3

    
FINSI4:
    ADD     #-14,D2 *On rénitialise D2 afin de réitérer la vérification de la présence de pixel blanc devant cette zone qui vient d'être vérifié
    CMP     #5, D7
    BNE     SI3
    
FINSI3:
    RTS
 
 
    
ColliBas: *(Vérification de collision avec un mur quand il y a un déplacement vers le bas)
    *On récupère les coordonnées du curseur (haut gauche)
    MOVE    X1,D1 
    MOVE    Y1,D2
    
    EOR.L   D7,D7 *Nous mettons la valeur de D7 à zéro. D7 permet de vérifier la présence de pixel blanc à 5 niveaux de distance de la direction du curseur.

    ADD     #13,D2 *Nous nous plaçons ici à l'extrémité basse du curseur
    
SI5:

    ADD     #1,D2
    ADD     #1,D7
    
    MOVE.L  #14,D5 *On vérifie sur toute la largeur du curseur s'il peut y avoir une collision avec un mur
    
SI6:
    ADD.L   #1,D1
    ADD.W   #-1,D5
    CMP.W   #0,D5
    BEQ     FINSI6 *Si toute la largeur du curseur a été vérifié on termine la boucle
    
    JSR     GET_PIX_COLOR
    CMP     #0, D0
    BEQ     SI6 *Si on remarque la présence d'un pixel blanc dans la zone à vérifier, on colle le curseur au mur qui est censé rentrer en collision à la prochaine avancé de celui-ci et on retourne au programme principal
    ADD     #-6,Y1 
    ADD     #-6,Y2
    ADD.W   D7,Y1
    ADD.W   D7,Y2
    BRA     FINSI5
    
FINSI6:
    ADD     #-14,D1 *On rénitialise D1 afin de réitérer la vérification de la présence de pixel blanc devant cette zone qui vient d'être vérifié
    CMP     #5, D7
    BNE     SI5
FINSI5:
    RTS
    
    
   
ColliHaut: *(Vérification de collision avec un mur quand il y a un déplacement vers le haut)

    *On récupère les coordonnées du curseur (haut gauche)
    MOVE    X1,D1
    MOVE    Y1,D2
    
    EOR.L   D7,D7 *Nous mettons la valeur de D7 à zéro. D7 permet de vérifier la présence de pixel blanc à 5 niveaux de distance de la direction du curseur.

SI7:
    ADD     #-1,D2
    ADD     #1,D7
    MOVE.L  #14,D5 *On vérifie sur toute la largeur du curseur s'il peut y avoir une collision avec un mur

    
SI8:
    ADD.L   #1,D1
    ADD.W   #-1,D5
    CMP.W   #0,D5
    BEQ     FINSI8
    
    JSR     GET_PIX_COLOR
    CMP     #0, D0
    BEQ     SI8  *Si on remarque la présence d'un pixel blanc dans la zone à vérifier, on colle le curseur au mur qui est censé rentrer en collision à la prochaine avancé de celui-ci et on retourne au programme principal
    ADD     #6,Y1 
    ADD     #6,Y2
    SUB.W   D7,Y1
    SUB.W   D7,Y2
    BRA     FINSI7
    
FINSI8: *On rénitialise D1 afin de réitérer la vérification de la présence de pixel blanc devant cette zone qui vient d'être vérifié
    ADD     #-14,D1
    CMP     #5, D7
    BNE     SI7
FINSI7:
    RTS   




ColliSortie: *(Vérification de collision avec une sortie quand il y a un déplacement vers la droite)

*Même algorithme qu'à la suite du label ColliDroite, nous commenterons ici les changements notable

    MOVE.W  X1,D1 
    MOVE.W  Y1,D2
 
    EOR.L   D7,D7

    SUB.W   #1,D2
    ADD.W   #13,D1
    
SI9:
    ADD.W   #1,D1
    ADD.L   #1,D7
    MOVE.L  #14,D5
    
SI10:
    ADD.W   #1,D2
    ADD.L   #-1,D5
    CMP.L   #0,D5
    BEQ     FINSI10
    
    JSR     GET_PIX_COLOR
    CMP.L     #$F20000,D0 *On vérifie s'il y a la présence du bleu (qui correspond à la sortie)
    BNE    SI10 *Si c'est le cas :
    
        CMP #1,NbNiveau
        BNE Victoire2
    
        *Si on est au niveau 1
        ADD #1,NbNiveau 
        
        *On place la position du curseur au départ du niveau 2
        MOVE #75,X1 
        MOVE #335,Y1
        MOVE #88,X2
        MOVE #348,Y2
       
        *On affiche le niveau 2
        JSR     NIVEAU_2
        RTS

    Victoire2:

        CMP #2,NbNiveau
        BNE Victoire3
    
        *Si on est au niveau 2
        ADD #1,NbNiveau
        
        *On place la position du curseur au départ du niveau 3
        MOVE #75,X1
        MOVE #660,Y1
        MOVE #88,X2
        MOVE #673,Y2

        *On affiche le niveau 3
        JSR     NIVEAU_3
        RTS
    
    Victoire3:
    
        *Si on est au niveau 3 et que l'on rencontre la sortie cela signifie que l'on a terminé le jeu !

        *On affiche donc le fond du jeu en noir (On efface le niveau actuel)
        MOVE.L  #$00000000, D1
        JSR     SET_FILL_COLOR
        MOVE.L #0,D1
        MOVE.L #0,D2
        MOVE.L #1280,D3
        MOVE.L #720,D4
        JSR DRAW_FILL_RECT
        
        *On affiche le message qui indique la victoire
        VICTOIRE:
            MOVE.L  #MSG_VICTOIRE, A0 
        AFFICHER:
            MOVE.B  (A0)+, D1
            JSR     AFFCAR 
            CMP.B   #0, D1
            BNE     AFFICHER
            
            JSR FINPRG

    BRA     FINSI9

FINSI10:
    ADD.W   #-14,D2
    CMP.L   #5, D7
    BNE     SI9
    
FINSI9:  
    RTS
    
    

MSG_VICTOIRE: DC.L 'VICTOIRE ! ',0


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
