make_fig1 <- function(clean_data) {
  
  fig1_data <- clean_data |>
    filter(!is.na(pid_cat)) |>
    group_by(year, pid_cat) |>
    summarise(n = sum(weight), .groups = "drop") |>
    group_by(year) |>
    mutate(
      share = n / sum(n),
      panel = case_when(
        pid_cat %in% c("strong", "weak")       ~ "A",
        pid_cat %in% c("lean_ind", "pure_ind") ~ "B"
      ),
      pid_cat = factor(pid_cat,
                       levels = c("strong", "weak", "lean_ind", "pure_ind"),
                       labels = c("Strong Identifiers", "Weak Identifiers",
                                  "Independent Leaners", "Pure Independents"))
    ) |>
    ungroup()
  
  election_years <- c(2008, 2012, 2016, 2020, 2024)
  
  bartels_theme <- theme_minimal(base_size = 12) +
    theme(
      panel.border      = element_rect(color = "black", fill = NA, linewidth = 0.5),
      panel.grid.minor  = element_line(linewidth = 0.2),
      panel.grid.major  = element_line(linewidth = 0.3),
      legend.background = element_rect(fill = "white", color = "grey70", linewidth = 0.3),
      plot.title        = element_text(face = "bold")
    )
  
  base_panel <- function(d) {
    ggplot(d, aes(x = year, y = share, linetype = pid_cat, shape = pid_cat)) +
      scale_y_continuous(limits = c(0, 0.5), breaks = seq(0, 0.5, 0.1),
                         minor_breaks = seq(0, 0.5, 0.05), name = NULL) +
      scale_x_continuous(breaks = election_years, minor_breaks = election_years,
                         name = "Year") +
      geom_hline(yintercept = seq(0.1, 0.5, 0.1),
                 linetype = "dotted", linewidth = 0.2, color = "black") +
      geom_vline(xintercept = election_years,
                 linetype = "dotted", linewidth = 0.2, color = "black") +
      geom_line(linewidth = 0.7, color = "black") +
      geom_point(size = 2.2, stroke = 0.9, color = "black", fill = NA) +
      guides(linetype = guide_legend(ncol = 1, title = NULL),
             shape    = guide_legend(ncol = 1, title = NULL)) +
      bartels_theme
  }
  
  panel_a <- base_panel(filter(fig1_data, panel == "A")) +
    scale_linetype_manual(values = c("Strong Identifiers" = "solid",
                                     "Weak Identifiers"   = "dashed")) +
    scale_shape_manual(values = c("Strong Identifiers" = 16,
                                  "Weak Identifiers"   = 1)) +
    labs(title    = "Distribution of Party Identification, 2008-2024",
         subtitle = "Proportions of CES Sample",
         caption  = "Presidential Election Years Only") +
    theme(legend.position = c(0.6, 0.2))
  
  panel_b <- base_panel(filter(fig1_data, panel == "B")) +
    scale_linetype_manual(values = c("Independent Leaners" = "dashed",
                                     "Pure Independents"   = "solid")) +
    scale_shape_manual(values = c("Independent Leaners" = 1,
                                  "Pure Independents"   = 16)) +
    theme(legend.position = c(0.4, 0.8))
  
  (panel_a + theme(axis.title.x = element_blank(), axis.text.x = element_blank(),
                   axis.ticks.x = element_blank(), plot.caption = element_blank())) /
    (panel_b + theme(axis.title.x = element_blank()))
}