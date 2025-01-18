extends Panel

var dropped_items = []  # Array to track dropped items

func _can_drop_data(at_position, data):
	return data.item_id == "godot_icon"

func _drop_data(at_position, data):
	var component = TextureRect.new()
	component.texture = load("res://icon.svg")
	component.modulate = data.modulation
	component.position = at_position - (component.texture.get_size() * 0.5)
	
	# Add the item type to our tracking array
	dropped_items.append(data.item_type)
	
	# Check if we have exactly one of each required item
	var has_1item1 = dropped_items.count("item1") == 1
	var has_1item2 = dropped_items.count("item2") == 1
	var has_2item1 = dropped_items.count("item1") == 2
	var has_2item2 = dropped_items.count("item2") == 2

	# Check if we have the correct combination
	if has_1item1 and has_1item2:
		print("Liquid A")
		dropped_items.clear()  # Reset for next attempt
	if has_2item1 and has_2item2:
		print("Liquid B")
		dropped_items.clear()  # Reset for next attempt
	else:
		# Check if we have more than 2 items or wrong combination
		if dropped_items.size() >= 4:
			print("Failed")
			dropped_items.clear()  # Reset on failure
	
	#add_child(component)  # Add the visual component
