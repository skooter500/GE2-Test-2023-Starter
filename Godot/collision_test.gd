extends Node

func _ready():
	pass # Replace with function body.	


func _on_I_AM_AREA_body_exited(body):
	print("A Body Exited Me: " + body.name)	
	pass # Replace with function body.


func _on_I_AM_AREA_body_entered(body):
	print("A Body Entered Me: " + body.name)		
	pass # Replace with function body.
