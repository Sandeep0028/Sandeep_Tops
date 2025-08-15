import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv("car_data.csv") 
# Replace with actual file path

# Initial inspection
print(df.shape)
print(df.info())
print(df.head())

# Check missing values
print(df.isnull().sum())

# Handle missing values (example)
df = df.dropna(subset=['MSRP'])  # Remove rows where MSRP is missing
df['Engine Fuel Type'] = df['Engine Fuel Type'].fillna('Unknown')

# Remove duplicates
df = df.drop_duplicates()

# Convert data types if needed
df['MSRP'] = df['MSRP'].astype(int)

# Basic statistics
print(df.describe())

# Example analysis: Top 10 most expensive cars
top_cars = df.sort_values(by="MSRP", ascending=False).head(10)
print(top_cars[['Make', 'Model', 'MSRP']])

# Visualization: Price distribution
plt.figure(figsize=(8,5))
sns.histplot(df['MSRP'], bins=50, kde=True)
plt.title("Car Price Distribution (MSRP)")
plt.xlabel("Price ($)")
plt.ylabel("Count")
plt.show()

# Visualization: Average price by make
avg_price = df.groupby('Make')['MSRP'].mean().sort_values(ascending=False).head(10)
avg_price.plot(kind='bar', figsize=(10,6))
plt.title("Top 10 Car Brands by Average MSRP")
plt.ylabel("Average Price ($)")
plt.show()
