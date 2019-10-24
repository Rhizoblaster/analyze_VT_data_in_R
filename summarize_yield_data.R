

Yield_Data_df

Yield_Data_df <- Yield_Data_df%>%
  tidyr::unite("Join_Row", c("Farm_Name", "Plot_Number"),sep = "_" )

p1_main_effect <- ggplot(data = Yield_Data_df, aes(x = Variety_Name, y = Yield_lbs_A, color = Nearest_Town))

p1_main_effect + geom_boxplot()+
  geom_point()


## make summary table

Yield_Summary <- Yield_Data_df%>%
  group_by(Nearest_Town, Variety_Name)%>%
  summarise(mean_yield = mean(Yield_lbs_A))%>%
  print()

## ANOVA

mod_1 <- aov(Yield_lbs_A ~ Variety_Name, data = Yield_Data_df)

mod_1

summary(mod_1)

Find_LSD <- LSD.test(mod_1, "Variety_Name")

print(Find_LSD)

wide_format_yield_df <- Yield_Data_df%>%
  select(-Yield_lbs_plot)%>%
  spread(Nearest_Town, Yield_lbs_A)

mean_df <- apply(wide_format_yield_df, sum)

head(wide_format_yield_df)




## the extremely ugly way to do this

## temp df

Temp_df <- data.frame(cbind(data.frame(c(unique(Yield_Data_df$Variety_Name))), c("Mean", "CV", "LSD")))
print(Temp_df)

List_Nearest_Town <- c(unique(Yield_Data_df$Nearest_Town))

print(List_Nearest_Town)

for (i in List_Nearest_Town){
  print(i)
  
  ## filter DF
  filter_df <- Yield_Data_df%>%
    filter(Nearest_Town == i)
  
  mod <- aov(Yield_lbs_A ~ Variety_Name, data = filter_df)
  Calculate_Stats_df <- LSD.test(mod, "Variety_Name")
  
  groups <- Calculate_Stats_df$groups
  groups_df <- as_data_frame(groups, rownames = "col_1")
  
  #print(groups_df)
  
  statistics_df <- data.frame(Calculate_Stats_df$statistics)
  statistics_df <- statistics_df%>%
    gather(col_1, Yield_lbs_A, MSerror:LSD)%>%
    filter(col_1 == "Mean"|col_1 == "LSD"|col_1 == "CV")%>%
    mutate(groups = "")
  
  #print(statistics_df)
  
  x <- paste(i)
  print(x)

  stats <- rbind(groups_df, statistics_df)%>%
    rename( Almira = Yield_lbs_A)%>%
    mutate(Almira = round(Almira, 0))
  print(stats)
  
  Finished_df <- Temp_df%>%
    full_join(stats, by = "col_1")
}

