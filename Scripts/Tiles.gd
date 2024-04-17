class_name OurTileMap
extends Node2D

@export var tile_prefab : PackedScene
@export var tile_graphics_pixelSize : int = 32 #This is hacky, find the sprite scale dynamically.
@export var max_width_viewport : int = 3
@export var max_height_viewport : int = 5

var tileGrid: Array[StaticBody2D] = []
var numTilesX: int = 0
var numTilesY: int = 0
var start_x: float = 0.0
var start_y: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	createTileMap()

func createTileMap():
	var w : int = max_width_viewport * get_viewport().size.x
	var h : int = max_height_viewport * get_viewport().size.y
	numTilesX = w / tile_graphics_pixelSize + 150
	numTilesY =  h / tile_graphics_pixelSize + 150
	
	start_x = (-(numTilesX / 2) + 0.5) * tile_graphics_pixelSize
	start_y = 0
	
	print(numTilesX, " ", numTilesY, " ", start_x, " ", start_y)
	createLevel(numTilesX, numTilesY, start_x, start_y)
	
# returns (-1, -1) if invalid index
func getTileIndexesGlobal(globalX: float, globalY: float) -> Vector2i:
	var half_tile_size = tile_graphics_pixelSize / 2
	var x = floori((globalX - (start_x - half_tile_size)) / tile_graphics_pixelSize)
	var y = floori((globalY - (start_y - half_tile_size)) / tile_graphics_pixelSize)
	
	if (x < 0 or x > numTilesX or y < 0 or y > numTilesX):
		return Vector2i(-1, -1)
		
	return Vector2i(x, y)

func getTile(x: int, y: int) -> StaticBody2D:
	if (x >= numTilesX or x < 0 or y >= numTilesY or y < 0):
		print("Tried to get invalid grid coordinate at (%d, %d)" % [x, y])
		return null
	return tileGrid[y * numTilesX + x]

# Create a level with tile prefabs.
func createLevel(x, y, start_x, start_y):
	tileGrid = []
	for i in y:
		for j in x:
			var tile = tile_prefab.instantiate() as StaticBody2D
			tile.position.x = start_x + tile_graphics_pixelSize * j
			tile.position.y = start_y + tile_graphics_pixelSize * i
			tileGrid.append(tile)
			add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

