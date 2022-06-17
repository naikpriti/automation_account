locals {
  # Load all of the data from json
  all_sch_attach_json_data = jsondecode(file("schedule_attach.json"))

  # Load the runbooks
  schedule_attach_data = local.all_sch_attach_json_data.scheduleAttach

  # define the count
  rb_count_sch_att = length(local.schedule_attach_data)
}

resource "azurerm_automation_job_schedule" "job-schedule-example" {
  count                   = "${local.rb_count_sch_att}"
  resource_group_name     = azurerm_resource_group.rg_automation_account.name
  automation_account_name = azurerm_automation_account.aa_demo.name
  schedule_name           = local.schedule_attach_data[count.index].scheduleName
  runbook_name            = local.schedule_attach_data[count.index].runbookName
  #run_on                  = local.schedule_attach_data[count.index].runsOn
  parameters = {
    aksclustername = local.schedule_attach_data[count.index].parameter1
    resourcegroupname  = local.schedule_attach_data[count.index].parameter2
    operation = local.schedule_attach_data[count.index].parameter3
  }
}
