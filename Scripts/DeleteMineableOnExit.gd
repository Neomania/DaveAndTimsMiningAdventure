extends Area2D



func _on_body_exited(body):
	if (body.is_in_group("Mineable")):
		$/root/Node2D/Resources.resourceAmount += body.resourceValue
		body.queue_free()
	pass # Replace with function body.
