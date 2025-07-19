# Load required packages
library(readxl)
library(kml)

# Read data by gender
path <- "./data/ASMR.xlsx"

data_both   <- read_excel(path, sheet = "Both")
data_female <- read_excel(path, sheet = "Female")
data_male   <- read_excel(path, sheet = "Male")

# Convert to data.frame
data_both   <- data.frame(data_both)
data_female <- data.frame(data_female)
data_male   <- data.frame(data_male)

# Create cld objects for clustering (1990–2019)
cld_both   <- cld(data_both,   varNames = "ASMR (per 100,000 people)", time = 1990:2019)
cld_female <- cld(data_female, varNames = "ASMR (per 100,000 people)", time = 1990:2019)
cld_male   <- cld(data_male,   varNames = "ASMR (per 100,000 people)", time = 1990:2019)

# Run K-means clustering for each
kml(cld_both)
kml(cld_female)
kml(cld_male)

# Plot Calinski-Harabasz criterion to evaluate clustering
plotAllCriterion(cld_both)
plotAllCriterion(cld_female)
plotAllCriterion(cld_male)

# Plot clustering trajectories
par(mfrow = c(1, 3))
plot(cld_both,   6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", addLegend = TRUE, main = "Both Sexes")
plot(cld_female, 6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", ylab = "", addLegend = TRUE, main = "Female")
plot(cld_male,   6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj", xlab = "Year", ylab = "", addLegend = TRUE, main = "Male")

# Extract cluster results
clusters_both   <- getClusters(cld_both,   nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_female <- getClusters(cld_female, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_male   <- getClusters(cld_male,   nbCluster = 6, clusterRank = 1, asInteger = FALSE)

# Combine into one data.frame
province_names <- data_both$Province  # Make sure column name is correct
cluster_results <- data.frame(
  Province = province_names,
  Cluster_Both   = clusters_both,
  Cluster_Female = clusters_female,
  Cluster_Male   = clusters_male
)

# Save final results
write.csv(cluster_results, "./output/CRD_ASMR_clusters_by_gender.csv", row.names = FALSE)
