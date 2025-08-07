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
- `data/`: Input datasets ( CRD, COPD, and Asthma (Prevalence, Incidence, Deaths, DALYs))
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

1. `01_risk_cluster_analysis.R`: Clustering analysis of air pollution, temperature, and occupational risks
2. `02_risk_dalys_deaths_clustering.R`:Clustering of DALYs and Deaths by risk factors
3. `03_vpidd_multivariate_clustering.R`: Multivariate clustering of CRD, COPD, and Asthma (Prevalence, Incidence, Deaths, DALYs)
4. `04_genderwise_crd_clustering.R`: Gender-specific clustering of ASMR for CRDs
5. `05_air_occupational_clustering.R`: Clustering of CRD burden due to air pollution and occupational exposure
6. `06_iran_cluster_map.R`: Mapping the clusters of CRD burden across Iranian provinces
## 📊 Citation

If you use this code or analysis in your work, please cite:

> Loeloe MS, Tabatabaei SM, Sefidkar R, Mehrparvar AH, Jambarsang S. National, Subnational, and Risk-Attributed Burden of Chronic Respiratory Diseases in Iran (1990–2021): A Longitudinal Clustering Analysis of GBD 2021 Data. .... 2025.

## 📬 Contact

For questions or feedback, please contact:  
📧 Mohammad Sadegh Loeloe – [mslbiostat@gmail.com](mailto:mslbiostat@gmail.com)

## 📄 License

This project is licensed under the MIT License — see the `LICENSE` file for details.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16758060.svg)](https://doi.org/10.5281/zenodo.16758060)
