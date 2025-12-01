extends Area2D

@onready var alavanca: AnimationPlayer = $AnimationPlayer
var player = false
signal alavancasinal
var ativada = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player == true and Input.is_action_just_pressed('interagir'):
		emit_signal('alavancasinal',ativada)
		alavanca.play('puxa')
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print('perto da alavanca')
		player = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		player = false # Replace with function body.
