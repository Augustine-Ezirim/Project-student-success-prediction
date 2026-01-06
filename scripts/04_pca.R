rm(list = ls())

load("outputs/analysis_objects.RData")

# df_pca already numeric-only and excludes pass/G3 (created in script 01)
pr.out <- prcomp(df_pca, center = TRUE, scale. = TRUE)

pr.var <- pr.out$sdev^2
pve <- pr.var / sum(pr.var)

op <- par(mfrow = c(1,2))
plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained",
     ylim=c(0,1), type="b", main="Scree Plot")
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Variance Explained",
     ylim=c(0,1), type="b", main="Cumulative PVE")
par(op)

loadings <- pr.out$rotation

cat("\nTop variables for PC1:\n")
print(head(sort(abs(loadings[,1]), decreasing=TRUE), 10))

cat("\nTop variables for PC2:\n")
print(head(sort(abs(loadings[,2]), decreasing=TRUE), 10))

scores <- as.data.frame(pr.out$x)
plot(scores$PC1, scores$PC2, xlab="PC1", ylab="PC2", main="PCA Scores: PC1 vs PC2")
