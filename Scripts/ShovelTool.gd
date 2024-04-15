extends Node2D

@export var shovel_use : PackedScene
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("left_click") && shovel_activated:
		# spend resource
		if $/root/Node2D/Resources.resourceAmount > 5:
			$/root/Node2D/Resources.resourceAmount -= 5
			var shovelUse = shovel_use.instantiate()
			shovelUse.position = get_global_mouse_position()
			shovelUse.connect("area_entered_tool_use", call_area_entered)
			add_child(shovelUse)
