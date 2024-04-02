extends RigidBody2D

var stuckInRock: bool = true
var frozenFramesRemaining = 3

func _physics_process(delta):
	if (stuckInRock and get_colliding_bodies().all(func(body): return not (body is StaticBody2D))):
		frozenFramesRemaining -= 1
		if (frozenFramesRemaining <= 0):
			stuckInRock = false
			set_freeze_enabled(false)

func _on_body_exited(body):
	pass # Replace with function body.
