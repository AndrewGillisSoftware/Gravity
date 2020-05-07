extends Spatial

func _ready():
	$Sun.setInteractionRadius(1000000)
	$Sun.setFixed(true)
	$Sun.setMass(100000000)
	$Sun.setSkin("res://Assets/sun.jpg")
	
	get_tree().call_group("Planets", "setLightEmit", 0)
	get_tree().call_group("Planets", "applyForce", Vector3(5,0,0))
	
	$Earth.setSkin("res://Assets/earth.jpg")
	
	$Sun.setLightEmit(100)
