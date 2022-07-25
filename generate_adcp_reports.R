# This script can generate ADCP reports for all deployments.

library(dplyr)
library(here)
library(readxl)


# SECTION 1: Specify deployments -----------------------------------------------

report <- here("ADCP_Report.Rmd")

tracker <- read_xlsx("Z:/Coastal Monitoring Program/ADCP/Side Lobe Trimmed/Reports/ADCP_Report_Tracker.xlsx")
# tracker <- read_xlsx("Y:/Coastal Monitoring Program/ADCP/Side Lobe Trimmed/Reports/ADCP_Report_Tracker.xlsx")
tracker <- tracker %>%
  slice(grep("No", `2022 Report (sidelobe trimmed)`, invert = TRUE))

depl_date <- tracker$Depl_Date[]
station <- tracker$Open_Data_Station[]
county <- tracker$County[]


# SECTION 2: Generate Reports --------------------------------------------------

mapply(function(x, y, z) {

  rmarkdown::render(
    input = report,
    output_file = paste0(
      x, "_", y, "_ADCP Report.docx"
    ),
    params = list(depl_date = x, station = y, county = z),
  )

}, depl_date, station, county)


