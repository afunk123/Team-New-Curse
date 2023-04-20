extends Control


func _on_Try_Again_pressed():
	get_tree().change_scene("res://Levels/Room1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
