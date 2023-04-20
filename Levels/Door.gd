extends Area2D

func _on_Door_body_entered(body):
	if body.name == "Player":
		if name == "Door_2_to_1":
			Global.room = 1
			Global.spawn_position = Vector2(100,100)
		if name == "Door_1_to_2":
			Global.room = 2
			Global.spawn_position = Vector2(200,100)
		if name == "Door_2_to_3":
			Global.room = 3
			Global.spawn_position = Vector2(200,400)
		if name == "Door_3_to_2":
			Global.room = 2
			Global.spawn_position = Vector2(700,150)
		if name == "Door_3_to_4":
			Global.room = 4
			Global.spawn_position = Vector2(100,150)
		if name == "Door_4_to_5":
			Global.room = 5
			Global.spawn_position = Vector2(200,150)
		if Global.room < Global.rooms.size():
			var _scene = get_tree().change_scene(Global.rooms[Global.room])
		else:
			get_tree().quit()
