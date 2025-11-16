# ==============================================================================
# R PRACTICAL 13: K-MEANS CLUSTERING AND ELBOW METHOD
# Subject: Data Mining with R (Master's Level)
# ==============================================================================

# 1. Install and Load necessary packages
# cluster: Provides clustering algorithms and diagnostics.
# ggplot2: For high-quality, professional visualization.
# factoextra: Simplifies the extraction and visualization of factor analysis and clustering results.

# install.packages(c("cluster", "ggplot2", "factoextra")) 
library(cluster)
library(ggplot2)
library(factoextra)

cat("\n--- PACKAGES LOADED ---\n")


# ------------------------------------------------------------------------------
# 2. DATA PREPARATION
# ------------------------------------------------------------------------------

# Use the 'iris' dataset and select only the numeric columns (1 to 4)
# We store the data as a matrix for the K-means algorithm.
data_to_cluster <- iris[, 1:4]

# Scaling the data is critical for K-means as it relies on Euclidean distance.
# Scaling standardizes all variables to have a mean of 0 and SD of 1.
data_scaled <- scale(data_to_cluster)

cat("\n--- DATA PREPARATION ---\n")
print(head(data_scaled))
cat("Data scaled successfully.\n")


# ------------------------------------------------------------------------------
# 3. ELBOW METHOD TO FIND OPTIMAL K
# The Elbow method plots the Total Within-Cluster Sum of Squares (WSS) 
# against the number of clusters (k). The 'elbow' or bend indicates optimal k.
# ------------------------------------------------------------------------------

cat("\n--- ELBOW METHOD CALCULATION ---\n")

# Use fviz_nbclust from factoextra, which automates the process.
elbow_plot <- fviz_nbclust(
  data_scaled, 
  kmeans, 
  method = "wss", 
  k.max = 10 # Check k from 1 to 10
) +
  geom_vline(xintercept = 3, linetype = 2, color = "red") +
  labs(title = "Elbow Method for Optimal k")

# Display the elbow plot
print(elbow_plot) 
# Note: For the iris dataset, the plot usually shows a clear bend at k=3.

optimal_k <- 3 # Based on the standard result for the iris dataset


# ------------------------------------------------------------------------------
# 4. PERFORM K-MEANS CLUSTERING
# ------------------------------------------------------------------------------

cat("\n--- K-MEANS CLUSTERING (k=", optimal_k, ") ---\n")

# nstart = 25: Runs K-means 25 times and picks the best result (lowest WSS).
# iter.max = 30: Maximum number of iterations for the algorithm.
kmeans_result <- kmeans(data_scaled, centers = optimal_k, nstart = 25, iter.max = 30)

# Display the summary of the clustering result
print(kmeans_result)


# ------------------------------------------------------------------------------
# 5. VISUALIZE THE CLUSTERS IN 2D
# We use Principal Component Analysis (PCA) to reduce the 4 dimensions 
# into 2 for a clear visual plot.
# ------------------------------------------------------------------------------

cat("\n--- CLUSTER VISUALIZATION (PCA Reduction) ---\n")

cluster_plot <- fviz_cluster(
  kmeans_result, 
  data = data_scaled, 
  palette = "jco",  # A nice color palette
  ggtheme = theme_minimal(), 
  main = paste("K-means Clustering Results (k =", optimal_k, ")")
)

# Display the 2D cluster visualization plot
print(cluster_plot)
cat("----------------------------------------------\n")