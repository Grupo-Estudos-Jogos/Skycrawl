extends CharacterBody2D

const SPEED = 100.0

@onready var target:Player = $"../Player"
@export var grenade: PackedScene

var grenade_cooldown = 0;
@export var grenade_cooldown_size:float = 1
@export var grenade_cooldown_speed:float = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := (target.position - position).normalized() 
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = target.velocity.y
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if abs(velocity.y) > abs(velocity.x):
		$AnimatedSprite2D.animation = "up"
	else:
		$AnimatedSprite2D.animation = "run"
	
	if abs(target.position.x - position.x) < 0.5:
		if grenade_cooldown <= 0:
			grenade_cooldown = grenade_cooldown_size
			throw_grenade(delta)
	
	if grenade_cooldown > 0:
		#print(grenade_cooldown)
		grenade_cooldown -= delta * grenade_cooldown_speed

	if velocity.x > 0 and $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0 and not $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = true
		
	move_and_slide()

func throw_grenade(delta):
	var _grenade = grenade.instantiate()
	_grenade.global_position.y = global_position.y
	_grenade.global_position.x = global_position.x
	get_tree().root.add_child(_grenade)
