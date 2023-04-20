extends Control


func _on_Contiue_pressed():
	var esc = InputEventKey.new()
	esc.scancode = 16777217
	esc.pressed = true
	Input.parse_input_event(esc)


func _on_Quit_pressed():
	get_tree().quit()
