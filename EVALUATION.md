# Evaluation 

## Attendu 

Le but de cet évalutation est que vous completiez le code existant pour créer des machines virtuelles. 

## Méthode 

Pour créer une machine virtuelle il vous faut des prérequis :

- Une interface réseau relié au sous-réseau du fichier 05-network
- Un groupe de sécurité 
- Une clé d'authentification à créer ou importer
- Une image (qui existe déjà par défaut sous le nom cirros... )

A partir du repo existant :

Créez 2 machines virtuelles dans le fichier 06-vm.tf

Ces deux machines devront être générés via un count et avoir le nom <votrenom>-1 et <votrenom>-2 . 
Elles doivent faire appel à une clé ssh créé via terraform ou importée (clé donnée dans le fichier 06-vm.tf)
Mettez également deux interfaces réseau dans ce même fichier basée sur le sous-réseau déclaré dans 05-network.tf
Ajoutez la règle de sécurité 1 à vos deux vm. 

## Rendu

Sur MonCampus, donnez moi : 

- Une capture d'écran des VMs
- Le code terraform du fichier 06-vm.tf
