*-----------------------------------------------------------
* Title      : Programme principal
* Written by : Simon
* Date       : 01/12/2021
*-----------------------------------------------------------
    ORG $400
 
    *Ne pas avoir de retour clavier 
    MOVE.L  #0,D1
    JSR     KEYBOARD_ECHO
    
    *Taille de la fen�tre du jeu
    MOVE.L  #$050002D0, D1
    JSR     RESOLUTION
    
    *On affiche le premier niveau et les r�gles du jeu
    JSR     NIVEAU_1
    JSR AFFICHER_CHAINE
    
    *On initialise D1, D2, D3, D4 � 0
    EOR.L   D1,D1
    EOR.L   D2,D2
    EOR.L   D3,D3
    EOR.L   D4,D4
    
    *On affiche le curseur
    JSR     CURSEUR_VERT   

*On d�place le curseur vert dans le labyrinthe (pour ce faire on l'efface et le r�affiche quand il s'est d�plac�). De plus, on v�rifie s'il rentre en collision avec un mur, si c'est le cas on l'emp�che d'avancer.
*On v�rifie �galement si le joueur a r�ussi un niveau, et s'il a termin� le jeu
DEPLACEMENT:
    JSR     SAISCAR *Saisir un caract�re (d, q, s, ou z) 
    
DROITE:
    CMP.B   #$64,D1 * Lettre d
    BNE     GAUCHE
    
    JSR     CURSEUR_NOIR
    JSR     ColliDroite
    JSR     ColliSortie *On v�rifie si le joueur a r�ussi le niveau en cours, ou s'il a termin� le jeu

    ADD     #5,X1 
    ADD     #5,X2
    
    JSR     CURSEUR_VERT
    
    JMP     DEPLACEMENT

GAUCHE:
    CMP.B   #$71,D1 * Lettre q
    BNE     HAUT
    
    JSR     CURSEUR_NOIR
    JSR     ColliGauche
    SUB     #5,X1 
    SUB     #5,X2
    
    JSR     CURSEUR_VERT
    
    JMP     DEPLACEMENT

HAUT:
    CMP.B   #$7A,D1 * Lettre z
    BNE     BAS
    
    JSR     CURSEUR_NOIR
    JSR     ColliHaut
    SUB     #5,Y1 
    SUB     #5,Y2
    
    JSR     CURSEUR_VERT
    
    JMP     DEPLACEMENT

BAS:
    CMP.B   #$73,D1 *Lettre s  
    BNE     DEPLACEMENT
    
    JSR     CURSEUR_NOIR
    JSR     ColliBas
    ADD     #5,Y1 
    ADD     #5,Y2
    
    JSR     CURSEUR_VERT
   
    JMP     DEPLACEMENT
    
    
    *"D�claration" des "variables" qui nous serviront pour les coordonn�es du curseur
    X1: DC.W 75 *abscisse haut gauche
    Y1: DC.W 64 *ordonn�e haut gauche
    X2: DC.W 88 *abscisse bas droite
    Y2: DC.W 77 *ordonn�e bas droite
    
    NbNiveau: DC.W 1 *Enregistre � quel niveau est le joueur
    
    INCLUDE 'BIBGRAPH.X68'
    INCLUDE 'BIBPERIPH.X68'
    INCLUDE 'BIBLIO.X68'
    INCLUDE 'Curseur.X68'
    INCLUDE 'Regle.X68'
    INCLUDE 'Collisions.X68'
    INCLUDE 'Niveau/niveau_3.X68'
    INCLUDE 'Niveau/niveau_2.X68'
    INCLUDE 'Niveau/niveau_1.X68'

    END    $400





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
