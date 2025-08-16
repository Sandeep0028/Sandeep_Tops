import numpy as np

# Input array
a = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

# Convert to 2D array with 2 rows
b = a.reshape(2, -1)  # -1 automatically calculates columns

print(b)
# Output:
# [[ 1  2  3  4  5]
#  [ 6  7  8  9 10]]