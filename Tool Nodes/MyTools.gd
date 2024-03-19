class_name MyTools

static func divide_by_ratios(count: int, ratios: Array):
	var array = []
	var summed_ratios = 0.0
	for ratio in ratios:
		summed_ratios += ratio
	var left_over = count
	for i in range(len(ratios)-1):
		var delegated =  ceil(left_over * float(ratios[i]) / summed_ratios)
		left_over -= delegated
		summed_ratios -= ratios[i]
		array.append(delegated)
	array.append(left_over)
	return array

static func generate_repeated_elements_array(elements: Array, element_counts: Array):
	var array = []
	for i in range(len(elements)):
		var temp_array = []
		temp_array.resize(element_counts[i])
		temp_array.fill(elements[i])
		array.append_array(temp_array)
	return array

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

