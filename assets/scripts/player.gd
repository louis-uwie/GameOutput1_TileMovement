extends CharacterBody2D

var tile_size = 32
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

var last_direction = ""
var is_teleporting = false
var tp_here = Vector2(816,400)
var is_moving = false
var animate = false
const animation_speed = 8

@onready var animation = $AnimatedSprite2D
@onready var ray = $RayCast2D

func _ready():
	animation.play("idle_down")
	
func _physics_process(delta):
	if animate:
		return
	
	if !is_moving and !is_teleporting:
		if last_direction == "up":
			animation.play("idle_up")
		elif last_direction == "down":
			animation.play("idle_down")
		elif last_direction == "left":
			animation.play("idle_left")
		elif last_direction == "right":
			animation.play("idle_right")
			
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) and !is_teleporting:
			is_moving = true
			move(dir)
		else:
			is_moving = false

func move(dir):
	if dir == "ui_up":
		animation.play("up")
		last_direction = "up"
	elif dir == "ui_down":
		animation.play("down")
		last_direction = "down"
	elif dir == "ui_left":
		animation.play("left")
		last_direction = "left"
	elif dir == "ui_right":
		animation.play("right")
		last_direction = "right"
	
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		animate = true
		await tween.finished
		animate = false

func _on_area_2d_body_entered(body):
	print("entered")
	is_teleporting = true
	animation.play("tp")
	await get_tree().create_timer(3).timeout
	is_teleporting = false
	animation.play("idle_up")
	set_position(tp_here)
	pass # Replace with function body.

func _on_area_2d_2_body_entered(body):
	print("slipped")
	move(Vector2.DOWN)
	pass # Replace with function body.
