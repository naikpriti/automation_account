locals {
  # Load all of the data from json
  all_sch_json_data = jsondecode(file("schedule.json"))

  # Load the runbooks
  schedule_data = [for schedule in local.all_sch_attach_json_data : schedule ]
  # define the count
  #rb_count_sch = length(local.schedule_data)
}

output "schedule_data" {
  value = local.schedule_data      
  }


resource "azurerm_automation_schedule" "example-schedule" {
  #count                   = "${local.rb_count_sch}"
  for_each =  local.all_sch_json_data.schedules
  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.aa_demo.name
  frequency               = each.value.scheduleFrequency
  interval                = each.value.scheduleInterval
  timezone                = each.value.scheduleTZ
  start_time              = each.value.scheduleStartTime
  description             = each.value.scheduleDescription
  week_days               = each.value.scheduleWeekdays
}
