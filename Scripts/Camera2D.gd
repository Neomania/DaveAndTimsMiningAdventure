extends Camera2D
@export var cam_speed : float = 1000.0
@export var cam_zoom_speed : float = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_A)):
		position.x -= cam_speed * delta
		
	if(Input.is_key_pressed(KEY_D)):
		position.x += cam_speed * delta
		
	if(Input.is_key_pressed(KEY_W)):
		position.y -= cam_speed * delta
		
	if(Input.is_key_pressed(KEY_S)):
		position.y += cam_speed * delta
		
	if(Input.is_key_pressed(KEY_Q)):
		zoom.x += cam_zoom_speed * delta
	
	if(Input.is_key_pressed(KEY_E)):
		zoom.x -= cam_zoom_speed * delta
	
	if(Input.is_action_just_pressed("ui_select")):
		position.x = 0
		position.y = 0
		zoom.x = 1
		zoom.y = 1
	
	# add some clamps
	zoom.x = max(0.5, min(zoom.x, 2.0) )
	zoom.y = zoom.x

