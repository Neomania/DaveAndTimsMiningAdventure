extends Node2D

@export var tile_prefab : PackedScene
@export var tile_graphics_pixelSize : int = 32 #This is hacky, find the sprite scale dynamically.
@export var max_width_viewport : int = 3
@export var max_height_viewport : int = 5

var current_hover_tile

# Called when the node enters the scene tree for the first time.
func _ready():
	createTileMap()
	
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


func createTileMap():
	var w : int = randi_range(1, max_width_viewport) * get_viewport().size.x
	var h : int = randi_range(1, max_height_viewport) * get_viewport().size.y
	var numTilesX : int = w / tile_graphics_pixelSize
	var numTilesY : int =  h / tile_graphics_pixelSize
	var start_x : int = -(numTilesX / 2) * tile_graphics_pixelSize
	var start_y = 0
	print(numTilesX, " ", numTilesY, " ", start_x, " ", start_y)
	createLevel(numTilesX, numTilesY, start_x, start_y)
	
# Create a level with tile prefabs.
func createLevel(x, y, start_x, start_y):
	for i in y:
		for j in x:
			var tile = tile_prefab.instantiate() as StaticBody2D
			tile.position.x = start_x + tile_graphics_pixelSize * j
			tile.position.y = start_y + tile_graphics_pixelSize * i
			tile.connect("mouse_on_tile", call_mouse_on_tile) #dynamic connection to the mouse on tile event
			tile.connect("mouse_off_tile", call_mouse_off_tile) #dynamic connection to the mouse off tile event
			tile.connect("area_entered", call_area_entered)
			add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	# When mouse clicked, and it is hovering over a tile then use the selected tool on the tile / tile area.
	#if Input.is_action_just_pressed("ui_select"):
	#	createTileMap()

