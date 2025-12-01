extends Area2D

var player = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player == true and Input.is_action_just_pressed('interagir'):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print('sumiu')
		player = true
