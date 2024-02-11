extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var ray = $RayCast2D
const tile_size = 32
const animation_speed = 8
var direction = Vector2.RIGHT
var animating = false
var min_bounds = _generate_rand_mult32(1, 7)
var max_bounds = _generate_rand_mult32(9, 15)

func _ready():
	position = position.snapped(Vector2.RIGHT * tile_size)
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

func _generate_rand_mult32(max, min):
	var rand_num = randi_range(min, max) * 32
	return rand_num

func _physics_process(delta):
	if position.x < min_bounds:
		direction = Vector2.RIGHT
		min_bounds = _generate_rand_mult32(1, 7)
		
	elif position.x > max_bounds:
		direction = Vector2.LEFT
		max_bounds = _generate_rand_mult32(9, 15)
	
	_animate(direction)
	
