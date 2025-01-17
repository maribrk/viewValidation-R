# Set working directory
setwd("")

# Read the vw file
vw_OTs <- read.csv2("view.csv", header=TRUE, stringsAsFactors=FALSE, fileEncoding="latin1")
head(vw_OTs)

# Read the sap file
sapdata <- read.csv2("sap.csv", header=TRUE, stringsAsFactors=FALSE, fileEncoding="latin1")
head(sapdata)

# Initialize lists to store file names
viewfiles <- c()
sapfiles <- c()

# Remove duplicates and export a CSV for each column (vw)
for (column in names(vw_OTs)) {
  unique_values <- unique(vw_OTs[[column]])
  df_unique_values <- data.frame(unique_values)
  viewfile_name <- paste0(column, "_unique.csv")
  write.csv(df_unique_values, viewfile_name, row.names = FALSE)
  viewfiles <- c(viewfiles, viewfile_name)
}

# Remove duplicates and export a CSV for each column (sap)
for (column in names(sapdata)) {
  unique_values <- unique(sapdata[[column]])
  df_unique_values <- data.frame(unique_values)
  sapfile_name <- paste0(column, "_unique.csv")
  write.csv(df_unique_values, sapfile_name, row.names = FALSE)
  sapfiles <- c(sapfiles, sapfile_name)
}

column_names <- names(vw_OTs)

# Function to compare columns of two CSV files and return unique values
compare_csv_columns <- function(sapfile, viewfile, column_name) {
  # Read the CSV files
  df1 <- read.csv(sapfile, header=TRUE, stringsAsFactors = FALSE)
  df2 <- read.csv(viewfile, header=TRUE, stringsAsFactors = FALSE)
  
  # Get unique values from the specified column in each file
  unique_values_file1 <- unique(df1[[column_name]])
  unique_values_file2 <- unique(df2[[column_name]])
  
  # Find values that are in sap file but not in view file
  diff_values <- setdiff(unique_values_file1, unique_values_file2)
  
  if (length(diff_values) == 0) {
    cat("No different values found for column:", column_name, "\n")
  } else {
    # Convert the result to a data frame
    diff_df <- data.frame(diff_values)
    
    # Save the result to a new CSV file
    write.csv(diff_df, paste0(column_name, "_diff.csv"), row.names = FALSE)
  }
}

# Compare the columns of both files
for (i in 1:length(column_names)) {
  compare_csv_columns(sapfiles[i], viewfiles[i], column_names[i])
}
