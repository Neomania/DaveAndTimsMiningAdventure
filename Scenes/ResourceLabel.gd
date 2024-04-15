extends Label

func _process(delta):
	if $/root/Node2D/Resources != null: 
		set_text("Resources: %d" % $/root/Node2D/Resources.resourceAmount)
