extends Node2D

var player_speed = 200
var player_velocity = Vector2()
@onready var animation = $AnimatedSprite2D

func _ready():
	animation.play("idle")
	pass

func _process(delta):
	player_velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		animation.play("right")
		player_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		animation.play("left")
		player_velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		animation.play("down")
		player_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		animation.play("up")
		player_velocity.y -= 1

	# Normalize diagonal movement
	player_velocity = player_velocity.normalized()

	# Update player position based on input and speed
	var new_position = get_position() + player_velocity * player_speed * delta
	set_position(new_position)
