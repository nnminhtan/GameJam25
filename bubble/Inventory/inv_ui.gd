extends Control

@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false 

func _ready():
	Global.global_slots = slots  # Store the slots in the global array
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		Global.global_slots[i] = slots[i]  # Store the slots in the global array
		print(Global.global_slots[i])


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
