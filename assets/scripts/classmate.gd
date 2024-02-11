extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
const tile_size = 32
const animation_speed = 8
var direction = Vector2.DOWN

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	animations.play("down")

func _physics_process(delta):
	if position.y < 200:
		direction = Vector2.DOWN
		animations.play("down")
		
	elif position.y > 600:
		direction = Vector2.UP
		animations.play("up")
		
	var tween = create_tween()
	tween.tween_property(self, "position",
	position + direction * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	await tween.finished
	position += direction * tile_size
