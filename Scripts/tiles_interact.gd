extends TileMap

#Highlight the cell which the mouse cursor hovers over.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos_world = get_viewport().get_mouse_position()
	var local_pos = to_local(mouse_pos_world)
	var tile_pos = local_to_map(local_pos)
	print("tile pos ", tile_pos)
