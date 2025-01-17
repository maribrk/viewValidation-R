# viewValidation with R Studio

First, the CSV files from both sources were read using the read.csv2 function. Then, duplicate values ​​were removed from each column in both files, exporting the unique values ​​to new CSV files.

For each column, the unique values ​​were compared and then the setdiff function was used to identify the values ​​that were present in the SAP files but not in the View files. These records were exported to new CSV files with the suffix _diff.csv. If the records were 100% in the View, a message was displayed in the console indicating that no different values ​​were found.
