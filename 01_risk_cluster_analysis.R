# Load necessary libraries
library(readxl)
library(kml)

# Read data from Excel file (each sheet is a separate risk factor)
# Use relative paths or organize your data in a 'data/' folder
air_data <- read_excel("./data/crd_risk.xlsx", sheet = "Air")
temp_data <- read_excel("./data/crd_risk.xlsx", sheet = "Temperature")
occup_data <- read_excel("./data/crd_risk.xlsx", sheet = "Occupational")

# Convert to data.frame (optional if not already a data.frame)
air_data <- data.frame(air_data)
temp_data <- data.frame(temp_data)
occup_data <- data.frame(occup_data)

# Create cluster longitudinal data objects for each risk
cld_air   <- cld(air_data, varNames = "ASMR (per 100,000 people)", time = 1990:2019)
cld_temp  <- cld(temp_data, varNames = "ASMR (per 100,000 people)", time = 1990:2019)
cld_occup <- cld(occup_data, varNames = "ASMR (per 100,000 people)", time = 1990:2019)

# Run K-means clustering (KmL) on each
kml(cld_air)
kml(cld_temp)
kml(cld_occup)

# Plot clustering criteria to select optimal number of clusters
plotAllCriterion(cld_air)
plotAllCriterion(cld_temp)
plotAllCriterion(cld_occup)

# Plot trajectories for each clustering (example: 6 clusters)
par(mfrow = c(1, 3))  # Plot 3 side-by-side
plot(cld_air, 6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", addLegend = TRUE)
plot(cld_temp, 6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", ylab = "", addLegend = TRUE)
plot(cld_occup, 6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", ylab = "", addLegend = TRUE)

# Extract clusters for each dataset (6 clusters assumed)
clusters_air   <- getClusters(cld_air, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_temp  <- getClusters(cld_temp, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_occup <- getClusters(cld_occup, nbCluster = 6, clusterRank = 1, asInteger = FALSE)

# Combine clusters with province names
# Note: replace 'province_names' with the actual vector or column containing province names
province_names <- air_data$Province  # Adjust this based on actual column name in your data

cluster_results <- data.frame(
  Province = province_names,
  Air = clusters_air,
  Temperature = clusters_temp,
  Occupational = clusters_occup
)

# Save final cluster assignment to CSV file
write.csv(cluster_results, "./output/CRD_ASMR_clusters.csv", row.names = FALSE)
