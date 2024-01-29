extends Node2D


var player_x_pos
var player_speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	player_x_pos = get_position().x
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	get_transform()
	set_position(Vector2(player_x_pos,55))

	player_x_pos = player_x_pos + ( player_speed * delta )
	
	pass
