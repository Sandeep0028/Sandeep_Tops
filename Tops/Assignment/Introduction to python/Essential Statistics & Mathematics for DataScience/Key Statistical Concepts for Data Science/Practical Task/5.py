"""
defect_visualization.py
=======================

"""

# ------------------------------------------------------------------
# 1. Imports
# ------------------------------------------------------------------
import matplotlib.pyplot as plt
import seaborn as sns

# ------------------------------------------------------------------
# 2. Raw data – defect types and their frequencies
# ------------------------------------------------------------------
#   Each defect type is represented by a single capital letter.
#   The corresponding frequency is the number of inspected products
#   that carried that defect.  The total number of inspected products
#   is 200 (30+40+20+10+45+25+30).
defect_types   = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
frequencies   = [30, 40, 20, 10, 45, 25, 30]

# ------------------------------------------------------------------
# 3. The most common defect type (hand‑calculation)
# ------------------------------------------------------------------
#   We first locate the largest frequency, then its index in the list
#   to identify the defect type.
max_freq = max(frequencies)                    # 45  – defect E
max_index = frequencies.index(max_freq)        # 4
most_common_defect = defect_types[max_index]   # 'E'
print(f"\nMost common defect type: {most_common_defect} ({max_freq} defects)")

# ------------------------------------------------------------------
# 4. Create the 10‑count bins for the histogram
# ------------------------------------------------------------------
#   Bins are 0‑10, 10‑20, 20‑30, 30‑40, 40‑50.
#   For each defect frequency we count in which bin it falls.
#   The logic below is identical to:
#        if 0 <= f < 10:   bin 0
#        if 10 <= f < 20:  bin 1
#        ...
bin_edges = [0, 10, 20, 30, 40, 50]          # left‑inclusive
hist_counts = [0] * (len(bin_edges) - 1)     # five zeroes

for f in frequencies:
    # find the correct bin
    for i in range(len(bin_edges)-1):
        left  = bin_edges[i]
        right = bin_edges[i+1]
        if left <= f < right:                # left‑edge inclusive, right‑edge exclusive
            hist_counts[i] += 1
            break

# ------------------------------------------------------------------
# 5. Visualisation: Bar chart
# ------------------------------------------------------------------
#   Seaborn makes a “nice” bar chart with a single call.
sns.set_theme(style="whitegrid")            # nice background grid
plt.figure(figsize=(8, 5))                  # width 8‑inch, height 5‑inch

barplot = sns.barplot(
    x = defect_types,
    y = frequencies,
    palette="muted",
    edgecolor=".2",
    linewidth=1
)

#   Add the numeric labels above each bar
for p in barplot.patches:
    height = p.get_height()
    barplot.text(
        p.get_x() + p.get_width()/2.,
        height + 1,                      # small offset so the text does not sit on the bar
        f'{height:.0f}',
        ha = "center",
        va = "bottom"
    )

barplot.set_xlabel("Defect type")
barplot.set_ylabel("Number of inspected products")
barplot.set_title("Defect frequency – bar chart")

# ------------------------------------------------------------------
# 6. Visualisation: Histogram
# ------------------------------------------------------------------
#   We plot a histogram of the *distribution of the frequencies*.
#   That is, the histogram’s *x‑axis* is a frequency value (e.g. 30),
#   and the *y‑axis* counts how many defect types had a frequency in that bin.
plt.figure(figsize=(8, 5))

#   Seaborn's histplot automatically calculates the binning, but
#   we want a bin width of 10.  The `bins` argument accepts either
#   an int (number of bins) or a sequence of bin edges.
sns.histplot(
    frequencies,
    bins = bin_edges,                    # 0‑10, 10‑20, …
    color="steelblue",
    edgecolor="black",
    kde=False,
    linewidth=1.5
)

#   Annotate each bar with the count of defect types in that bin
for i, count in enumerate(hist_counts):
    left  = bin_edges[i]
    right = bin_edges[i+1]
    # centre of the bin on the x‑axis
    centre = (left + right) / 2.0
    # we put the annotation slightly above the bar (vertical offset = 0.3)
    plt.text(
        centre,
        count + 0.3,
        f'{count}',
        ha="center",
        va="bottom",
        fontweight="bold"
    )

plt.xlabel("Defect frequency (number of products)")
plt.ylabel("Number of defect types")
plt.title("Distribution of defect frequencies – histogram")
plt.xticks(bin_edges)                     # make sure all bin edges show

# ------------------------------------------------------------------
# 7. Show both figures in one window
# ------------------------------------------------------------------
#   We use Matplotlib's `tight_layout` so the sub‑titles/labels do not overlap.
fig, ax = plt.subplots(1, 2, figsize=(15, 6))
#   The first subplot will contain the bar chart
sns.barplot(
    x=defect_types,
    y=frequencies,
    palette="muted",
    ax=ax[0],
    edgecolor=".2",
    linewidth=1
)
ax[0].set_xlabel("Defect type")
ax[0].set_ylabel("Number of inspected products")
ax[0].set_title("Defect frequency – bar chart")
#   The second subplot will contain the histogram
sns.histplot(
    frequencies,
    bins=bin_edges,
    color="steelblue",
    edgecolor="black",
    kde=False,
    linewidth=1.5,
    ax=ax[1]
)
ax[1].set_xlabel("Defect frequency (number of products)")
ax[1].set_ylabel("Number of defect types")
ax[1].set_title("Distribution of defect frequencies – histogram")
ax[1].set_xticks(bin_edges)
plt.tight_layout()

# ------------------------------------------------------------------
# 8. Save the figure (optional) and display it
# ------------------------------------------------------------------
plt.savefig("defect_visualisations.png", dpi=300, bbox_inches="tight")
plt.show()
