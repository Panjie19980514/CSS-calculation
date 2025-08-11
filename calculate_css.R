# calculate_css.R

# Load necessary library
library(caret)

# Define regression coefficients
coefficients <- c(
  bs_G_oc_temp_med_Parahip_thickness = 1.428829629,
  delta_G_oc_temp_med_Parahip_volume = -0.001953807,
  delta_G_temp_sup_Plan_polar_thickness = 1.980710066,
  delta_G_temp_sup_Plan_tempo_thickness = 1.903838946,
  delta_G_oc_temp_med_Parahip_area = 0.004822558,
  delta_G_temp_sup_Lateral_area = 0.001258791,
  post_Fornix_cres_Stria_terminalis_FA = 1.563093375,
  post_Superior_longitudinal_fasciculus_FA = -27.365530295
)

# Input variable values
# Users can input variable values in the following ways:
# 1. Directly modify the sample_data data frame in the script
# 2. Read data from an external file (e.g., CSV file)

# Example: Directly define sample data in the script
sample_data <- data.frame(
  bs_G_oc_temp_med_Parahip_thickness = c(0.5, 0.6, 0.7),
  delta_G_oc_temp_med_Parahip_volume = c(100, 110, 120),
  delta_G_temp_sup_Plan_polar_thickness = c(0.8, 0.9, 1.0),
  delta_G_temp_sup_Plan_tempo_thickness = c(0.7, 0.8, 0.9),
  delta_G_oc_temp_med_Parahip_area = c(50, 60, 70),
  delta_G_temp_sup_Lateral_area = c(30, 40, 50),
  post_Fornix_cres_Stria_terminalis_FA = c(0.3, 0.4, 0.5),
  post_Superior_longitudinal_fasciculus_FA = c(0.2, 0.3, 0.4)
)

# Standardize continuous variables
# Identify continuous columns (assuming all columns are continuous in this example)
continuous_cols <- colnames(sample_data)

# Preprocess data for standardization
norm_model <- preProcess(sample_data[, continuous_cols], method = c("center", "scale"))

# Apply standardization
sample_data_standardized <- predict(norm_model, sample_data[, continuous_cols])

# Calculate CSS using standardized values
CSS <- rowSums(sweep(sample_data_standardized, 2, coefficients, `*`))

# Add CSS to the data frame
sample_data$CSS <- CSS

# Print the result
print("Sample Data with CSS:")
print(sample_data)

# If you want to save the result to a CSV file
# write.csv(sample_data, "sample_data_with_css.csv", row.names = FALSE)

# If you want to read data from an external CSV file
# sample_data <- read.csv("input_data.csv")
# Continuous columns should be identified based on your data structure
# continuous_cols <- c("bs_G_oc_temp_med_Parahip_thickness", "delta_G_oc_temp_med_Parahip_volume", ...)
# norm_model <- preProcess(sample_data[, continuous_cols], method = c("center", "scale"))
# sample_data_standardized <- predict(norm_model, sample_data[, continuous_cols])
# CSS <- rowSums(sweep(sample_data_standardized, 2, coefficients, `*`))
# sample_data$CSS <- CSS
# print("Sample Data with CSS:")
# print(sample_data)