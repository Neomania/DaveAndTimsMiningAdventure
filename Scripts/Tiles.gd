extends Node2D

@export var tile_prefab : PackedScene
@export var tile_graphics_pixelSize : int = 32
var current_hover_tile

# Called when the node enters the scene tree for the first time.
func _ready():
	createLevel() # Replace with function body.

func call_mouse_on_tile(on_tile):
	current_hover_tile = on_tile

func call_mouse_off_tile(off_tile):
	if current_hover_tile == off_tile:
		current_hover_tile = null

func call_area_entered(area, tile):
	var distance = area.global_position - tile.global_position
	var maxDistance = area.get_node("CollisionShape2D").shape.radius
	var a = (distance.length() / maxDistance)
	if a < 1.0:
		tile.get_node("Sprite2D").modulate.a -= 1.0 - a
# Create a level with tile prefabs.
func createLevel():
	for i in 20:
		for j in 55:
			var tile = tile_prefab.instantiate() as StaticBody2D
			tile.position.x = tile_graphics_pixelSize * j
			tile.position.y = tile_graphics_pixelSize * i
			tile.connect("mouse_on_tile", call_mouse_on_tile) #dynamic connection to the mouse on tile event
			tile.connect("mouse_off_tile", call_mouse_off_tile) #dynamic connection to the mouse off tile event
			tile.connect("area_entered", call_area_entered)
			add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# When mouse clicked, and it is hovering over a tile then use the selected tool on the tile / tile area.
	pass

