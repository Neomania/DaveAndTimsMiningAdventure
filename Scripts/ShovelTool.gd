extends Node2D

@export var shovel_use : PackedScene
@export var tile_killer : PackedScene
var shovel_activated : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func call_area_entered(area, toolUse):
	var distance = toolUse.global_position - area.global_position
	var maxDistance = toolUse.get_node("CollisionShape2D").shape.radius
	var a = (distance.length() / maxDistance)
	if a < 1.0:
		area.get_node("Sprite2D").modulate.a -= 1.0 - a

class IndexToMine:
	var index: Vector2i
	var distance: float
	
	func _init(i, d):
		index = i
		distance = d
		
func lazyGetCircleIndices(center: Vector2i, radius: float) -> Array[IndexToMine]:
	var results: Array[IndexToMine] = []
	for x in range(center.x - radius, center.x + radius + 1):
		for y in range(center.y - radius, center.y + radius + 1):
			if ((x - center.x) ** 2 + (y - center.y) ** 2 < radius ** 2):
				var result = IndexToMine.new(Vector2i(x, y), 0.0)
				result.distance = (result.index - center).length() / radius
				results.append(result)
	
	return results
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("left_click") && shovel_activated:
		# spend resource
		if $/root/Node2D/Resources.resourceAmount > 5:
			$/root/Node2D/Resources.resourceAmount -= 5
			var mousePos = get_global_mouse_position()
			
			# get location of clicked point, check if there's a tile there; if so, dig around it
			var tiles : OurTileMap = $/root/Node2D/Tiles
			var index : Vector2i = tiles.getTileIndexesGlobal(mousePos.x, mousePos.y)
			
			if (index.x == -1):
				return
			
			var centerTile : StaticBody2D = tiles.getTile(index.x, index.y)
			
			if (centerTile != null):
				# tile is valid, iterate
				var indices = lazyGetCircleIndices(index, 3.5)
				
				for i in indices:
					var tile = tiles.getTile(i.index.x, i.index.y)
					if (tile != null):
						tile.add_child(tile_killer.instantiate())
						tile.get_node("Sprite2D").modulate.a = i.distance
					
			
