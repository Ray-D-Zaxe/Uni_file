# ==============================================================================
# R PRACTICAL 14: CLUSTERING PERFORMANCE COMPARISON (K-means vs. H-Clustering)
# Subject: Data Mining with R (Master's Level)
# ==============================================================================

# 1. Load necessary packages
# cluster: Provides silhouette score calculation and hierarchical clustering functions.
# factoextra: For visualization and convenient clustering functions.
# ggplot2: For plotting.

# install.packages(c("cluster", "factoextra", "ggplot2")) 
library(cluster)
library(factoextra)
library(ggplot2)
library(dplyr) # For data manipulation if needed

cat("\n--- PACKAGES LOADED ---\n")


# ------------------------------------------------------------------------------
# 2. DATA PREPARATION
# ------------------------------------------------------------------------------

# Use the scaled iris dataset from the previous practical.
data_to_cluster <- iris[, 1:4]
data_scaled <- scale(data_to_cluster)

# Define the optimal number of clusters (k=3 for iris)
optimal_k <- 3 

cat("\n--- DATA PREPARED AND SCALED ---\n")


# ------------------------------------------------------------------------------
# 3. K-MEANS CLUSTERING AND SILHOUETTE SCORE
# ------------------------------------------------------------------------------

cat("\n--- A. K-MEANS CLUSTERING (k=", optimal_k, ") ---\n")

# Run K-means
kmeans_result <- kmeans(data_scaled, centers = optimal_k, nstart = 25)

# Calculate the Euclidean distance matrix (required for silhouette)
distance_matrix <- dist(data_scaled, method = "euclidean")

# 3a. Calculate the Silhouette score
# silhouette() takes the distance matrix and the cluster assignments.
kmeans_silhouette <- silhouette(kmeans_result$cluster, distance_matrix)

# 3b. Extract the average Silhouette width (the performance metric)
kmeans_avg_width <- mean(kmeans_silhouette[, 3])

cat(paste("K-means Average Silhouette Width:", round(kmeans_avg_width, 4), "\n"))


# ------------------------------------------------------------------------------
# 4. HIERARCHICAL CLUSTERING (H-Clustering) AND SILHOUETTE SCORE
# ------------------------------------------------------------------------------

cat("\n--- B. HIERARCHICAL CLUSTERING (k=", optimal_k, ") ---\n")

# 4a. Perform Hierarchical Clustering
# hclust() requires the distance matrix calculated earlier.
# 'method="ward.D2"' is generally recommended for optimizing the variance.
hclust_model <- hclust(distance_matrix, method = "ward.D2")

# 4b. Cut the tree into 'k' clusters
# cutree() extracts the cluster assignments from the dendrogram.
hclust_clusters <- cutree(hclust_model, k = optimal_k)

# 4c. Calculate the Silhouette score
hclust_silhouette <- silhouette(hclust_clusters, distance_matrix)

# 4d. Extract the average Silhouette width
hclust_avg_width <- mean(hclust_silhouette[, 3])

cat(paste("H-Clustering Average Silhouette Width:", round(hclust_avg_width, 4), "\n"))


# ------------------------------------------------------------------------------
# 5. COMPARISON AND VISUALIZATION
# ------------------------------------------------------------------------------

cat("\n--- 5. FINAL COMPARISON ---\n")

comparison_df <- data.frame(
  Algorithm = c("K-means", "Hierarchical (Ward.D2)"),
  Avg_Silhouette_Score = c(kmeans_avg_width, hclust_avg_width)
)

print(comparison_df)

# Determine the winner
winner <- comparison_df[which.max(comparison_df$Avg_Silhouette_Score), "Algorithm"]
cat(paste("\nConclusion: The", winner, "algorithm performed better based on the Silhouette Score.\n"))

# Optional: Visualize the Silhouette profiles (useful for deeper inspection)
fviz_silhouette(kmeans_silhouette, main = "K-means Silhouette Profile") # [Image of K-means silhouette plot]
fviz_silhouette(hclust_silhouette, main = "H-Clustering Silhouette Profile") # [Image of Hierarchical Clustering silhouette plot]
cat("\nVisualizing Silhouette Profiles for both models...\n")