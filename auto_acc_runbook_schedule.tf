locals {
  # Load all of the data from json
  all_sch_json_data = jsondecode(file("schedule.json"))

  # Load the runbooks
  schedule_data = local.all_sch_json_data.schedules

  # define the count
  rb_count_sch = length(local.schedule_data)
}

resource "azurerm_automation_schedule" "example-schedule" {
  count                   = "${local.rb_count_sch}"
  name                    = local.schedule_data[count.index].scheduleName
  resource_group_name     = azurerm_resource_group.rg_automation_account.name
  automation_account_name = azurerm_automation_account.aa_demo.name
  frequency               = local.schedule_data[count.index].scheduleFrequency
  interval                = local.schedule_data[count.index].scheduleInterval
  timezone                = local.schedule_data[count.index].scheduleTZ
  start_time              = local.schedule_data[count.index].scheduleStartTime
  description             = local.schedule_data[count.index].scheduleDescription
  week_days               = local.schedule_data[count.index].scheduleWeekdays
}