extends Spatial

func _ready():
	$Sun.setPlanetRadius(100.0)
	$Sun.setSkin("res://Assets/sun.jpg")
	$Sun.setLightEmitColor(Color(255, 0, 0))
	$Sun.setLightEmit(0.0000005)
	$Sun.setInteractionRadius(1000)
	
	$Earth.setPlanetRadius(10.0)
	$Earth.setSkin("res://Assets/earth.jpg")
	$Earth.setLightEmit(0)
	$Earth.setInteractionRadius(1000)
	pass
