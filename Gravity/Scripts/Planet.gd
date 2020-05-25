extends RigidBody

var mesh_instance_node
var force = Vector3(0,0,0)
const gScale = 0.5
const G = 0.000000000667*gScale
var bodies = Array()
var fixed = false

func _ready():
	setInteractionRadius(10000)
	mesh_instance_node = $Mesh
	mesh_instance_node.material_override = SpatialMaterial.new()
	pass

func setMass(m):
	$".".mass = m

func setFixed(b):
	fixed = b

func setInteractionRadius(r):
	var newShape = SphereShape.new()
	newShape.radius = r
	$Area/Affect_Collision.shape = newShape
	$Light.omni_range = r

func setSkin(texture_path):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(texture_path)
	texture.create_from_image(image)
	mesh_instance_node.material_override.albedo_texture = texture 

func setLightEmitColor(color:Color):
	mesh_instance_node.material_override.emission_enabled = true
	mesh_instance_node.material_override.emission = color

func setLightEmit(l:float):
	mesh_instance_node.material_override.emission_enabled = true
	mesh_instance_node.material_override.emission_energy = l
	$Light.light_energy = l*30000000

func applyForce(f):
	if(!fixed):
		force = f
	
func _integrate_forces(state):
	state.linear_velocity = force

func get_class():
	return "Planet"

func getDistance(p1:Vector3, p2:Vector3):
	return sqrt(pow(p1.x - p2.x,2)+pow(p1.y - p2.y,2)+pow(p1.z - p2.z,2))

func getUnitVectorToOther(p1:Vector3, p2:Vector3):
	return (p1-p2)/getDistance(p1,p2)

func getForce():
	return force	

func _physics_process(delta):
	for body in bodies:
		var distanceAdjusted = pow(getDistance(body.translation,self.translation),2)
		if(distanceAdjusted != 0):
			applyForce(G*(($".".mass * body.mass)/distanceAdjusted)*getUnitVectorToOther(body.translation,self.translation)+force)

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	if(body.get_class() == "Planet"):
		bodies.append(body)
		
func _on_Area_body_shape_exited(body_id, body, body_shape, area_shape):
	if(body.get_class() == "Planet"):
		bodies.remove(bodies.find(body))


func _on_Area2_body_shape_entered(body_id, body, body_shape, area_shape):
	if(body.get_class() == "Planet"):
		var newForce = body.force + force
		if(body.get_class() == "Planet"):
			if !fixed:
				force = newForce/2
