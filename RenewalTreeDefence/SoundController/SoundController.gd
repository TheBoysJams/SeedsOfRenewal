extends Node

var bgmusic = load("res://Assets/Music/SeedsOfRenewal.mp3")
@export var audio_bus_name = "Music"

func _ready():
	play_music()
	
func play_music():
	$BackgroundMusic.stream = bgmusic
	$BackgroundMusic.bus = audio_bus_name
	$BackgroundMusic.play()

		
