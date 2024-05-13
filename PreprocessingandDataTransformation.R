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