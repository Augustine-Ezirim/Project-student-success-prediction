# Predicting Student Academic Success (Pass/Fail)
### Logistic Regression · Decision Trees · Principal Component Analysis (R)

This project analyzes and predicts whether a secondary school student will **pass or fail** based on academic performance, demographic background, and lifestyle behaviors. Using the UCI Student Performance dataset, multiple modeling approaches are compared to evaluate **predictive performance, interpretability, and underlying data structure**.

The goal is twofold:
1. Build accurate predictive models for student success  
2. Extract actionable insights that can inform early academic intervention

---

## Business / Research Question
**Can we accurately predict whether a student will pass (final grade ≥ 10) using available academic, demographic, and behavioral data — and which factors matter most?**

---

## Dataset
- **Source:** `Cortez, P. (2008). Student Performance [Dataset]. UCI Machine Learning Repository.
https://doi.org/10.24432/C5TG7T.
- **Observations:** 395 students
- **Features:** Academic history, family background, social behavior, alcohol consumption, study time, absences
- **Target Variable:**
  - `pass = 1` if final grade `G3 ≥ 10`
  - `pass = 0` otherwise

> The dataset represents Portuguese secondary school students and includes both numeric and categorical variables.


---

## Data Preparation
Key preprocessing steps included:
- Converting categorical variables to factors
- Creating a binary target variable (`pass`)
- Selecting relevant predictors based on academic theory and interpretability
- Scaling numeric variables for PCA
- Ensuring reproducibility using fixed random seeds

---

## Modeling Approaches

### 1. Logistic Regression (Primary Model)
Logistic regression was used as the primary predictive model due to its interpretability and strong performance on binary classification problems.

**Key predictors included:**
- Previous grades (`G1`, `G2`)
- Number of past failures
- Family support
- Social activity and alcohol consumption

**Why logistic regression?**
- Clear coefficient interpretation
- Strong baseline for classification
- Well-suited for educational outcome modeling

---

### 2. Decision Tree Classification
A classification tree was built to capture nonlinear relationships and variable interactions.

**Approach:**
- Gini index used for node splitting
- Model trained on a 70/30 train-test split
- Tree pruned using optimal complexity parameter (CP)

**Why a decision tree?**
- Highly interpretable decision rules
- Useful for understanding risk pathways
- Highlights dominant predictors such as prior failures

---

### 3. Principal Component Analysis (PCA)
PCA was applied to:
- Reduce dimensionality
- Identify latent structures in the data
- Separate academic performance from behavioral patterns

**Preprocessing:**
- Numeric variables only
- Centered and scaled before PCA

---

## Model Evaluation
Models were evaluated using:
- **Confusion Matrix**
- **Accuracy**
- **ROC Curve**
- **Area Under the Curve (AUC)**

---

## Results Summary

| Model              | Key Insight |
|-------------------|-------------|
| Logistic Regression | Best overall performance with high accuracy and AUC |
| Decision Tree      | Strong interpretability but weaker classification power |
| PCA                | Revealed academic vs behavioral dimensions |

### Key Findings
- **Second-period grade (`G2`)** is the strongest predictor of passing.
- Students with multiple past failures have significantly lower pass probabilities.
- Decision trees highlight clear academic risk thresholds but struggle with generalization.
- PCA separates **academic performance** from **lifestyle behaviors**, validating feature groupings.

---

## Practical Implications
- Early academic performance can reliably identify at-risk students.
- Interventions should focus on students showing early grade decline.
- Behavioral factors matter, but academic history dominates predictive power.

---

## Tools & Technologies
- **Language:** R
- **Libraries:**  
  - `caret`  
  - `pROC`  
  - `rpart`  
  - `rattle`  
  - `car`  
  - `RColorBrewer`  

---

## Limitations & Future Work

- Dataset limited to one country and education system
- Class imbalance may affect minority predictions
- Future work could include:
  - Random Forest / Gradient Boosting
  - Cross-validation
  - Time-series modeling of grade progression

## Authors

- Kim Lu
- Sherine Tumushemeze
- Gorkem Dural
- Augustine Ezirim

## License

This project is for academic and portfolio demonstration purposes.
