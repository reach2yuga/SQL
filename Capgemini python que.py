data = [
    [1, 2, 3, 4, 6],     # List 1
    [2, 3, 4, 5, 7],     # List 2
    [5,6,7, 8, 10]        # List 3
]

# Initialize a list to store missing values for each sublist
missing_values = []

# Loop through each sublist
for sublist in data:
    min_value = min(sublist)  # Find the minimum value in the sublist
    max_value = max(sublist)  # Find the maximum value in the sublist
    
    # Create a set of expected values within the range
    expected_values = set(range(min_value, max_value + 1))
    
    # Create a set from the current sublist
    current_set = set(sublist)
    
    # Find missing values within the range
    missing_in_list = expected_values - current_set
    
    # Store the missing values for this sublist
    missing_values.append(sorted(missing_in_list))

# Print the results
print("Missing values within each list:", missing_values)
