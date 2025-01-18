extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button: Button = $Button

func _ready():
	audio_stream_player_2d.play()


func _on_button_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
