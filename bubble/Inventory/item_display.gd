extends TextureRect

@export var modulation: Color = Color(1, 1, 0.5, 1)
@export var item_type: String = "item1"
@export var initial_count: int = 5

@onready var count_label = $Label
var item_count: int

@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = Global.global_slots

var TempTexture

func _ready():
	slots = Global.global_slots  # Ensure synchronization at the start

	item_count = initial_count
	update_label()
	

func update_label():
	visible = item_count > 0
	if count_label:
		count_label.text = str(item_count)

func set_modulation(value: Color):
	modulation = value
	modulate = value

func check(slot: InvSlot, index):
	print("in check")
	if slot and is_instance_valid(slot):
		if slot.item and is_instance_valid(slot.item):
			if slot.item.texture == TempTexture:
				Global.global_slots[index].amount -= 1
				print("Reduced amount for index:", index)
			else:
				print("Textures do not match.")
		else:
			print("Invalid item in slot at index:", index)
	else:
		print("Invalid slot detected at index:", index)

func _get_drag_data(_position):
	print("Slots array after cleanup:", slots)
	print("Global Slots array after cleanup:", Global.global_slots)

	var icon = TextureRect.new()
	var preview = Control.new()
	TempTexture = self.texture

	if TempTexture:
		icon.texture = TempTexture
		icon.position = icon.texture.get_size() * -0.5
		icon.modulate = modulation

		preview.add_child(icon)
		preview.z_index = 60
		set_drag_preview(preview)

	for index in range(slots.size()):
		var slot = slots[index]
		print("Checking slot at index:", index, "Valid:", is_instance_valid(slot))
		if slot and is_instance_valid(slot):
			check(slot, index)

	return {
		"item_id": "godot_icon",
		"modulation": modulation,
		"item_type": item_type
	}
