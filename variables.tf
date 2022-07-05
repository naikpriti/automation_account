variable "clustername" {
    type = string
    description = "AKS cluster name "
}

variable "location" {
    type = string
    description = "Azure region where the resources would be provisioned"
}

variable "resource_group_name"{
    type = string
    description = "resource group name "

}

variable "name" {
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
variable "runbook_file" {
    type = string
    description = "Azure region where the resources would be provisioned"
    default = "runbooks.json"
}
variable "subscription_id" {
    type = string
    description = "Azure region where the resources would be provisioned"
}

variable "timezone"{
    type = any
    description = "resource group name "

}

variable "starttime"{
    type = string
    description = "resource group name "

}

variable "stoptime"{
    type = string
    description = "resource group name "

}
