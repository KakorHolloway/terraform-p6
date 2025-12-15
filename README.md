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
