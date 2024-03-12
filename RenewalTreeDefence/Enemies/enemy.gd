extends PathFollow3D

var direction:Vector3
var speed := 3
var damage := 5

func _process(delta: float) -> void:
	#position += direction * delta * speed
	progress += delta * speed
	if progress_ratio == 1.0:
		set_process(false)
		queue_free()
