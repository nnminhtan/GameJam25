extends TextureRect

#@export var modulation: Color = Color(1, 1, 0.5, 1)
#@export var item_type: String = "item1"  # Add this to identify different items
#@export var initial_count: int = 5  # Add initial count as an export variable

@onready var count_label = $Label  # Reference to the Label node
var item_count: int

#@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
#@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update_label()
	
#func _ready():
	#inv.update.connect(update_slots)
	#update_slots()
#
#func update_slots():
	#for i in range(min(inv.slots.size(), slots.size())):
		#slots[i].update(inv.slots[i])

func update_label():
	if item_count <= 0:
		# If count is 0 or less, hide the TextureRect
		visible = false
	else:
		# Update label and ensure TextureRect is visible
		visible = true
		if count_label:
			count_label.text = str(item_count)


func _get_drag_data(_position):
	var icon = TextureRect.new()
	var preview = Control.new()
	
	icon.texture = self.texture
	icon.position = icon.texture.get_size() * -0.5 if icon.texture else Vector2.ZERO
	
	preview.add_child(icon)
	preview.z_index = 60
	set_drag_preview(preview)
	
	# Decrease the count when drag starts
	item_count -= 1
	update_label()
	
	return {
		"item_id": "godot_icon",
		#"modulation": modulation,
		#"item_type": item_type  # Include the item type in the drag data
	}
