variable "user_name" {
    description = "Nom de l'utilisateur ipi"
    type = string
    default = "ipi-user"
}

variable "env" {
    description = "Valeur d'environnement"
    type = string
}

variable "demo_condition" {
    type= string
    default = "test"
    description = "permet de tester une condition"
}