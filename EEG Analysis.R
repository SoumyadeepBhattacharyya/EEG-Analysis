install.packages ("tidyverse")
install.packages ("skimr")
install.packages ("GGally")
install.packages ("corrplot")

setwd("C:/Users/HP/Desktop")
df <- readxl::read_excel("C:\\Users\\HP\\Desktop\\eeg_dataset_advanced.csv.xlsx")
head (df)

str(df)

summary(df)

# for histogram
skim(df)

install.packages("skimr")
library(skimr)

# Count missing values in each column
colSums (is.na(df))

# Percentage of missing values
colMeans (is.na (df)) * 100

#Detect Duplicates
sum(duplicated(df))

#Convert Categorical Columns to Factors
categorical_cols <- c("SubjectID", "Sex", "Diagnosis", "Session", "Event")
df[categorical_cols] <- lapply(df[categorical_cols], factor)
str (df)

head (df)

View(df)

#create clean copy
df_clean <- df

#Detecting and treating outliers 
cat("Detecting and treating outliers...\n")
# 1. Numeric columns identify
numeric_cols <- sapply(df_clean, is.numeric)
num_df <- df_clean[, numeric_cols]
# 2. Loop through each numeric column
for (col in names(num_df)) {
  Q1 <- quantile(df_clean[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(df_clean[[col]], 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  median_val <- median(df_clean[[col]], na.rm = TRUE)
  # Replace lower outliers
  df_clean[[col]][df_clean[[col]] < lower] <- median_val
  # Replace upper outliers
  df_clean[[col]][df_clean[[col]] > upper] <- median_val
}

#Visualizing Outliers Using Boxplot
# 1. Identify numeric columns
numeric_cols <- sapply(df, is.numeric)
# 2. Create boxplot for all numeric columns
par(mar=c(8,4,4,2))   # Increase bottom margin for labels
boxplot(df[, numeric_cols],
        main = "Boxplots for All Numeric Columns",
        las = 2,                 # Rotate x-axis labels vertically
        col = "lightblue")       


#Pairplot (Relationship Between EEG Features)
GGally::ggpairs(
  df[, c("AlphaPower", "BetaPower", "ThetaPower", "GammaPower", "SNR")],
  diag = list(continuous = "densityDiag"),     # KDE on diagonal
  upper = list(continuous = "cor"),            # correlation values on upper panel
  lower = list(continuous = "points")          # scatter plots on lower panel
)



#Class Distribution — Diagnosis Countplot
install.packages("plotly")
library(dplyr)
library(plotly)

# Step 1: Count frequency of each Diagnosis
df_count <- df %>% 
  count(Diagnosis)     # gives: Diagnosis | n

# Step 2: Plot the count table
df_count <- as.data.frame(table(df$Diagnosis))
colnames(df_count) <- c("Diagnosis", "Count")

fig <- plot_ly(
  data = df_count,
  x = ~Diagnosis,
  y = ~Count,
  type = "bar",
  color = ~Diagnosis,
  colors = "Dark2"
)

fig <- fig %>% layout(
  title = "Diagnosis Class Distribution",
  width = 700,
  height = 500,
  xaxis = list(title = "Diagnosis"),
  yaxis = list(title = "Count")
)

fig



#Boxplot - EEG Channel1 vs Diagnosis
library(ggplot2)

ggplot(df, aes(x = Diagnosis, y = EEG_Ch1, fill = Diagnosis)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  theme_minimal() +
  labs(
    title = "EEG Channel 1 Across Diagnosis",
    x = "Diagnosis",
    y = "EEG_Ch1"
  ) +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


install.packages("gridExtra")

#Histogram — Alpha/Beta/Theta/Gamma
library(ggplot2)
library(gridExtra)

p1 <- ggplot(df, aes(AlphaPower)) + 
  geom_histogram(bins = 30, fill="skyblue", color="black") +
  ggtitle("Alpha Power Distribution")

p2 <- ggplot(df, aes(BetaPower)) + 
  geom_histogram(bins = 30, fill="orange", color="black") +
  ggtitle("Beta Power Distribution")

p3 <- ggplot(df, aes(ThetaPower)) + 
  geom_histogram(bins = 30, fill="purple", color="black") +
  ggtitle("Theta Power Distribution")

p4 <- ggplot(df, aes(GammaPower)) + 
  geom_histogram(bins = 30, fill="green", color="black") +
  ggtitle("Gamma Power Distribution")

gridExtra::grid.arrange(p1, p2, p3, p4, ncol=2)


#KDE Plot — Fatigue Level

library(ggplot2)

ggplot(df, aes(x = FatigueLevel)) +
  geom_density(fill = "skyblue", alpha = 0.5) +
  labs(
    title = "Fatigue Level Distribution",
    x = "Fatigue Level",
    y = "Density"
  ) +
  theme_minimal()


#Scatter Plot — SNR vs GammaPower
library(plotly)

fig <- plot_ly(
  data = df,
  x = ~SNR,
  y = ~GammaPower,
  type = "scatter",
  mode = "markers",
  color = ~Diagnosis,
  colors = "Dark2",                                     # deep colors
  marker = list(size = 8),
  hoverinfo = "text",
  text = ~paste(
    "SubjectID:", SubjectID,
    "<br>Age:", Age,
    "<br>Sex:", Sex,
    "<br>AlphaPower:", AlphaPower,
    "<br>BetaPower:", BetaPower
  )
)

fig <- fig %>% layout(
  title = "SNR vs GammaPower",
  xaxis = list(title = "SNR"),
  yaxis = list(title = "Gamma Power"),
  width = 750,
  height = 500
)

fig


#Line Plot — Engagement Index Over Samples
plot(
  df$EngagementIndex,
  type = "l",              # "l" = line plot
  col = "blue",
  lwd = 2,
  xlab = "Sample",
  ylab = "Engagement Index",
  main = "Engagement Index Over Time"
)


#Interactive Scatter (Swarm-style) — CognitiveLoad by Sex
library(plotly)

# Create jittered version of Sex (M=0, F=1 + small noise)
set.seed(123)  # for reproducible jitter
df$Sex_Jitter <- ifelse(df$Sex == "M", 0, 1) + runif(nrow(df), -0.15, 0.15)

# Create interactive scatter plot
fig <- plot_ly(
  data = df,
  x = ~Sex_Jitter,
  y = ~CognitiveLoad,
  type = "scatter",
  mode = "markers",
  color = ~Sex,
  colors = "Dark2",
  marker = list(size = 9, opacity = 0.7),
  hoverinfo = "text",
  text = ~paste(
    "SubjectID:", SubjectID,
    "<br>Age:", Age,
    "<br>Diagnosis:", Diagnosis,
    "<br>AlphaPower:", AlphaPower,
    "<br>BetaPower:", BetaPower
  )
)

# Fix the X-axis labels
fig <- fig %>% layout(
  title = "Cognitive Load Distribution by Sex (Interactive Scatter with Hover)",
  xaxis = list(
    title = "Sex",
    tickvals = c(0, 1),
    ticktext = c("M", "F")
  ),
  yaxis = list(title = "Cognitive Load"),
  height = 500
)

fig


#Joint Plot — Alpha vs Beta Power
install.packages("hexbin")

library(ggplot2)
library(hexbin)

ggplot(df_clean, aes(x = AlphaPower, y = BetaPower)) +
  stat_bin_hex(bins = 30) +
  scale_fill_continuous(type = "viridis") +
  labs(
    title = "Hexbin Joint Plot: AlphaPower vs BetaPower",
    x = "Alpha Power",
    y = "Beta Power",
    fill = "Count"
  ) +
  theme_minimal()


#Correlation Matrix of Power Bands
install.packages("reshape2")

library(ggplot2)
library(reshape2)

# Select power columns
powers <- df_clean[, c("AlphaPower", "BetaPower", "ThetaPower", "GammaPower")]

# Compute correlation matrix
corr_matrix <- cor(powers, use = "complete.obs")

# Melt for ggplot2
corr_melt <- melt(corr_matrix)

# Plot heatmap
ggplot(data = corr_melt, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title = "Power Band Correlation", x = "", y = "") +
  theme_minimal()


#PIE CHART FOR SEX DISTRIBUTION
library(ggplot2)
library(dplyr)

df %>%
  count(Sex) %>%
  ggplot(aes(x = "", y = n, fill = Sex)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(n / sum(n) * 100, 1), "%")),
            position = position_stack(vjust = 0.5)) +
  labs(title = "Sex Distribution", x = "", y = "") +
  theme_void()


#PIE CHART FOR DIAGNOSIS
library(ggplot2)
library(dplyr)

df %>%
  count(Diagnosis) %>%
  ggplot(aes(x = "", y = n, fill = Diagnosis)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(n / sum(n) * 100, 1), "%")),
            position = position_stack(vjust = 0.5)) +
  labs(title = "Diagnosis Distribution", x = "", y = "") +
  theme_void()


#BAR CHART - SESSION COUNT
library(ggplot2)

ggplot(df, aes(x = Session, fill = Session)) +
  geom_bar() +
  scale_fill_viridis_d() +
  labs(title = "Session Count Distribution", x = "Session", y = "Count") +
  theme_minimal()


#EEG CHANNEL DISTRIBUTIONS
library(ggplot2)

# EEG Channel 1
ggplot(df, aes(x = EEG_Ch1)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", linewidth = 1) +
  labs(title = "EEG Channel 1 Distribution", x = "EEG_Ch1", y = "Density") +
  theme_minimal()

# EEG Channel 2
ggplot(df, aes(x = EEG_Ch2)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", linewidth = 1) +
  labs(title = "EEG Channel 2 Distribution", x = "EEG_Ch2", y = "Density") +
  theme_minimal()







