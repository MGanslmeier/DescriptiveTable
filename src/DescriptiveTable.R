pacman::p_load(plyr, dplyr, tidyr, openxlsx, haven)

# function that creates the summary statistics table
CreateSummaryStat <- function(df, vars = 'all', unit, time){
  
  # create empty dataframe
  res <- data.frame(stringsAsFactors = F)
  
  # define variables
  if(vars == 'all'){
    vars <- colnames(df) %>% subset(., !. %in% c(unit, time))
  }
  
  # get summary statistics
  for(i in vars){
    
    # get stats
    values <- df %>% pull(get(i))
    nobs <- length(values[!is.na(values)])
    mean <- round(mean(values, na.rm = T), 2)
    med <- round(median(values, na.rm = T), 2)
    sd <- round(sd(values, na.rm = T), 2)
    min <- round(min(values, na.rm = T), 2)
    max <- round(max(values, na.rm = T), 2)
    
    # define number of units
    coverage_df <- df %>% subset(., !is.na(get(i)))
    if(!is.null(unit)){
      unit_num <- coverage_df %>% pull(get(unit)) %>% unique(.) %>% length(.)
    } else {
      unit_num <- 'no units'
    }
    
    # define min and max time
    if(!is.null(time)){
      min_time <- coverage_df %>% pull(get(time)) %>% min(time_temp)
      max_time <- coverage_df %>% pull(get(time)) %>% max(time_temp)
    } else {
      min_time <- 'no time'
      max_time <- 'no time'
    }
    
    # append to results dataframe
    temp <- data.frame(var_short = i, obs = nobs, mean = mean, sd = sd, min = min, max = max,
                       unit_num = unit_num, min_time = min_time, max_time = max_time, stringsAsFactors = F)
    res <- rbind.fill(res, temp)
  }
  
  return(res)
}