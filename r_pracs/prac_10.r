# ==============================================================================
# R PRACTICAL 10: CREATING DERIVED VARIABLES (CONDITIONAL LOGIC)
# Subject: Data Mining with R (Master's Level)
# ==============================================================================

# 1. Load the necessary package
# The mutate() and case_when() functions are part of dplyr.
library(dplyr)

# 2. Create a sample data frame representing credit or loan scores
data_scores <- data.frame(
  CustomerID = 101:110,
  Score = c(750, 420, 610, 805, 500, 700, 399, 680, 550, 790),
  Default_Status = c("No", "Yes", "No", "No", "Yes", "No", "Yes", "No", "Yes", "No")
)

cat("\n--- 1. INITIAL DATA FRAME ---\n")
print(data_scores)
cat("-----------------------------\n")


# 3. Create the Derived Variable using mutate() and case_when()

# The mutate() function adds a new column (or modifies an existing one).
# The case_when() function evaluates a sequence of conditions (LHS) and
# returns the corresponding result (RHS) for the first condition that is TRUE.
data_with_risk <- data_scores |>
  mutate(
    # Create the new column named 'Risk_Level'
    Risk_Level = case_when(
      # Condition 1: Score >= 700 -> 'Low Risk'
      Score >= 700 ~ "Low Risk",
      
      # Condition 2: Score >= 500 AND Score < 700 -> 'Medium Risk'
      # Note: We only need to check Score >= 500 because if the first condition was TRUE, 
      # the row would already have been assigned "Low Risk".
      Score >= 500 ~ "Medium Risk",
      
      # Condition 3 (The Catch-All): Any other case (Score < 500) -> 'High Risk'
      # TRUE ~ "Value" is a common way to set the default value if none of the above are met.
      TRUE ~ "High Risk"
    )
  )

# 4. Display the result
cat("\n--- 2. DATA FRAME WITH DERIVED VARIABLE (Risk_Level) ---\n")
print(data_with_risk)

cat("\nSummary of Risk Levels:\n")
print(table(data_with_risk$Risk_Level))
cat("----------------------------------------------------------\n")

# Optional: Demonstrating a simple binary derivation using if_else()
data_with_risk <- data_with_risk |>
  mutate(
    Is_Prime_Customer = if_else(Score >= 750, "Yes", "No")
  )
cat("\n--- 3. DATA FRAME WITH BINARY DERIVATION (Is_Prime_Customer) ---\n")
print(data_with_risk)