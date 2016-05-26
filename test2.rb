#First Part:
# Checking whether the credit card is valid or not

def credit_card_valid?(number)
 return false unless number.length > 10
 digits_array = number.chars.map(&:to_i)
 check_digit = digits_array.pop
 check_digit_for(digits_array) == check_digit
end

# Getting the check digit for digit array supplied
def check_digit_for(digits_array)
 result = apply_luhn_algo(digits_array)
 (result.to_i * 9).to_s.chars.pop.to_i
end

# Core Logic for luhn algorithm
def apply_luhn_algo(digits_array)
 sum = 0
 digits_array.reverse.each_slice(2) do | first, last |
   num = first * 2
   if num > 9
     unit_place = num % 10
     tens_place = num / 10
     num = tens_place + unit_place
   end
   sum += num + ( last || 0 )
 end
 sum
end

# Next part of Task2:
# Calculating appending the check_digit to the number entered
def append_luhn_digit(number)
 digits_array = number.chars.map(&:to_i)
 check_digit = check_digit_for(digits_array)
 number + check_digit.to_s
end


