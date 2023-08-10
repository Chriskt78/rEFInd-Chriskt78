# rEFInd-Chriskt78
Paquet pour installer un multiboot Windows-RetrogamingOS (rEFInd)\
Thème basé sur https://github.com/PillTime/rEFInd-minimal-dark \
Packagé & customisé par Christ78

1) Vérifier si votre Windows est en mode UEFI ou BIOS :
- Touches Win+R
- Tapez ``msinfo32`` puis appuyez sur Entrée
- sur la droite de l'écran Informations Système, recherchez le mode BIOS
- si sa valeur est UEFI, passez à la section Configurez UEFI (3)
- si sa valeur est BIOS, vous devez convertir votre disque Windows de MBR à GPT (2)

2) Comment convertir votre disque de MBR à GPT :
- Localisez le numéro du disque :
	- Cliquez avec le bouton droit de la souris sur le bouton Windows
	- Choisissez le Gestionnaire de disques
	- Recherchez votre disque dur contenant Windows (C:) et notez le numéro du disque (noté plus tard ``<disknumber>`` qu'il faudra remplacer par la valeur notée ici).
- Convertir le disque MBR en GPT :
	- Cliquez sur le bouton Windows
	- Tapez ``cmd`` puis Entrée
	- Cliquez avec le bouton droit de la souris, exécutez en tant qu'administrateur
	- tapez ``mbr2gpt /validate /disk:<disknumber> /allowFullOS`` puis Entrée
	- si aucune erreur ne survient, tapez ``mbr2gpt /convert /disk:<disknumber> /allowFullOS`` puis Entrée

3) Configurez l'UEFI : 
- Assurez-vous que le mode BIOS est réglé sur UEFI
- Désactiver Secure Boot
- Désactiver Compatibility Support Module (CSM)

4) Installer rEFInd-Chriskt78 :
- Décompresser, aller dans le dossier décompressé
- Pour installer, faites un clic droit sur install.bat, exécutez en tant qu'administrateur
- Vérifiez si vous n'avez pas de messages d'erreurs, et que les copies de fichiers ne donnent pas 0 fichier copié
- Redémarrez et vérifiez que rEFIind démarre et démarre sur votre distribution retrogaming, Windows ou tout autre système. Vous pouvez utiliser les flèches gauche/droite/entrée, la souris et l'écran tactile pour faire votre choix (mais pas le touchpad).

5) Pour désinstaller rEFInd-Chriskt78 :
- Décompressez, allez dans le dossier décompressé.
- Faites un clic droit sur uninstall.bat, exécutez en tant qu'administrateur.
- Vérifiez que vous n'avez pas de messages d'erreur
- Vérifiez que vous démarrez sur Windows directement. 
