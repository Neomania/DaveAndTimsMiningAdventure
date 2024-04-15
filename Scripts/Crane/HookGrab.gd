extends RigidBody2D

var joint: PinJoint2D = null

func clearJoint():
	print(joint.node_b)
	if (get_node(joint.node_b).tree_exiting.is_connected(clearJoint)):
		get_node(joint.node_b).tree_exiting.disconnect(clearJoint)
	joint.queue_free()
	joint = null

func _physics_process(delta):
	if (Input.is_action_just_pressed("game_pickup")):
		if (joint == null):
			var raycast: RayCast2D = $RayCast2D
			if (raycast.is_colliding() and raycast.get_collider() is RigidBody2D):
				var target: RigidBody2D = raycast.get_collider()
				var newJoint: PinJoint2D = PinJoint2D.new()
				
				newJoint.set_global_position(raycast.get_collision_point())
				newJoint.set_exclude_nodes_from_collision(false)
				$/root.add_child(newJoint)
				newJoint.set_node_a(get_path())
				newJoint.set_node_b(target.get_path())
				
				joint = newJoint
				target.tree_exiting.connect(clearJoint)
		else:
			joint
			clearJoint()
			
	
