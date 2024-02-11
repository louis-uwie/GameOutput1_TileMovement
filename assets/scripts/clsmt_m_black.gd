extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var ray = $RayCast2D
const tile_size = 32
const animation_speed = 8
var direction = Vector2.DOWN
var animating = false

func _ready():
	position = position.snapped(Vector2.DOWN * tile_size)
	animations.play("down")

func _animate(dir):
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding() and !animating:
		if dir == Vector2.DOWN:
			animations.play("down")
		else:
			animations.play("up")
		
		var tween = create_tween()
		tween.tween_property(self, "position", position + dir * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		animating = true
		await tween.finished
		animating = false
	elif ray.is_colliding() and !animating:
		if dir == Vector2.DOWN:
			animations.play("idle_down")
		else:
			animations.play("idle_up")
	
func _physics_process(delta):
	if position.y < 176:
		direction = Vector2.DOWN
		
	elif position.y > 496:
		direction = Vector2.UP
	
	_animate(direction)
	
	
