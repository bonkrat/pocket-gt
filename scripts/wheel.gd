extends VehicleWheel



export var drift_brake = 20
export var drift_wheel_slip = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("handbrake"):
		brake = drift_brake
		wheel_friction_slip = drift_wheel_slip
	else:
		wheel_friction_slip = 1
		brake = 0
