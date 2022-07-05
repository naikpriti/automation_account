locals {
  # Load all of the data from json
  all_json_data = jsondecode(file("${path.module}/runbooks.json"))
  #all_json_data = jsondecode(file("${var.runbooks_file}"))

  # Load the runbooks
  #runbooks_data = local.all_json_data[count.index].runbooks #SAO

  # define the count
  #rb_count = length(local.all_json_data)
}

/*data "local_file" "runbook_scripts" {
  #count                   = "${local.rb_count}"  
  filename                = local.all_json_data.runbooks.runbookScript
}*/

resource "azurerm_automation_runbook" "runbooks" {
  #count                   = "${local.rb_count}"
  name                    = local.all_json_data.runbooks.runbookName 
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.aa_demo.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = local.all_json_data.runbooks.description 
  runbook_type            = local.all_json_data.runbooks.runbookType 
  content                 = local.all_json_data.runbooks.runbookScript
}
