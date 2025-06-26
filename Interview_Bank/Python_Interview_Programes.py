1. Concatenate 2 list
list1 = [1, 2, 3]
list2 = [4, 5, 6]
# Concatenate
combined = list1 + list2
print(combined)

list1 = [1, 2, 3]
list2 = [4, 5, 6]

list1.extend(list2)  # modifies list1 in-place
print(list1)
------------------------------------------------------------------
2. 
input = (1,2,3,4,5)
 
output = (1,3,6,10,15) 
output []
total = 0

for i in input:
	total+ = i
	
output.append(total)

-------------------------------------------------------------------
3. factorial programe:

def factorial(n):
  if n ==0 or n==1
    return 1
 else:
    return n* factorial(n-1)

print(factorial(5)) //120
----------------------------------------------------------------------------
4.remove duplicates from a list in Python:
my_list = [1, 2, 2, 3, 4, 4, 5]
unique = []
for item in my_list:
    if item not in unique:
        unique.append(item)

print(unique)

----------------------------------------------------------------------------
5.  Find missing numbers in a sequence
# Given list
my_list = [1, 2, 4, 6, 7]

# Find missing numbers between min and max
full_range = set(range(min(my_list), max(my_list) + 1))
missing = list(full_range - set(my_list))

print(sorted(missing))

---------------------------------------------------------------------------------------
6.  Reverse string programe:
input_string = "Yugandhara"
reverse_string = input_string(::-1)
print(reverse_string)

input_string = "Yugandhara"

def reverse_string(s):
reversed_string = ""
for char in s:
	reversed_string = char + reversed_string
	return reversed_string
print(reversed_string


