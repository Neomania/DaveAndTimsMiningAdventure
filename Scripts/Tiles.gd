extends Node2D

@export var tile_prefab : PackedScene
@export var tile_graphics_pixelSize : int = 32 #This is hacky, find the sprite scale dynamically.
@export var max_width_viewport : int = 3
@export var max_height_viewport : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	createTileMap()

func createTileMap():
	var w : int = max_width_viewport * get_viewport().size.x
	var h : int = max_height_viewport * get_viewport().size.y
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
			add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

