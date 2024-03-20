class_name MyTools

class Sorter:
	static func sort_ascending_comparator(a, b):
		return a[1] < b[1]

static func proportional_allocation(total_int: int, float_array: Array) -> Array:
	var total_float = 0.0
	var result = []
	
	# Calculate total float sum
	for f in float_array:
		total_float += f
	
	# Calculate proportional integers
	for f in float_array:
		result.append(int(total_int * (f / total_float)))
	
	# Adjust the result to match the total_int
	
	var sum_result = 0
	for res in result:
		sum_result += res
	
	var remainder = total_int - sum_result
	if remainder != 0:
		# Distribute the remainder to the elements with the highest fractional parts
		var fractional_parts = []
		for i in range(len(float_array)):
			fractional_parts.append((float_array[i] / total_float) - int(float_array[i] / total_float))
		var indices = []
		for i in range(len(fractional_parts)):
			indices.append([i, fractional_parts[i]])
			
		

			
		indices.sort_custom(Sorter, "sort_ascending_comparator")
		
		for i in indices:
			result[i[0]] += 1 if remainder > 0 else -1
			remainder -= 1 if remainder > 0 else -1
			if remainder == 0:
				break
	
	return result

static func generate_repeated_elements_array(elements: Array, element_counts: Array):
	var array = []
	for i in range(len(elements)):
		var temp_array = []
		temp_array.resize(element_counts[i])
		temp_array.fill(elements[i])
		array.append_array(temp_array)
	return array

static func print_percentage(value):
	return str(round(max(value*100,0)))+"%"

static func fact(num: int):
	var res = 1
	for i in range(2, num+1):
		res *= i
	return res

static func calculate_terminal_decode_chance(ports_left, time_per_port, time_left):
	var chance = 1.0
	var lambda = time_left / time_per_port
	for i in range(ports_left):
		chance -= pow(lambda, i) * exp(-lambda) / fact(i)
	return chance

static func calculate_win_chance(ports_per_terminal: Array, time_per_port, time_left, time_increment):
	var sorted = ports_per_terminal.duplicate()
	var chance = 1.0
	sorted.sort()
	
	var previous_ports = 0
	for i in range(len(ports_per_terminal)):
		var port_count = ports_per_terminal[i]+2
		chance *= calculate_terminal_decode_chance(port_count, time_per_port, time_left - previous_ports*time_per_port + time_increment*i)
		previous_ports += port_count
	return chance

static func generate_random_codes(number_of_codes: int, number_of_digits: int):
	if number_of_codes > pow(10, number_of_digits):
		return ERR_PARAMETER_RANGE_ERROR
	var array = []
	for i in range(number_of_codes):
		var random_code = str(randi() % int(pow(10,number_of_digits)))
		var missing = number_of_digits - len(random_code)
		for j in range(missing):
			random_code = "0" + random_code
		if not random_code in array:
			array.append(random_code)
		else:
			i-=1
	return array

