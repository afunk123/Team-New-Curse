extends Control



func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Room1.tscn")

func _on_Die_pressed():
	get_tree().quit()
