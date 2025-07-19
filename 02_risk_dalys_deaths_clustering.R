# Load required libraries
library(readxl)
library(kml)

# Read DALYs and Deaths data from Excel file
dalys_data <- read_excel("./data/RiskClass.xlsx", sheet = "DALYs")
deaths_data <- read_excel("./data/RiskClass.xlsx", sheet = "Deaths")

# Convert to data.frames if necessary
dalys_data <- data.frame(dalys_data)
deaths_data <- data.frame(deaths_data)

# Create longitudinal data objects for clustering
cld_dalys  <- cld(dalys_data, varNames = "per 100,000 people", time = 1990:2021)
cld_deaths <- cld(deaths_data, varNames = "per 100,000 people", time = 1990:2021)

# Run KmL clustering algorithm
kml(cld_dalys)
kml(cld_deaths)

# Plot Calinski criteria to evaluate optimal number of clusters
plotAllCriterion(cld_dalys)
plotAllCriterion(cld_deaths)

# Plot trajectories for each risk (DALYs and Deaths)
par(mfrow = c(1, 2))
plot(cld_deaths, 4, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj",
     xlab = "", ylab = "Age-standardized rates (per 100,000)",
     main = "Deaths", addLegend = FALSE, parTRAJ(type = "l", col = "clusters"))

plot(cld_dalys, 6, parMean = parMEAN(pchPeriod = Inf), toPlot = "traj",
     xlab = "", ylab = "", main = "DALYs", addLegend = FALSE, parTRAJ(type = "n", col = "clusters"))

# Extract final clusters (number based on optimal Calinski criterion)
clusters_deaths <- getClusters(cld_deaths, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_dalys  <- getClusters(cld_dalys, nbCluster = 6, clusterRank = 1, asInteger = FALSE)

# Combine with risk factor names
risk_names <- deaths_data$Risk  # Adjust column name if different

cluster_risks <- data.frame(
  Risk = risk_names,
  Deaths = clusters_deaths,
  DALYs = clusters_dalys
)

# Export final clustering result
write.csv(cluster_risks, "./output/RiskClass_clusters.csv", row.names = FALSE)
