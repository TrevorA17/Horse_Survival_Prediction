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

library(caret)

# Set the seed for reproducibility
set.seed(123)

# Define the percentage of data to be used for training (e.g., 80%)
train_percentage <- 0.8

# Split the dataset into training and testing sets
train_index <- createDataPartition(horse_data$outcome, p = train_percentage, list = FALSE)
train_data <- horse_data[train_index, ]
test_data <- horse_data[-train_index, ]

# Print the dimensions of the training and testing sets
cat("Training set dimensions:", dim(train_data), "\n")
cat("Testing set dimensions:", dim(test_data), "\n")

# Set the seed for reproducibility
set.seed(123)

# Define the number of bootstrap samples
num_bootstrap_samples <- 1000

# Initialize an empty vector to store bootstrap statistics
bootstrap_statistics <- numeric(num_bootstrap_samples)

# Perform bootstrapping
for (i in 1:num_bootstrap_samples) {
  # Generate a bootstrap sample by sampling with replacement
  bootstrap_sample <- horse_data[sample(nrow(horse_data), replace = TRUE), ]
  
  # Compute the statistic of interest on the bootstrap sample
  # For example, you can compute the mean of a numerical variable
  bootstrap_statistics[i] <- mean(bootstrap_sample$rectal_temp, na.rm = TRUE)
}

# Compute and print the bootstrap estimate (e.g., mean) and its standard error
bootstrap_estimate <- mean(bootstrap_statistics)
bootstrap_standard_error <- sd(bootstrap_statistics)
cat("Bootstrap Estimate:", bootstrap_estimate, "\n")
cat("Bootstrap Standard Error:", bootstrap_standard_error, "\n")

# Remove rows with missing values
horse_data <- na.omit(horse_data)

# Train a logistic regression model for classification
model <- glm(outcome ~ ., data = horse_data, family = binomial)

# Print the summary of the model
summary(model)

# Ensure peripheral_pulse has the same factor levels in horse_data as in the model
horse_data$peripheral_pulse <- factor(horse_data$peripheral_pulse, levels = levels(train_data$peripheral_pulse))

# Predict outcomes using the logistic regression model
predictions <- predict(model, newdata = horse_data, type = "response")

# Convert predicted probabilities to binary predictions (0 or 1)
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Create a confusion matrix
conf_matrix <- table(horse_data$outcome, predicted_classes)
print("Confusion Matrix:")
print(conf_matrix)

# Calculate accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", accuracy))

# Calculate precision
precision <- conf_matrix[2, 2] / sum(conf_matrix[, 2])
print(paste("Precision:", precision))

# Calculate recall (sensitivity)
recall <- conf_matrix[2, 2] / sum(conf_matrix[2, ])
print(paste("Recall (Sensitivity):", recall))

# Calculate specificity
specificity <- conf_matrix[1, 1] / sum(conf_matrix[1, ])
print(paste("Specificity:", specificity))

# Calculate F1 score
f1_score <- 2 * (precision * recall) / (precision + recall)
print(paste("F1 Score:", f1_score))

# Plot ROC curve
library(pROC)
roc_curve <- roc(horse_data$outcome, predictions)
plot(roc_curve, main = "ROC Curve", col = "blue")


# Train a random forest model
library(randomForest)
rf_model <- randomForest(outcome ~ ., data = horse_data)

# Print the summary of the random forest model
print(rf_model)

library(caret)
library(randomForest)

# Ensure outcome is a factor
horse_data$outcome <- as.factor(horse_data$outcome)

# Remove missing values
horse_data <- na.omit(horse_data)

# Convert categorical variables to factors
horse_data[] <- lapply(horse_data, function(x) if (is.character(x)) as.factor(x) else x)

# Define train control
ctrl <- trainControl(method = "cv", number = 10)

# Define models as a list
models <- list("Logistic Regression" = "glm",
               "Random Forest" = "rf")

# Train models
results <- lapply(models, function(model) {
  train(outcome ~ ., data = horse_data, method = model, trControl = ctrl)
})

# Compare model performance
comparison <- resamples(results)
summary(comparison)
