extends Node

@onready var button_click_sound = $ButtonClickSound
	
	
func play_click():
	button_click_sound.play()
