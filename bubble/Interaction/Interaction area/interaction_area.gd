extends Area2D
class_name InteractionArea

@export var action_name : String = "interact"

# variable plan to use for item interact only
var is_interactive : bool = true 

var interact : Callable = func():
	pass

func _on_body_entered(body: Node2D) -> void:
	#print(is_interactive)
	if is_interactive:
		#print("enter")
		InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	

func disable_interaction():
	is_interactive = false
	InteractionManager.unregister_area(self)
