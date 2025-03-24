library(randomForest)

# Train Random Forest model
rf_model <- randomForest(outcome ~ ., data = horse_data)

# Create directory if it doesn't exist
dir.create("./models", showWarnings = FALSE)

# Save the RF model
saveRDS(rf_model, file = "./models/rf_model.rds")

# Load the saved RF model
loaded_rf_model <- readRDS("./models/rf_model.rds")

# Prepare new data for prediction
new_data <- data.frame(
  surgery = "no",
  age = "adult",
  hospital_number = 12345,
  rectal_temp = 38.5,
  pulse = 66,
  respiratory_rate = 28,
  temp_of_extremities = "cool",
  peripheral_pulse = "reduced",
  mucous_membrane = "pale_pink",
  capillary_refill_time = "less_3_sec",
  pain = "mild_pain",
  peristalsis = "absent",
  abdominal_distention = "none",
  nasogastric_tube = "none",
  nasogastric_reflux = "none",
  nasogastric_reflux_ph = 0,  # Ensure correct value
  rectal_exam_feces = "normal",
  abdomen = "distend_large",
  packed_cell_volume = 45,
  total_protein = 8.4,
  abdomo_appearance = "cloudy",
  abdomo_protein = "2",
  surgical_lesion = "yes",
  lesion_1 = 11300,
  lesion_2 = 0,
  lesion_3 = 0,
  cp_data = "no"
)

# Ensure categorical variables in new data match training data
for (col in names(new_data)) {
  if (col %in% names(horse_data)) {
    if (is.factor(horse_data[[col]])) {
      # Convert to factor and match levels with training data
      new_data[[col]] <- factor(new_data[[col]], levels = levels(horse_data[[col]]))
    } else if (is.numeric(horse_data[[col]])) {
      # Convert to numeric if needed
      new_data[[col]] <- as.numeric(as.character(new_data[[col]]))
    }
  }
}

# Make predictions again
predictions <- predict(loaded_rf_model, newdata = new_data)

# Print predictions
print(predictions)

