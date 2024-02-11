extends Node2D

var player_speed = 200
var player_velocity = Vector2()

var goal_position = Vector2()
var last_direction = ""
var tp_here = Vector2(816,416)

var is_moving = false
@onready var animation = $AnimatedSprite2D


func _ready():
	animation.play("idle")
	player_velocity = Vector2()

func _process(delta):

	if is_moving:
		# Normalize diagonal movement
		player_velocity = player_velocity.normalized()
		
		# Update player position based on input and speed
		var new_position = get_position() + player_velocity * player_speed * delta
		set_position(new_position)

		var distance = sqrt((new_position.x - goal_position.x)**2 + (new_position.y - goal_position.y)**2)
		
		if distance <= 16:
			player_velocity = Vector2()
			set_position(goal_position)
			is_moving = false

	else:
		if Input.is_action_pressed("ui_right"):
			animation.play("right")
			player_velocity.x += 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			last_direction = "right"

		elif Input.is_action_pressed("ui_left"):
			animation.play("left")
			player_velocity.x -= 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			last_direction = "left"

		elif Input.is_action_pressed("ui_down"):
			animation.play("down")
			player_velocity.y += 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			last_direction = "down"
			
		elif Input.is_action_pressed("ui_up"):
			animation.play("up")
			player_velocity.y -= 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			last_direction = "up"
			
		else:
			if last_direction == "right":
				animation.play("idle_right")
			elif last_direction == "left":
				animation.play("idle_left")
			elif last_direction == "up":
				animation.play("idle_up")
			elif last_direction == "down":
				animation.play("idle_wdown")


func _on_area_2d_body_entered(body):
	print("entered")
	set_position(tp_here)
	is_moving = false
	pass # Replace with function body.


func _on_north_wall_body_entered(body):
	print("entered")
	player_velocity = Vector2()
	is_moving = false
	pass # Replace with function body.
