# Load required libraries
library(readxl)
library(kml)

# Load data from Excel file
path <- "./data/AirOccup.xlsx"

deaths_air  <- read_excel(path, sheet = "DeathsA")
deaths_occup <- read_excel(path, sheet = "DeathsO")
dalys_air   <- read_excel(path, sheet = "DALYsA")
dalys_occup <- read_excel(path, sheet = "DALYsO")

# Convert to data.frames
deaths_air  <- data.frame(deaths_air)
deaths_occup <- data.frame(deaths_occup)
dalys_air   <- data.frame(dalys_air)
dalys_occup <- data.frame(dalys_occup)

# Create cld objects for clustering
cld_deaths_air   <- cld(deaths_air, varNames = "per 100,000 people", time = 1990:2021)
cld_deaths_occup <- cld(deaths_occup, varNames = "per 100,000 people", time = 1990:2021)
cld_dalys_air    <- cld(dalys_air, varNames = "ASMR (per 100,000 people)", time = 1990:2021)
cld_dalys_occup  <- cld(dalys_occup, varNames = "ASMR (per 100,000 people)", time = 1990:2021)

# Run clustering
kml(cld_deaths_air)
kml(cld_deaths_occup)
kml(cld_dalys_air)
kml(cld_dalys_occup)

# Plot Calinski criteria for optimal clusters
plotAllCriterion(cld_deaths_air)
plotAllCriterion(cld_deaths_occup)
plotAllCriterion(cld_dalys_air)
plotAllCriterion(cld_dalys_occup)

# Define custom colors for plots
colors_air  <- c("#FFFF00", "#00FF00", "#0000FF", "#00FFFF", "#FF0000", "#FF00FF")
colors_occup <- c("#FFFF00", "#00FF00", "#00FFFF", "#FF00FF", "#0000FF", "#FF0000")

# Plot trajectories
par(mfrow = c(2, 2))

plot(cld_deaths_air, 6, parMean = parMEAN(pchPeriod = Inf, col = colors_air),
     toPlot = "traj", xlab = "", ylab = "Age-standardized rates (per 100K)",
     addLegend = FALSE, parTRAJ(type = "n", col = "clusters"),
     main = "Air Pollution - Deaths")

plot(cld_dalys_air, 6, parMean = parMEAN(pchPeriod = Inf),
     toPlot = "traj", xlab = "", ylab = "",
     addLegend = FALSE, parTRAJ(type = "n", col = "clusters"),
     main = "Air Pollution - DALYs")

plot(cld_deaths_occup, 6, parMean = parMEAN(pchPeriod = Inf, col = colors_occup),
     toPlot = "traj", xlab = "Year", ylab = "",
     addLegend = FALSE, parTRAJ(type = "n", col = "clusters"),
     main = "Occupational - Deaths")

plot(cld_dalys_occup, 6, parMean = parMEAN(pchPeriod = Inf),
     toPlot = "traj", xlab = "Year", ylab = "",
     addLegend = FALSE, parTRAJ(type = "n", col = "clusters"),
     main = "Occupational - DALYs")

# Extract cluster assignments
clusters_deaths_air   <- getClusters(cld_deaths_air, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_deaths_occup <- getClusters(cld_deaths_occup, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_dalys_air    <- getClusters(cld_dalys_air, nbCluster = 6, clusterRank = 1, asInteger = FALSE)
clusters_dalys_occup  <- getClusters(cld_dalys_occup, nbCluster = 6, clusterRank = 1, asInteger = FALSE)

# Combine cluster results
province_names <- deaths_air$location  # Adjust column name if needed

cluster_results <- data.frame(
  Province   = province_names,
  Deaths_Air = clusters_deaths_air,
  Deaths_Occup = clusters_deaths_occup,
  DALYs_Air = clusters_dalys_air,
  DALYs_Occup = clusters_dalys_occup
)

# Export results to CSV
write.csv(cluster_results, "./output/ClassAirOccup.csv", row.names = FALSE)
