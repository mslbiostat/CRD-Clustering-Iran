# Load required packages
library(readxl)
library(kml)
library(RColorBrewer)

# Read all sheets from Excel file (each sheet corresponds to a measure/disease)
path <- "./data/PIDD.xlsx"

CRD_prev <- read_excel(path, sheet = "CRDPr")
CRD_inc  <- read_excel(path, sheet = "CRDIn")
CRD_death <- read_excel(path, sheet = "CRDDe")
CRD_daly <- read_excel(path, sheet = "CRDDa")

COPD_prev <- read_excel(path, sheet = "COPDPr")
COPD_inc  <- read_excel(path, sheet = "COPDIn")
COPD_death <- read_excel(path, sheet = "COPDDe")
COPD_daly <- read_excel(path, sheet = "COPDDa")

Asthma_prev <- read_excel(path, sheet = "AsPr")
Asthma_inc  <- read_excel(path, sheet = "AsIn")
Asthma_death <- read_excel(path, sheet = "AsDe")
Asthma_daly <- read_excel(path, sheet = "AsDa")

# Convert to data.frames
dfs <- list(CRD_prev, CRD_inc, CRD_death, CRD_daly,
            COPD_prev, COPD_inc, COPD_death, COPD_daly,
            Asthma_prev, Asthma_inc, Asthma_death, Asthma_daly)

dfs <- lapply(dfs, as.data.frame)

# Assign to objects
list2env(setNames(dfs, c("CRD_prev", "CRD_inc", "CRD_death", "CRD_daly",
                         "COPD_prev", "COPD_inc", "COPD_death", "COPD_daly",
                         "Asthma_prev", "Asthma_inc", "Asthma_death", "Asthma_daly")), envir = .GlobalEnv)

# Create cld objects for each indicator
cld_list <- list(
  cld(CRD_prev, varNames = "per 100,000 people", time = 1990:2021),
  cld(CRD_inc,  varNames = "per 100,000 people", time = 1990:2021),
  cld(CRD_daly, varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(CRD_death,varNames = "ASMR (per 100,000 people)", time = 1980:2021),

  cld(COPD_prev, varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(COPD_inc,  varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(COPD_daly, varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(COPD_death,varNames = "ASMR (per 100,000 people)", time = 1980:2021),

  cld(Asthma_prev, varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(Asthma_inc,  varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(Asthma_daly, varNames = "ASMR (per 100,000 people)", time = 1990:2021),
  cld(Asthma_death,varNames = "ASMR (per 100,000 people)", time = 1980:2021)
)

# Run KmL on each
lapply(cld_list, kml)

# Optional: Plot Calinski criteria
lapply(cld_list, plotAllCriterion)

# Optional: Set color palette
cols <- c("#00FFFF", "#FFFF00", "#00FF00", "#0000FF", "#FF00FF", "#FF0000")

# Plot all clusters
par(mfrow = c(3, 4))  # 3 rows x 4 columns
titles <- c("CRD Prevalence", "CRD Incidence", "CRD DALYs", "CRD Deaths",
            "COPD Prevalence", "COPD Incidence", "COPD DALYs", "COPD Deaths",
            "Asthma Prevalence", "Asthma Incidence", "Asthma DALYs", "Asthma Deaths")

for (i in seq_along(cld_list)) {
  plot(cld_list[[i]], 6, parMean = parMEAN(pchPeriod = Inf),
       toPlot = "traj", xlab = "Year", ylab = "", main = titles[i],
       addLegend = FALSE, parTRAJ(type = "n", col = "clusters"))
}

# Extract cluster results
cluster_assignments <- lapply(cld_list, function(c) getClusters(c, nbCluster = 6, clusterRank = 1, asInteger = FALSE))

# Combine all into one data frame
province_names <- CRD_prev$location  # Assumes 'location' column exists
cluster_df <- data.frame(province_names, do.call(cbind, cluster_assignments))

colnames(cluster_df) <- c("Province",
  "CRD_Prevalence", "CRD_Incidence", "CRD_DALYs", "CRD_Deaths",
  "COPD_Prevalence", "COPD_Incidence", "COPD_DALYs", "COPD_Deaths",
  "Asthma_Prevalence", "Asthma_Incidence", "Asthma_DALYs", "Asthma_Deaths")

# Save the result
write.csv(cluster_df, "./output/CRD_COPD_Asthma_clusters.csv", row.names = FALSE)
