locals {
  # Load all of the data from json
  all_json_data = jsondecode(file("runbooks.json"))
  #all_json_data = jsondecode(file("${var.runbooks_file}"))

  # Load the runbooks
  #runbooks_data = local.all_json_data[count.index].runbooks #SAO

  # define the count
  rb_count = length(local.all_json_data)
}

data "local_file" "runbook_scripts" {
  count                   = "${local.rb_count}"  
  filename                = local.all_json_data[count.index].runbooks.runbookScript
}

resource "azurerm_automation_runbook" "runbooks" {
  count                   = "${local.rb_count}"
  name                    = local.all_json_data[count.index].runbooks.runbookName 
  location                = azurerm_resource_group.rg_automation_account.location
  resource_group_name     = azurerm_resource_group.rg_automation_account.name
  automation_account_name = azurerm_automation_account.aa_demo.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = local.all_json_data[count.index].runbooks.description 
  runbook_type            = local.all_json_data[count.index].runbooks.runbookType 
  content                 = data.local_file.runbook_scripts[count.index].content
}