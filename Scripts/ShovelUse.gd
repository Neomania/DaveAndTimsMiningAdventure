extends Area2D

signal area_entered_tool_use(area, tool_use)
var timeToDelSecs = 0.2
var timeAlive = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timeAlive > timeToDelSecs:
		self.queue_free()
	timeAlive += delta


func _on_body_entered(body):
	if body.is_in_group("Tile"):
		area_entered_tool_use.emit(body, self)
