import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans, AgglomerativeClustering
import matplotlib.pyplot as plt
import seaborn as sns

# -------------------------------------------------------------
# 1. Load the data
df = pd.read_csv('Mall_Customers.csv')

# -------------------------------------------------------------
# 2. Keep the two numeric columns we want to cluster on
X = df[['Annual Income (k$)', 'Spending Score (1-100)']].values

# 3. Standardise – improves k‑means convergence
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# -------------------------------------------------------------
# 4. K‑means clustering
kmeans = KMeans(n_clusters=5, random_state=42)
df['KMeansCluster'] = kmeans.fit_predict(X_scaled)

# -------------------------------------------------------------
# 5. Optional: hierarchical clustering (dendrogram)
agg = AgglomerativeClustering(n_clusters=5, linkage='ward')
df['AggCluster'] = agg.fit_predict(X_scaled)

# -------------------------------------------------------------
# 6. Plot the K‑means result
plt.figure(figsize=(8,6))
sns.scatterplot(data=df, x='Annual Income (k$)', y='Spending Score (1-100)',
                hue='KMeansCluster', palette='viridis', s=70, alpha=0.8)
plt.title('K‑means Clustering of Mall Customers')
plt.xlabel('Annual Income (k$)')
plt.ylabel('Spending Score (1‑100)')
plt.legend(title='Cluster')
plt.tight_layout()
plt.show()

# -------------------------------------------------------------
# 7. (Optional) Plot the dendrogram using scipy
#    (requires scipy)
"""
from scipy.cluster.hierarchy import dendrogram, linkage
Z = linkage(X_scaled, method='ward')
plt.figure(figsize=(10, 4))
dendrogram(Z, truncate_mode='lastp', p=12, leaf_rotation=90., leaf_font_size=12.)
plt.title('Hierarchical Clustering Dendrogram')
plt.xlabel('Cluster Size')
plt.ylabel('Distance')
plt.tight_layout()
plt.show()
"""
