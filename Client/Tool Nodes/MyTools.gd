class_name MyTools

static func divide_by_ratios(count: int, ratios: Array):
	var array = []
	var summed_ratios = 0.0
	for ratio in ratios:
		summed_ratios += ratio
	var left_over = count
	for i in range(len(ratios)-1):
		var delegated =  ceil(left_over * ratios[i] / summed_ratios)
		left_over -= delegated
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
