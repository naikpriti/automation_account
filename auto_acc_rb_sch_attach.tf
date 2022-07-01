locals {
  # Load all of the data from json
  all_sch_attach_json_data = jsondecode(file("schedule_attach.json"))

  # Load the runbooks
  #schedule_attach_data = local.all_sch_attach_json_data.scheduleAttach1
  #runbooks_data = local.all_json_data[count.index].runbooks

  # define the count
  #rb_count_sch_att = length(local.all_sch_attach_json_data)
}

resource "azurerm_automation_job_schedule" "job-schedule-example" {
  #count                   = "${local.rb_count_sch_att}"
  resource_group_name     = var.resource_group_name
  for_each =  local.all_sch_attach_json_data.scheduleAttach
  automation_account_name = azurerm_automation_account.aa_demo.name
  schedule_name           = each.value.scheduleName
  runbook_name            = each.value.runbookName
  #run_on                  = local.schedule_attach_data[count.index].runsOn
  parameters = {
    aksclustername = "${each.value.parameter1}"
    resourcegroupname  = "${each.value.parameter2}"
    operation = "${each.value.parameter3}"
  }
}