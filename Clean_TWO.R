clean_cces <- function(raw_data) {
  raw_data |>
    select(year, case_id, pid7, voted_turnout_self,
           weight, weight_post, voted_pres_party) |>
    filter(year %in% c(2008, 2012, 2016, 2020, 2024)) |>
    mutate(
      pid_cat = case_when(
        pid7 %in% c(1, 7) ~ "strong",
        pid7 %in% c(2, 6) ~ "weak",
        pid7 %in% c(3, 5) ~ "lean_ind",
        pid7 == 4         ~ "pure_ind"
      ),
      partisan = case_when(
        pid7 %in% c(1, 2, 6, 7) ~ 1,
        pid7 %in% c(3, 4, 5)    ~ 0
      ),
      voter = case_when(
        as_factor(voted_turnout_self) == "Yes" ~ 1,
        as_factor(voted_turnout_self) == "No"  ~ 0
      )
    )
}
