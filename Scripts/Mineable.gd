extends RigidBody2D

@export var resourceValue: float = 10.0
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

func _ready():
	$Label.set_text("%d" % resourceValue)


func _on_body_entered(body):
	if (stuckInRock == false and body.is_in_group("Tile")):
		resourceValue *= 0.9
		$Label.set_text("%d" % resourceValue)
		$/root/Node2D/BonkSound.play()
	pass # Replace with function body.
