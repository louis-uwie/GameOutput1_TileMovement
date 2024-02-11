extends Area2D

var player

const new_position = Vector2(816, 416)

func _ready():
	print(get_tree().get_nodes_in_group("player"))
	
	player = get_node("player")
	if player:
		print("Player node found:", player)
	else:
		print("Player node not found.")

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		body.set_position(new_position)
	else:
		print("Another body entered the area.")
