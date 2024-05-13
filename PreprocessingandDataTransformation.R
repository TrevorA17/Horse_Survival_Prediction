# Load dataset
horse_data <- read.csv("data/horse.csv", colClasses = c(
  surgery = "factor",
  age = "factor",
  hospital_number = "integer",
  rectal_temp = "numeric",
  pulse = "integer",
  respiratory_rate = "numeric",
  temp_of_extremities = "factor",
  peripheral_pulse = "factor",
  mucous_membrane = "factor",
  capillary_refill_time = "factor",
  pain = "factor",
  peristalsis = "factor",
  abdominal_distention = "factor",
  nasogastric_tube = "factor",
  nasogastric_reflux = "factor",
  nasogastric_reflux_ph = "numeric",
  rectal_exam_feces = "factor",
  abdomen = "factor",
  packed_cell_volume = "numeric",
  total_protein = "numeric",
  abdomo_appearance = "factor",
  abdomo_protein = "factor",
  outcome = "factor",
  surgical_lesion = "factor",
  lesion_1 = "numeric",
  lesion_2 = "numeric",
  lesion_3 = "numeric",
  cp_data = "factor"
))

# Display the structure of the dataset
str(horse_data)

# View the first few rows of the dataset
head(horse_data)

# View the dataset in a separate viewer window
View(horse_data)

# Summarize missing values for each variable
missing_values_summary <- sapply(horse_data, function(x) sum(is.na(x) | is.null(x)))
print("Summary of Missing Values:")
print(missing_values_summary)

# Impute missing values 
# Mean imputation for numerical variables
for (var in num_vars) {
  if (sum(is.na(horse_data[[var]])) > 0) {
    horse_data[[var]][is.na(horse_data[[var]])] <- mean(horse_data[[var]], na.rm = TRUE)
  }
}

# Mode imputation for categorical variables
for (var in cat_vars) {
  if (sum(is.na(horse_data[[var]])) > 0) {
    mode_val <- names(sort(table(horse_data[[var]], useNA = "always"), decreasing = TRUE)[1])
    horse_data[[var]][is.na(horse_data[[var]])] <- mode_val
  }
}

# Verify if missing values are imputed
missing_values_after_imputation <- colSums(is.na(horse_data))
print(missing_values_after_imputation)
