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

library(ggplot2)

# Numerical Variables
num_vars <- c("rectal_temp", "pulse", "respiratory_rate", 
              "nasogastric_reflux_ph", "packed_cell_volume", "total_protein", 
              "lesion_1", "lesion_2", "lesion_3")

# Create histograms for numerical variables
histograms <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(x = var)) +
    geom_histogram(fill = "skyblue", color = "black", bins = 20) +
    labs(title = paste("Histogram of", var), x = var, y = "Frequency") +
    theme_minimal()
})

# Create boxplots for numerical variables
boxplots <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(y = var)) +
    geom_boxplot(fill = "lightgreen", color = "black") +
    labs(title = paste("Boxplot of", var), y = var) +
    theme_minimal()
})

# Print histograms and boxplots
print(histograms[[1]])  # Print first histogram
print(boxplots[[1]])     # Print first boxplot

# Measures of Relationship

# Correlation analysis for numerical variables
num_vars <- c("rectal_temp", "pulse", "respiratory_rate", 
              "nasogastric_reflux_ph", "packed_cell_volume", "total_protein", 
              "lesion_1", "lesion_2", "lesion_3")

# Compute correlation matrix
num_correlation <- cor(horse_data[num_vars], use = "complete.obs")

# Print correlation matrix
num_correlation

# Contingency tables for categorical variables
cat_vars <- c("surgery", "age", "temp_of_extremities", "peripheral_pulse", 
              "mucous_membrane", "capillary_refill_time", "pain", 
              "peristalsis", "abdominal_distention", "nasogastric_tube", 
              "nasogastric_reflux", "rectal_exam_feces", "abdomen", 
              "abdomo_appearance", "abdomo_protein", "outcome", 
              "surgical_lesion", "cp_data")

# Compute contingency tables
cat_contingency_tables <- lapply(horse_data[cat_vars], table)

# Print contingency tables
cat_contingency_tables

# ANOVA (Analysis of Variance)

# Example: ANOVA for the 'age' variable (categorical) and the 'pulse' variable (numerical)
anova_result <- aov(pulse ~ age, data = horse_data)

# Print ANOVA table
summary(anova_result)

library(ggplot2)

# Numerical Variables
num_vars <- c("rectal_temp", "pulse", "respiratory_rate", 
              "nasogastric_reflux_ph", "packed_cell_volume", "total_protein", 
              "lesion_1", "lesion_2", "lesion_3")

# Create histograms for numerical variables
num_histograms <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(x = var)) +
    geom_histogram(fill = "skyblue", color = "black", bins = 20) +
    labs(title = paste("Histogram of", var), x = var, y = "Frequency") +
    theme_minimal()
})

# Create density plots for numerical variables
num_density_plots <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(x = var)) +
    geom_density(fill = "skyblue", color = "black") +
    labs(title = paste("Density Plot of", var), x = var, y = "Density") +
    theme_minimal()
})

# Create boxplots for numerical variables
num_boxplots <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(y = var)) +
    geom_boxplot(fill = "lightgreen", color = "black") +
    labs(title = paste("Boxplot of", var), y = var) +
    theme_minimal()
})

# Print numerical univariate plots
print(num_histograms[[1]])  # Print first histogram
print(num_density_plots[[1]])  # Print first density plot
print(num_boxplots[[1]])     # Print first boxplot


# Categorical Variables
cat_vars <- c("surgery", "age", "temp_of_extremities", "peripheral_pulse", 
              "mucous_membrane", "capillary_refill_time", "pain", 
              "peristalsis", "abdominal_distention", "nasogastric_tube", 
              "nasogastric_reflux", "rectal_exam_feces", "abdomen", 
              "abdomo_appearance", "abdomo_protein", "outcome", 
              "surgical_lesion", "cp_data")

# Create barplots for categorical variables
cat_barplots <- lapply(cat_vars, function(var) {
  ggplot(horse_data, aes_string(x = var)) +
    geom_bar(fill = "skyblue", color = "black") +
    labs(title = paste("Barplot of", var), x = var, y = "Count") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
})

# Print categorical univariate plots
print(cat_barplots[[1]])  # Print first barplot

library(ggplot2)

# Scatter plots for numerical variables
scatter_plots <- lapply(num_vars, function(var) {
  ggplot(horse_data, aes_string(x = var)) +
    geom_point(aes_string(y = "pulse", color = "surgery"), alpha = 0.5) +
    labs(title = paste("Scatter Plot of", var, "vs. Pulse"), x = var, y = "Pulse") +
    theme_minimal()
})

# Boxplots for numerical variables by categorical variables
boxplots_by_cat <- lapply(cat_vars, function(cat_var) {
  lapply(num_vars, function(num_var) {
    ggplot(horse_data, aes_string(x = cat_var, y = num_var, fill = cat_var)) +
      geom_boxplot() +
      labs(title = paste("Boxplot of", num_var, "by", cat_var), x = cat_var, y = num_var) +
      theme_minimal()
  })
})

# Print scatter plots
print(scatter_plots[[3]])  # Print first scatter plot

# Print boxplots by categorical variables
print(boxplots_by_cat[[1]][[1]])  # Print first boxplot by the first categorical variable



