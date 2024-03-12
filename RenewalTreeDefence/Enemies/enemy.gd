extends PathFollow3D

var speed := 3
var damage := 5

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		#TODO tell the player that we have damaged the spring/tree of life or whatever
		set_process(false)
		queue_free()
