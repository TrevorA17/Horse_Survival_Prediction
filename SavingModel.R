# Save the glm model
dir.create("./models", showWarnings = FALSE)  # Create the directory if it doesn't exist
saveRDS(model, file = "./models/glm_model.rds")  # Save the model

# Load the saved model
loaded_model <- readRDS("./models/glm_model.rds")

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
  nasogastric_reflux_ph = 0,  # Fill in with appropriate values
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

# Use the loaded model to make predictions
predictions <- predict(loaded_model, newdata = new_data)

# Print predictions
print(predictions)
