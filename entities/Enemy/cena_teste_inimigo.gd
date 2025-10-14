extends CharacterBody2D 

const SPEED = 100.0 
var direction := 1
@onready var ray: RayCast2D = $RayCast2D 
@onready var todadano: Area2D = $Area2D

func _physics_process(delta: float) -> void: # Add the gravity. 
	if ray.is_colliding(): 
		direction *= -1 
		ray.scale.y *= -1 
	if direction: 
		velocity.y = direction * SPEED 
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED) 
		velocity = Vector2.ZERO 
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		queue_free()
