variable "clustername" {
    type = string
    description = "AKS cluster name "
}

variable "location" {
    type = string
    description = "Azure region where the resources would be provisioned"
}

/*variable "db_username" {
    type = string
    description = "username for the MySQL database"
}

variable "db_password" {
    type = string
    description = "password for the MySQL database"
}

variable "port" {
    type = string
    description = "port number for the MySQL database"
}
*/
variable "runbooks_file" {
    type = string
    
}
