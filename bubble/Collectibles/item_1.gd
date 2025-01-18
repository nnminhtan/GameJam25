extends Node2D

@onready var interaction_area: InteractionArea = $AnimatedSprite2D/InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var growth_timer: Timer = $growth_timer
@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/CollisionShape2D

var state = "harvested" # not harvested and harvested
var interaction_manager = null

func _ready() -> void:
	interaction_manager= get_node_or_null("/root/InteractionManager")
	if not interaction_manager:
		print("error: interactionmanager not found")
		return
	else:
		print("interactionmanager found")
	
	if state == "harvested":
		growth_timer.start()
		
	interaction_area.interact = Callable(self, "_on_interact")
	growth_timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_interact():
	sprite.hide()
	collision_shape_2d.disabled = true
	interaction_area.set_deferred("disabled", true)
	state = "harvested"
	print("+1 item 1")
	if interaction_manager:
		interaction_manager.unregister_area(interaction_area)
		
	interaction_area.is_interactive = false
	growth_timer.start()

func _on_timer_timeout():
	sprite.show()
	collision_shape_2d.disabled = false
	interaction_area.set_deferred("disabled", false)
	interaction_area.is_interactive = true
	state = "not harvested"
