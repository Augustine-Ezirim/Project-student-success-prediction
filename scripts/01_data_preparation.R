# Purpose: Load data, create target variable (pass), basic cleaning,
#          and create analysis-ready objects for downstream scripts.

rm(list = ls())
suppressPackageStartupMessages({
  library(caret)})

set.seed(1)
DATA_PATH <- "data/raw/student-mat.csv"
df <- read.csv(DATA_PATH, sep = ";", stringsAsFactors = FALSE)

# ---------- Create Target ----------
# pass = 1 if G3 >= 10 else 0
df$pass <- ifelse(df$G3 >= 10, 1, 0)
df$pass <- factor(df$pass, levels = c(0, 1))  # keep consistent ordering

# ---------- Basic Cleaning / Type Fixes ----------
char_cols <- sapply(df, is.character)
df[char_cols] <- lapply(df[char_cols], as.factor)

# Ensure key categorical variables are factors if present
cat_vars <- intersect(c("famsup", "schoolsup", "sex", "address", "Pstatus",
                        "guardian", "Mjob", "Fjob", "reason", "romantic"),
                      names(df))
for (v in cat_vars) df[[v]] <- as.factor(df[[v]])

# ---------- Create tree_data ----------
# Decision tree will use everything except G3 (to avoid leakage).
tree_data <- df
if ("G3" %in% names(tree_data)) tree_data$G3 <- NULL

# ---------- Create df_pca ----------
# PCA: numeric columns only (excluding target + final grade if still present)
df_pca <- df[sapply(df, is.numeric)]
df_pca$pass <- NULL
if ("G3" %in% names(df_pca)) df_pca$G3 <- NULL

# ---------- Create train/test split indices (shared across scripts) ----------
train_idx <- createDataPartition(df$pass, p = 0.7, list = FALSE)

# ---------- Save objects for other scripts ----------
dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
save(df, tree_data, df_pca, train_idx, file = "outputs/analysis_objects.RData")

cat("Saved: outputs/analysis_objects.RData\n")
cat("Rows:", nrow(df), " | Columns:", ncol(df), "\n")
cat("Pass rate:", mean(as.numeric(as.character(df$pass))), "\n")
