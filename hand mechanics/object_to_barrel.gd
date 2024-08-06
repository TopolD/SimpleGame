extends RigidBody2D

var picked = false 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Устанавливаем масштаб гравитации в 0, чтобы отключить её
	gravity_scale = 0

func _physics_process(delta):
	if picked:
		self.position = get_node("nodes/player/Marker2D").global_position

func _input(event):
	if Input.is_action_just_pressed("ui_pick"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == 'player' and get_node("nodes/player").canPick:
				picked = true
				get_node("nodes/player").canPick = false
				 
	if Input.is_action_just_pressed('ui_drop') and picked:
		picked = false
		get_node("nodes/player").canPick = true
		if get_node("nodes/player").sprite.flip_h == false:
			apply_impulse(Vector2(), Vector2(90, -10))
		else:
			apply_impulse(Vector2(), Vector2(-90, -10))
	
	if Input.is_action_just_pressed('ui_throw') and not picked:
		picked = false
		get_node("nodes/player").canPick = true
		if get_node("nodes/player").sprite.flip_h == false:
			apply_impulse(Vector2(), Vector2(150, -200))
		else:
			apply_impulse(Vector2(), Vector2(-150, -200))
