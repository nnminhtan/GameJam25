extends CharacterBody2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
#@onready var speech_sound = preload("")

# use for interactive npc
const lines: Array[String] = [
	"Greetings player",
	"You are a retired wizard",
	"That makes colorful bubbles",
	"To bring happiness for everyone",
	"To make those",
	"You have to collect the herbs",
	"And brew them in the cauldron in front of shack",
	"For each herbs, it will have it own growth time to collect",
	"Some is easy to collect like in the garden at your right",
	"But it will have a decent amount of growth time",
	"So more further words",
	"Let's start making bubbles!!!"
]

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
