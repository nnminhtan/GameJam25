extends Control

@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false 
#
@export var modulation: Color = Color(1, 1, 0.5, 1)
@export var item_type: String = "item1"  # Add this to identify different items
@export var initial_count: int = 5  # Add initial count as an export variable

#@onready var count_label = $Label  # Reference to the Label node
var item_count: int

func set_modulation(value: Color):
	modulation = value
	modulate = value

func _get_drag_data(_position):
	#print($)
	var icon = TextureRect.new()
	var preview = Control.new()
	
	icon.texture = self.texture
	icon.position = icon.texture.get_size() * -0.5 if icon.texture else Vector2.ZERO
	icon.modulate = modulation
	
	preview.add_child(icon)
	preview.z_index = 60
	set_drag_preview(preview)
	
	sad_slots()
	
	return {
		"item_id": "godot_icon",
		"modulation": modulation,
		"item_type": item_type  # Include the item type in the drag data
	}

func _ready():
	Global.global_slots = slots  # Store the slots in the global array
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		

func sad_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].sad(inv.slots[i])
		

func _process(float):
	if Input.is_action_just_pressed("Inventory"):
		print("pressing Ivn")
		if is_open:
			close()
		else:
			open()
				
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
