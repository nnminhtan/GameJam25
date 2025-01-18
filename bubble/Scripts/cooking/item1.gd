extends TextureRect

@export var modulation: Color = Color(1, 1, 0.5, 1)
@export var item_type: String = "item1"  # Add this to identify different items

func set_modulation(value: Color):
	modulation = value
	modulate = value

func _get_drag_data(_position):
	var icon = TextureRect.new()
	var preview = Control.new()
	
	icon.texture = self.texture
	icon.position = icon.texture.get_size() * -0.5 if icon.texture else Vector2.ZERO
	icon.modulate = modulation
	
	preview.add_child(icon)
	preview.z_index = 60
	set_drag_preview(preview)
	
	return {
		"item_id": "godot_icon",
		"modulation": modulation,
		"item_type": item_type  # Include the item type in the drag data
	}
