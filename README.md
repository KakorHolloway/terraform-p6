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

## Exo 3 

Dans un nouveau fichier nommé 02-users.tf, créez un nouvel utilisateur du nom que vous voulez dépendant du projet qui à été créé en amont. 

Pour rappel la syntaxe c'est typederessouce.nomterraformdelaressource.attribut

## Exo 4

A la main créez un nouvel projet nommé terraform-import

Via la commande terraform import, importez la ressource dans votre projet terraform. La ressource en question doit-être décrite au préalable dans le fichier 01-project.tf. Attention, ne supprimez pas le block décrivant le projet TERRAFORM. 

Vérifiez l'import en supprimant toutes les ressources via terraform destroy. 

Si votre import à bien fonctionné le projet terraform-import ne devrait plus exister. 

## Exo 5

Créez dans le fichier 03-roleassignment.tf, un role assignment qui va permettre d'attribuer le role déjà existant nommé member à l'utilisateur créé avec le projet créé. 

Afin de pouvoir y arriver créez dans le fichier 04-role.tf un objet data, qui va récupérer les informations du rôle existant member. 

Vérifiez ensuite que tout c'est bien passé. 

Pour rappel, une fois le data créé, on peut y faire appel via la syntaxe data.typeressource.nomressource.attribut

## Exo 6 Création d'une infrastructure 

Créez dans le projet un réseau, celui-ci contiendra un sous-réseau interne en 10.0.0.0/24

Ajoutez un groupe de sécurité et des règles de sécurité associé qui vont permettre d'autoriser en entrée les connexion SSH, HTTP et HTTPS. 

Toutes les ressources vont avoir besoin d'un fin de nom identique (le réseau doit d'appeller monréseau-dev et le sous réseau monsouréseau-dev). Ce nom identique doit être dépendant d'une variable. 

## Comment faire appel à des fichiers de vars 

```
terraform plan --var-file prod/prod.tfvars # choisir les variables qui vous intéresse
```

# Comment déployer en dev :

Modifiez le fichier backend.tf pour pointer vers le dossier de dev :

```tf
terraform {
  backend "local" {
    path = "dev/terraform-dev.tfstate"
  }
}
```

Reconfigurez votre terraform pour appliquer la modification du backend:

```
terraform init -reconfigure
```

Ensuite lancez vos déploiement avec les commandes habituelle en spécifiant vos fichiers de variables :

```
terraform plan --var-file dev/dev.tfvars
terraform apply --var-file dev/dev.tfvars
```

# Comment déployer en prod :

Modifiez le fichier backend.tf pour pointer vers le dossier de prod :

```tf
terraform {
  backend "local" {
    path = "dev/terraform-prod.tfstate"
  }
}
```

Reconfigurez votre terraform pour appliquer la modification du backend:

```
terraform init -reconfigure
```

Ensuite lancez vos déploiement avec les commandes habituelle en spécifiant vos fichiers de variables :

```
terraform plan --var-file prod/prod.tfvars
terraform apply --var-file prod/prod.tfvars
```

## Exercice 7

Supprimez l'environnement actuel. 

Faites en sorte de créer deux environnements sur votre openstack, un de dev et un de prod en reprenant le code décrit dans le dossier Openstack. 

Le but est juste de vérifier que vous arrivez à faire fonctionner le mécanisme de backend. 

De fait, j'attends à ce que seul le fichier backend.tf soit modifié conformément à la procédure décrite au-dessus. 

## Exercice 8

Via le meta-argument count créez plusieurs Security Groups, ces derniers devront s'appeller

1-secgroup-ipi${var.env}
2-sec....
3-....

Vérifiez le bon fonctionnement du mécanisme