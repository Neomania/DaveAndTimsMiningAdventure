extends DampedSpringJoint2D

var theoreticalLength = length

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		theoreticalLength = max(theoreticalLength - 200 * delta, 0)
		set_length(theoreticalLength)
		set_rest_length(theoreticalLength)
	
	if Input.is_action_pressed("ui_down"):
		theoreticalLength += 200 * delta
	set_length(theoreticalLength)
	set_rest_length(theoreticalLength)
	
func _draw():
	print(get_node(node_a).global_position)
	draw_line(Vector2(0, 0) - global_position, Vector2(100, 200) - global_position, Color.RED, 20)
	draw_line(get_node(node_a).global_position - global_position, get_node(node_b).global_position - global_position, Color.RED, 5)

