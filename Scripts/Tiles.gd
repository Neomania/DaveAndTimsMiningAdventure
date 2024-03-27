extends Node2D

@export var tile_prefab : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	createLevel() # Replace with function body.


# Create a level with 200 tile prefabs
func createLevel():
	var startPosition = self.position
	for i in 10:
		for j in 20:
			var prefab = tile_prefab.instantiate()
			var texAssetSize = Vector2(32,32)			
			prefab.position.x = startPosition.x + prefab.scale.x * texAssetSize.x * j
			prefab.position.y = startPosition.y + prefab.scale.y * texAssetSize.y * i
			add_child(prefab)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
