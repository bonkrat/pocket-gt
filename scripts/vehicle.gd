extends VehicleBody

const STEER_SPEED = 10


var steer_target = 0

export var engine_force_value = 40

func _physics_process(delta):
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	
	var steer_limit = 0.4

	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= steer_limit

	if Input.is_action_pressed("accelerate"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		var speed = linear_velocity.length()
		
		if speed < 5 and speed != 0:
				engine_force = clamp(engine_force_value * 20 / speed, 0, 100)
		else:
			engine_force = engine_force_value
			if Input.is_action_pressed("handbrake"):
				engine_force = engine_force_value + 40
	else:
		engine_force = 0

	if Input.is_action_pressed("reverse"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			var speed = linear_velocity.length()
			if speed < 5 and speed != 0:
				engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)
			else:
				engine_force = -engine_force_value
				
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
