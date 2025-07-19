# Load required packages
library(kml)
library(readxl)
library(dplyr)
library(ggplot2)
library(sf)

# Load province shapefile (level 1 boundaries)
iran <- sf::st_read("./map/irn_admbnda_adm1_unhcr_20190514.shp")

# Load data and clustering result (from previous analysis)
# Assume CRDDa already loaded and clustering 'c11' exists
clusters <- getClusters(c11, nbCluster = 6, clusterRank = 1, asInteger = TRUE)

# Combine location names with cluster assignment
map_data <- data.frame(
  location = CRDDa$location,
  cluster  = clusters
)

# Clean problematic names if needed (e.g., "Khorasan" ? "Razavi Khorasan")
map_data$location <- gsub("Khorasan", "Razavi Khorasan", map_data$location)

# Drop unmatched/extra rows if needed (e.g., if one non-province row exists)
map_data <- map_data[1:31, ]

# Sort alphabetically by location to match shapefile
map_data <- map_data[order(map_data$location), ]

# Merge shapefile with cluster data based on province name
iran$Province <- iran$ADM1_EN
iran_map <- left_join(iran, map_data, by = c("Province" = "location"))

# Assign colors to clusters
cluster_colors <- c("#ff9933", "#ffcc66", "#FFCC99", "#FFFF33", "#99ff00", "#66ff00")
iran_map$color <- cluster_colors[iran_map$cluster]

# Compute centroid coordinates for province labels
label_coords <- st_centroid(iran_map) %>% st_coordinates()

# Prepare data for labels
label_df <- data.frame(
  x = label_coords[, 1],
  y = label_coords[, 2],
  state = iran_map$Province
)

# Plot map using ggplot2
ggplot(data = iran_map) +
  geom_sf(aes(fill = color), color = "black", size = 0.2) +
  scale_fill_identity() +
  geom_text(data = label_df, aes(x = x, y = y, label = state), size = 2.5) +
  theme_void() +
  ggtitle("Clustering of CRD Burden in Iran (1990–2021)") +
  theme(plot.title = element_text(hjust = 0.5, size = 14))
ggsave("./output/CRD_Cluster_Map.png", width = 10, height = 8, dpi = 300)
