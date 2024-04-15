extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Tile has been hit, slowly degrade it
	if $Sprite2D.modulate.a < 1.0:
		$Sprite2D.modulate.a -= delta * 2.0
	if $Sprite2D.modulate.a <= 0.0:
		self.queue_free()
