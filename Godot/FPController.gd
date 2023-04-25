extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var sensitivity = 0.1
export var speed:float = 1.0

var controlling = true
var podattachment
var playerrotation
var time = 200
func _input(event):
	
	podattachment = $Tween
	playerrotation = $Tween2
	
	if event is InputEventMouseMotion and controlling:
		rotate(Vector3.DOWN, deg2rad(event.relative.x * sensitivity))
		rotate(transform.basis.x,deg2rad(- event.relative.y * sensitivity))
	if event.is_action_pressed("ui_cancel"):
		if controlling:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:			
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		controlling = ! controlling


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

export var move:bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if move:
		var mult = 1
		if Input.is_key_pressed(KEY_SHIFT):
			mult = 3
		var turn = Input.get_axis("turn_left", "turn_right")	
		if abs(turn) > 0:     
			global_translate(global_transform.basis.x * speed * turn * mult * delta)
		
		var move = Input.get_axis("move_forward", "move_back")
		if abs(move) > 0:     
			global_translate(global_transform.basis.z * speed * move * mult * delta)
		
		var upanddown = Input.get_axis("move_up", "move_down")
		if abs(upanddown) > 0:     
			global_translate(- global_transform.basis.y * speed * upanddown * mult * delta)
			
	else:
		$"../creature/boid/UserSteering".enabled = true
		$"../creature/boid/PathFollow".enabled = false
		podattachment.interpolate_property(self, "global_translation", global_translation, $"../creature/body3/Dodecahedron".global_translation, 0.025, Tween.TRANS_CIRC, Tween.EASE_IN)
		podattachment.start()
			
		
		playerrotation.interpolate_property(self, "global_rotation", global_rotation, $"../creature/boid".global_rotation, 0.1, Tween.TRANS_CIRC, Tween.EASE_IN)
		playerrotation.start()
		
		
		if(Input.is_action_just_released("release")):
			$"../creature/boid/UserSteering".enabled = false
			move = true
			time = 200

func _on_Dodecahedron_body_entered(body):
	if body == self:
		move = false
	
func _on_Dodecahedron_body_exited(body):
	pass # Replace with function body.
