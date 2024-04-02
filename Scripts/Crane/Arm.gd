extends StaticBody2D

@export var moveSpeed = 200

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-moveSpeed * delta, 0))
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(moveSpeed * delta, 0))

func _process(delta):
	queue_redraw()

func _ready():
	#initialize_hook()
	pass

func initialize_hook():
	var hookAnchor: Node2D = get_node("../Hook/CollisionPolygon2D/Hook Anchor")
	var armAnchor: Node2D = get_node("./CollisionShape2D/Arm Anchor")
	
	var joint = DampedSpringJoint2D.new()
	
	joint.set_global_position(armAnchor.global_position)
	joint.set_length((armAnchor.global_position - hookAnchor.global_position).length())
	#joint.set_global_rotation((armAnchor.global_position - armAnchor.global_position).angle() + 90.0)
	joint.set_rest_length(0)
	joint.set_damping(1.0)
	joint.set_stiffness(64.0)
	
	add_child(joint)
	
	joint.set_node_a("..")
	joint.set_node_b("../../Hook")
	
func _draw():
	var hookAnchor: Node2D = get_node("../Hook/CollisionPolygon2D/Hook Anchor")
	var armAnchor: Node2D = get_node("./CollisionShape2D/Arm Anchor")
	
	draw_line(armAnchor.global_position - global_position, hookAnchor.global_position - global_position, Color.BLACK)

