extends Area3D

var direction:Vector3
var speed := 3
var damage := 5

func _process(delta: float) -> void:
	position += direction * delta * speed
