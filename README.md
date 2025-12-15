# terraform-p6

Une fois que la vm Ubuntu à été créée voici les commandes à lancer (en tant que non root) :

```
sudo useradd -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo -u stack -i

git clone https://opendev.org/openstack/devstack
cd devstack
```

Editez dans le dossier le fichier local.conf 

[[local|localrc]]
ADMIN_PASSWORD=votremotdepasse
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD

Lancez la commande suivante pour installaer enfin la solution :

```
./stack.sh
```

# Installation de terraform en local 

Téléchargez le zip suivant : 

https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_windows_amd64.zip

Mettez le binaire terraform.exe dans le dossier C:/Windows/System32

Au besoin, redémarrez votre client powershell pour voir la commande terraform remonter. 

## Début de projet 

Récupérez le dossier openstack, modifiez le fichier clouds.yaml pour mettre votre propre mot de passe admin et uid de projet. 

Pour trouvcer l'uid de projet rendez-vous sur l'interface d'openstack dans Project > Accès API > Voir les données d'identification

Lancez la commande terraform init et vérifiez que le provider se télécharge bien. 

## Exo1

Créez le réseau montré en cours nommé ipi-demo-display via terraform 

```
terraform init
terraform plan
terraform apply
```

Ajoutez à ce réseau une description en vous basant sur la doc https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2

## Exo 2

Supprimez le network existant 

Créez un fichier nommé project-1.tf, à partir de ce fichier créez un nouveau Identity Project nommé TERRAFORM