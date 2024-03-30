extends CollisionShape2D

var length = 200

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		length = max(length - 20 * delta, 0)
	
	if Input.is_action_pressed("ui_down"):
		length += 20 * delta
		print(length)
	
	transform.get_scale().y = length / 200
