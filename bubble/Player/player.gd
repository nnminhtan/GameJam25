extends CharacterBody2D

@export var inv: Inv

# movement var
const speed = 100.0
const dash_speed = 200.0
const dash_time = 0.2
var current_dir = "none"
var is_dashing = false
var dash_timer = 0.0

func _physics_process(delta):
	player_movement(delta)
	move_and_slide()
				

func player_movement(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed
		current_dir = get_direction_name(direction)
		if not is_dashing:
			play_animation(1)
	else:
		if not is_dashing:
			play_animation(0)
		velocity = Vector2.ZERO
		
	move_and_slide()

func play_animation(movement):
	var anim = $AnimatedSprite2D
	var animation_name = ""

	match movement:
		0:  # Idle
			animation_name = "idle"
		1:  # Walking
			animation_name = "run"
		
	match current_dir:
		"right":
			anim.flip_h = false
		"left":
			anim.flip_h = true
		"down":
			anim.flip_h = false
		"up":
			anim.flip_h = false

	anim.play(animation_name)

func get_direction_name(direction):
	if direction.x > 0:
		return "right"
	elif direction.x < 0:
		return "left"
	elif direction.y > 0:
		return "down"
	elif direction.y < 0:
		return "up"
	return "none"


func collect(item):
	inv.Insert(item)
