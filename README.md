# Trames et registres

## Trames

Les informations seront transmises via des trames composés en octet.
Chaque octet ou groupe d'octet dans la trame sera assigné, celon la partie, à une information.

Chaque partie devra établir a quoi correspond chaque octet de leur trame.

Le début de chaques trames sera imposé pour tout les groupes :

Octet | Nom  | Description
-----|------|-------------
1|Nb_Octets| Nombre d’octets de la trame
2|ID_Sys| Système dont la commande est sollicité
3|ID_Cmd| Commande sollicité

Registres ID_Sys :

Nom  | Valeur
-----|-------------
STM32 | 0x1
FPGA_Analyse | 0x2
FPGA_Generation| 0x3

Exemple de trame pour le groupe génération :

Octet | Nom  | Description
-----|------|-------------
1|Nb_Octets| Nombre d’octets de la trame
2|ID_Sys| Système dont la commande est sollicité
3|ID_Cmd| Commande sollicité
4|Type_mire| Type de mire
5</br>6| Resolution_X | Résolution sur l'axe X
7</br>8| Resolution_Y | Résolution sur l'axe Y
## Registres

# Intégration

# Test et démo
