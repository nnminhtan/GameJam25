extends Node2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
#@onready var speech_sound = preload("")

# use for interactive npc
const lines: Array[String] = []

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	#print("interactive!")
	get_tree().change_scene_to_file("res://Scenes/cooking.tscn")
