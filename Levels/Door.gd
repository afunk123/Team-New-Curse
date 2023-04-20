extends Area2D

func _on_Door_body_entered(body):
	if body.name == "Player":
		if name == "Door_2_to_1":
			Global.room = 1
			Global.spawn_position = Vector2(860,160)
		if name == "Door_1_to_2":
			Global.room = 2
			Global.spawn_position = Vector2(550,170)
		if name == "Door_2_to_3":
			Global.room = 3
			Global.spawn_position = Vector2(240,560)
		if name == "Door_3_to_2":
			Global.room = 2
			Global.spawn_position = Vector2(260,820)
		if name == "Door_3_to_4":
			Global.room = 4
			Global.spawn_position = Vector2(280,310)
		if name == "Door_4_to_3":
			Global.room = 3
			Global.spawn_position = Vector2(1350,280)
		if name == "Door_4_to_5":
			Global.room = 5
			Global.spawn_position = Vector2(480,170)
		if name == "Door_5_to_4":
			Global.room = 4
			Global.spawn_position = Vector2(860,530)
		if name == "Door_5_to_6":
			Global.room = 6
			Global.spawn_position = Vector2(300,550)
		if name == "Door_6_to_5":
			Global.room = 5
			Global.spawn_position = Vector2(230,680)
		if name == "Door_6_to_7":
			Global.room = 7
			Global.spawn_position = Vector2(240,560)
		if name == "Door_7_to_6":
			Global.room = 6
			Global.spawn_position = Vector2(1370,300)
		if name == "Door_7_to_end":
			Global.room = 8
			Global.spawn_position = Vector2(100,100)
		if Global.room < Global.rooms.size():
			var _scene = get_tree().change_scene(Global.rooms[Global.room])
		else:
			get_tree().quit()
