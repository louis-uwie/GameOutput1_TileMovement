extends CharacterBody2D

var tile_size = 32

var last_direction = ""
var is_teleporting = false
var tp_here = Vector2(816,400)
var animate = false
const animation_speed = 8

@onready var animation = $AnimatedSprite2D
@onready var ray = $RayCast2D

func _ready():
	animation.play("idle_down")
	
func _process(event):
	if animate or is_teleporting:
		return
		
	if Input.is_action_pressed("ui_up"):
		move(Vector2.UP, "up")
	elif Input.is_action_pressed("ui_down"):
		move(Vector2.DOWN, "down")
	elif Input.is_action_pressed("ui_right"):
		move(Vector2.RIGHT, "right")
	elif Input.is_action_pressed("ui_left"):
		move(Vector2.LEFT, "left")
	else:
		animation.play("idle_"+last_direction)

func move(dir, string_dir):	
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		animation.play(string_dir)
		last_direction = string_dir
			
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		animate = true
		await tween.finished
		animate = false
	else:
		animation.play("idle_"+string_dir)
	


func _on_area_2d_body_entered(body):
	print("entered")
	is_teleporting = true
	animation.play("tp")
	await get_tree().create_timer(3).timeout
	animation.play("idle_up")
	is_teleporting = false
	set_position(tp_here)
	pass # Replace with function body.
