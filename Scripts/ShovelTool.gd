extends Node2D

@export var shovel_use : PackedScene
var shovel_activated : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("left_click") && shovel_activated:
		if  $"../Tiles".current_hover_tile != null: #hovering over a tile
			var shovel = shovel_use.instantiate()
			shovel.position = get_global_mouse_position()
			add_child(shovel)
