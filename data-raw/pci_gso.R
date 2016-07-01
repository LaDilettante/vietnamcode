library(haven)
library(plyr)
library(dplyr)

d_census <- read_dta("data/province_codes.dta")
d_census <- d_census %>% arrange(province) %>%
  select(province_name = province,
         enterprise_census = tinh_no,
         enterprise_census_old = census_old) %>%
  mutate(province_name = ifelse(enterprise_census %in% c(97, 98, 99),
                                NA, province_name)) %>%
  mutate(province_name = ifelse(enterprise_census == 44,
                                "Quang Binh", province_name)) %>%
  mutate(province_name = revalue(province_name,
                                 c("Bac Can" = "Bac Kan",
                                   "Hanoi" = "Ha Noi", "HCMC" = "TP HCM",
                                   "TT-Hue" = "Thua Thien Hue")))

d_pci <- read_dta("data-raw/PCI2011.dta") %>%
  select(pci = pci_id)
d_pci = data.frame(pci = attr(d_pci$pci, "labels")) %>%
  mutate(province_name = row.names(.)) %>%
  mutate(province_name = revalue(province_name,
                                 c("HCMC" = "TP HCM",
                                   "TT-Hue" = "Thua Thien Hue"))) %>%
  rbind(c(42, "Ha Tay")) # According to PCI2005

d_name <- read.csv("data-raw/regex.csv", stringsAsFactors = FALSE)

vietnamcode_data <- full_join(d_census, d_name, by = "province_name") %>%
  full_join(d_pci, by = "province_name") %>%
  mutate(enterprise_census_c = formatC(enterprise_census,
                                       width = 2, format = "d", flag = "0"))

write.csv(vietnamcode_data, file = "data/vietnamcode_data.csv",
          row.names = FALSE)
devtools::use_data(vietnamcode_data, overwrite = TRUE)
