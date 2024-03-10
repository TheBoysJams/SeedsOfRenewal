extends HSlider

@export var audio_bus_name = "Music"
var _bus: int

func _ready():
	_bus = AudioServer.get_bus_index(audio_bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))
	
func _on_value_changed(volume):
	AudioServer.set_bus_volume_db(_bus, linear_to_db(volume))
