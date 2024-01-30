extends Node2D

var player_speed = 200
var player_velocity = Vector2()

func _ready():
	pass

func _process(delta):
	player_velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		player_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		player_velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		player_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		player_velocity.y -= 1

	# Normalize diagonal movement
	player_velocity = player_velocity.normalized()

	# Update player position based on input and speed
	var new_position = get_position() + player_velocity * player_speed * delta
	set_position(new_position)
