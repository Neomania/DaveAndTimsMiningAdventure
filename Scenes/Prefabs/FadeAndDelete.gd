extends Node2D

var sprite: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("../Sprite2D")
	if (sprite == null):
		print("FadeAndDelete did not have a sibling Sprite2D.")
		self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (sprite == null):
		return
	
	sprite.modulate.a -= delta * 2.0
		
	if sprite.modulate.a <= 0.0:
		get_parent().queue_free()
