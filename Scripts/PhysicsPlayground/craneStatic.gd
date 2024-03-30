extends StaticBody2D

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-200 * delta, 0))
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(200 * delta, 0))
