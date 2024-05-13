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

# Measures of Frequency
# Frequency table for categorical variables
cat_vars <- c("surgery", "age", "temp_of_extremities", "peripheral_pulse", 
              "mucous_membrane", "capillary_refill_time", "pain", 
              "peristalsis", "abdominal_distention", "nasogastric_tube", 
              "nasogastric_reflux", "rectal_exam_feces", "abdomen", 
              "abdomo_appearance", "abdomo_protein", "outcome", 
              "surgical_lesion", "cp_data")

cat_freq <- lapply(horse_data[cat_vars], table)
cat_freq_summary <- lapply(cat_freq, summary)

# Frequency table for numerical variables
num_vars <- c("rectal_temp", "pulse", "respiratory_rate", 
              "nasogastric_reflux_ph", "packed_cell_volume", "total_protein", 
              "lesion_1", "lesion_2", "lesion_3")

num_freq_summary <- lapply(horse_data[num_vars], summary)

# Print frequency tables
cat_freq_summary
num_freq_summary

# Measures of Central Tendency for Numerical Variables
num_vars <- c("rectal_temp", "pulse", "respiratory_rate", 
              "nasogastric_reflux_ph", "packed_cell_volume", "total_protein", 
              "lesion_1", "lesion_2", "lesion_3")

# Mean
num_means <- sapply(horse_data[num_vars], mean, na.rm = TRUE)

# Median
num_medians <- sapply(horse_data[num_vars], median, na.rm = TRUE)

# Mode (custom function)
get_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}
num_modes <- sapply(horse_data[num_vars], get_mode)

# Print measures of central tendency for numerical variables
num_central_tendency <- data.frame(mean = num_means, median = num_medians, mode = num_modes)
num_central_tendency

