# ==============================================================================
# R PRACTICAL 5: FACTORIAL CALCULATION USING WHILE LOOP
# Subject: Data Mining with R (Master's Level)
# ==============================================================================

# 1. Define the number for which the factorial is to be calculated
number <- 7 

# Initialize variables
factorial_result <- 1
i <- 1 # Counter variable for the loop

cat("\n--- FACTORIAL CALCULATION ---\n")
cat("Number (n):", number, "\n")


# 2. Check for edge cases (negative numbers and zero)
if (number < 0) {
  
  cat("Error: Factorial is not defined for negative numbers.\n")
  
} else if (number == 0) {
  
  # Factorial of 0 is 1 by mathematical definition.
  cat("The factorial of 0 is:", 1, "\n")
  
} else {
  
  # 3. Use the 'while' loop for positive numbers
  # The loop continues as long as the counter 'i' is less than or equal to the 'number'.
  while (i <= number) {
    
    # Update the factorial result: result = result * i
    # This multiplies the current result by the next integer in the sequence.
    factorial_result <- factorial_result * i
    
    # Increment the counter for the next iteration
    i <- i + 1
  }
  
  cat("The factorial of", number, "is:", factorial_result, "\n")
}

cat("-------------------------------\n")

# Expected Output for n=7: 5040