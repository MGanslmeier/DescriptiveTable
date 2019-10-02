# Descriptive Table Generator: a quick way to create a summary statistics table for your paper

Publishers often request basic summary statistics of your dataset. The function provides a quick way to produce this table. 

	source('src/DescriptiveTable.R')
    sum_stats <- CreateSummaryStat(df, vars = 'all', unit = 'country', time = 'year')

Usually, journals also ask you for data source information. The following lines combine the summary statistics table and the source information in one Excel sheet.

	desc_table <- data.frame(var_short = sum_stats$var_short, stringsAsFactors = F) %>% mutate(var_long = "", description = "", source = "", domain = "")
    df_list <- list("Descriptive Table" = desc_table, "Summary Statistics Table" = sum_stats)
  write.xlsx(df_list, file = "data/desc_sum_tables.xlsx")