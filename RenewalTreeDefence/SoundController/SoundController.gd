extends Node

@onready var background_music = $BackgroundMusic
@onready var button_click_sound = $ButtonClickSound



func _ready():
	background_music.finished.connect(on_background_music_finished)
	$BackgroundMusic/Timer.timeout.connect(on_background_music_timer_timeout)


func on_background_music_finished():
	$BackgroundMusic/Timer.start()


func on_background_music_timer_timeout():
	background_music.play()
	

func play_click():
	button_click_sound.play()
