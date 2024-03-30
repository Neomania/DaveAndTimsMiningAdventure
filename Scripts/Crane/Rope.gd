extends DampedSpringJoint2D

@export var ropeSpeed = 200

func _physics_process(delta):
	if (Input.is_action_pressed("ui_down")):
		set_length(length + ropeSpeed * delta)
		set_rest_length(length)
	if (Input.is_action_pressed("ui_up")):
		set_length(max(length - ropeSpeed * delta, 0))
		set_rest_length(length)
