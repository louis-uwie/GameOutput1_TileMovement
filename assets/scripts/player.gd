extends Node2D

var player_speed = 200
var player_velocity = Vector2()
var goal_position = Vector2()

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

		print(new_position)
		print(goal_position)
		
		var distance = sqrt((new_position.x - goal_position.x)**2 + (new_position.y - goal_position.y)**2)
		
		if distance <= 16:
			player_velocity = Vector2()
			set_position(goal_position)
			is_moving = false
		
		print("we're okay")
	else:
		if Input.is_action_pressed("ui_right"):
			animation.play("right")
			player_velocity.x += 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			
		elif Input.is_action_pressed("ui_left"):
			animation.play("left")
			player_velocity.x -= 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			
		elif Input.is_action_pressed("ui_down"):
			animation.play("down")
			player_velocity.y += 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			
		elif Input.is_action_pressed("ui_up"):
			animation.play("up")
			player_velocity.y -= 1
			goal_position = get_position() + player_velocity * 32
			is_moving = true
			
		else:
			animation.play("idle")
		
