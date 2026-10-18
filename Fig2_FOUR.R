make_fig2 <- function(clean_data) {
  
  fig2_data <- clean_data |>
    filter(!is.na(pid_cat), !is.na(voter)) |>
    group_by(year, voter) |>
    summarise(share = weighted.mean(partisan, weight), .groups = "drop") |>
    mutate(group = if_else(voter == 1, "Voters", "Nonvoters"))
  
  election_years <- c(2008, 2012, 2016, 2020, 2024)
  
  ggplot(fig2_data, aes(x = year, y = share, linetype = group, shape = group)) +
    geom_hline(yintercept = seq(0.1, 1.0, 0.1),
               linetype = "dotted", linewidth = 0.2, color = "black") +
    geom_vline(xintercept = election_years,
               linetype = "dotted", linewidth = 0.2, color = "black") +
    geom_line(linewidth = 0.7, color = "black") +
    geom_point(size = 2.2, stroke = 0.9, color = "black", fill = NA) +
    scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.1),
                       minor_breaks = seq(0, 1, 0.05), name = NULL) +
    scale_x_continuous(breaks = election_years, minor_breaks = election_years,
                       name = "Year") +
    scale_linetype_manual(values = c("Nonvoters" = "dashed", "Voters" = "solid")) +
    scale_shape_manual(values = c("Nonvoters" = 1, "Voters" = 16)) +
    guides(linetype = guide_legend(ncol = 1, title = NULL),
           shape    = guide_legend(ncol = 1, title = NULL)) +
    labs(title    = "Party Identification Among Presidential Voters and Nonvoters",
         subtitle = "Proportions of Strong or Weak Identifiers in CES Sample",
         caption  = "Presidential Election Years Only, Weighted") +
    theme_minimal(base_size = 12) +
    theme(
      panel.border      = element_rect(color = "black", fill = NA, linewidth = 0.5),
      panel.grid.minor  = element_line(linewidth = 0.2),
      panel.grid.major  = element_line(linewidth = 0.3),
      legend.position   = c(0.2, 0.2),
      legend.background = element_rect(fill = "white", color = "grey70", linewidth = 0.3),
      plot.title        = element_text(face = "bold")
    )
}