extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var ray = $RayCast2D
const tile_size = 32
const animation_speed = 8
var direction = Vector2.RIGHT
var animating = false
var idle_face = ["idle_up", "idle_down"]

func _ready():
	animations.play("right")

func _animate(dir):
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding() and !animating:
		if dir == Vector2.LEFT:
			animations.play("left")
		else:
			animations.play("right")
		
		var tween = create_tween()
		tween.tween_property(self, "position", position + dir * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		animating = true
		await tween.finished
		animating = false
		
	elif ray.is_colliding() and !animating:
		if dir == Vector2.LEFT:
			animations.play("idle_left")
		else:
			animations.play("idle_right")
	
func _physics_process(delta):
	if position.x <= 240 and !animating:
		animations.play(idle_face[randi_range (0, 1)])
		animating = true
		await get_tree().create_timer(3).timeout
		animating = false
		direction = Vector2.RIGHT
		
	elif position.x >= 336 and !animating:
		animations.play(idle_face[randi_range (0, 1)])
		animating = true
		await get_tree().create_timer(3).timeout
		animating = false
		direction = Vector2.LEFT
	
	_animate(direction)
