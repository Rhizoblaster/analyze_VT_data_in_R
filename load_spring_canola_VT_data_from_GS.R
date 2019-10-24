

## load data from google sheet

(my_sheets <- gs_ls())

#my_sheets %>% glimpse()
#my_sheets$sheet_title

WOCS_2019_SVT <- gs_title("WOCS_spring_variety_trials_2019")
gs_ws_ls(WOCS_2019_SVT)

## load data key

Data_Key <- WOCS_2019_SVT %>%
  gs_read(ws = "Data_Key")

Data_Key_df <- data.frame(Data_Key)

head(Data_Key_df)

## loat plant count data

Plant_Counts <- WOCS_2019_SVT %>%
  gs_read(ws = "Plant_Counts")

Plant_Counts_df <- data.frame(Plant_Counts)

head(Plant_Counts)

## load yield data

Yield_Data <- WOCS_2019_SVT %>%
  gs_read(ws = "Yield_data")

Yield_Data_df <- data.frame(Yield_Data)

head(Yield_Data_df)

## load pod counts

Pod_Counts <- WOCS_2019_SVT %>%
  gs_read(ws = "Pod_counts")

Pod_Counts_df <- data.frame(Pod_Counts)

head(Pod_Counts_df)
