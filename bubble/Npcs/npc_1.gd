extends CharacterBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
#@onready var speech_sound = preload("")

# use for interactive npc
const lines: Array[String] = [
	"Can you help me to make a amethyst bubble",
]

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
