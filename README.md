# Longitudinal Clustering of Chronic Respiratory Disease Burden in Iran (1990–2021)

This repository contains R scripts and supporting materials used in the following research:

**Title:** *National, Subnational, and Risk-Attributed Burden of Chronic Respiratory Diseases in Iran (1990–2021): A Longitudinal Clustering Analysis of GBD 2021 Data*  
**Authors:** Mohammad Sadegh Loeloe, Seyyed Mohammad Tabatabaei, Reyhane Sefidkar, Amir Houshang Mehrparvar, Sara Jambarsang

## 🧠 Overview

We used the KmL (K-means for Longitudinal Data) method to identify temporal patterns in the burden of chronic respiratory diseases (CRDs), including asthma and COPD, across 31 provinces of Iran over the period 1990–2021.

This analysis was based on the GBD 2021 dataset and focused on trends in:
- Age-standardized mortality rate (ASMR)
- Age-standardized incidence rate (ASIR)
- Age-standardized prevalence rate (ASPR)
- CRD burden attributable to occupational and environmental risk factors

## 📂 Repository Structure

- `scripts/`: Main R scripts for data preparation, clustering (KmL), and visualization
- `data/`: Input datasets (not included for licensing reasons; see notes below)
- `output/`: Figures and cluster membership results
- `README.md`: This project documentation
- `LICENSE`: Open-source MIT License

## 🛠️ Requirements

- R version 4.4.1 or later
- R packages:
  - `kml` (v2.5.0)
  - `ggplot2`
  - `dplyr`
  - `readr`
  - `sf` (for map visualization)
  - Other standard tidyverse tools

## 🧪 Reproducibility

All scripts are modular and can be run in sequence:

1. `01_preprocessing.R`: Loads and cleans data
2. `02_kml_clustering.R`: Applies KmL clustering
3. `03_visualization.R`: Generates figures and maps

## 📊 Citation

If you use this code or analysis in your work, please cite:

> Loeloe MS, Tabatabaei SM, Sefidkar R, Mehrparvar AH, Jambarsang S. National, Subnational, and Risk-Attributed Burden of Chronic Respiratory Diseases in Iran (1990–2021): A Longitudinal Clustering Analysis of GBD 2021 Data. *Health Science Reports*. 2025.

## 📬 Contact

For questions or feedback, please contact:  
📧 Sara Jambarsang – [S.Jambarsang@gmail.com](mailto:S.Jambarsang@gmail.com)

## 📄 License

This project is licensed under the MIT License — see the `LICENSE` file for details.
