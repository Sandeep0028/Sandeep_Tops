import pandas as pd

# Load dataset
url = "https://raw.githubusercontent.com/Sandeep0028/Sandeep_Tops/main/Tops/Assessment/Unsupervised%20Learning/marketing_campaign.csv"
df = pd.read_csv(url)

# Clean data: Remove duplicates and NA values
df_clean = df.drop_duplicates().dropna()

import matplotlib.pyplot as plt
import seaborn as sns

# Histogram of age distribution
sns.histplot(df_clean['Age'], kde=True)
plt.title('Age Distribution')
plt.show()

# Scatter plot of Age vs Spending
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df_clean, x='Age', y='Spending', hue='Income')
plt.title('Age vs Spending by Income')
plt.show()

from sklearn.preprocessing import StandardScaler

# Select numerical columns
numerical_cols = ['Age', 'Income', 'Spending']
scaler = StandardScaler()
df_scaled = scaler.fit_transform(df_clean[numerical_cols])

from sklearn.cluster import KMeans
import numpy as np

wcss = []
for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, random_state=42)
    kmeans.fit(df_scaled)
    wcss.append(kmeans.inertia_)

plt.plot(range(1, 11), wcss, marker='o', linestyle='dashed')
plt.title('Elbow Method')
plt.xlabel('Number of Clusters')
plt.ylabel('WCSS')
plt.show()

# Optimal clusters: k=4 (elbow point)

kmeans = KMeans(n_clusters=4, random_state=42)
clusters = kmeans.fit_predict(df_scaled)

from scipy.cluster.hierarchy import dendrogram, linkage

# Compute linkage
Z = linkage(df_scaled, method='ward')

# Plot dendrogram
plt.figure(figsize=(10, 6))
dendrogram(Z, truncate_mode=3, p=3)
plt.title('Dendrogram')
plt.show()

# Optimal clusters: 4 (similar to K-Means)

from sklearn.manifold import TSNE

tsne = TSNE(n_components=2, random_state=42)
tsne_result = tsne.fit_transform(df_scaled)

plt.figure(figsize=(10, 6))
plt.scatter(tsne_result[:, 0], tsne_result[:, 1], c=clusters, cmap='viridis')
plt.title('t-SNE Visualization of Clusters')
plt.colorbar(label='Cluster')
plt.show()

cluster_profiles = df_clean.groupby('Cluster')['Age', 'Income', 'Spending'].mean()
print(cluster_profiles)

df_clean['Cluster_Label'] = clusters

marketing_strategies = {
    0: "Premium offers, loyalty rewards, high-end products.",
    1: "Discount promotions, bundle deals, frequent offers.",
    2: "Basic offers, introductory discounts, retention campaigns.",
    3: "Free shipping, tiered loyalty rewards, personalized recommendations."
}

# Apply to dataset
df_clean['Marketing_Strategy'] = df_clean['Cluster_Label'].map(marketing_strategies)