extends Node2D

onready var Guard = load('res://Enemies/Guard.tscn')
onready var Guard2 = load('res://Enemies/Guard2.tscn')
onready var Spider = load('res://Enemies/Spider.tscn')
onready var DM = load('res://Enemies/DM.tscn')
onready var Vamp = load('res://Enemies/Vamp.tscn')

var spawned = false
func _physics_process(_delta):
	if not Global.combats_completed[Global.room] and get_child_count() < 1 and spawned == false :
		var enemy_name = Global.room_enemy_type[Global.room]
		var enemy_pos = Global.room_enemy_pos[Global.room]
		if enemy_name != '' and enemy_pos != Vector2.UP :
			spawn(enemy_name,enemy_pos)
			spawned = true
	if Global.combats_completed[Global.room]:
		var e = get_children()
		for child in e:
			child.queue_free()
			
func spawn(e_type, p):
	var enemy = null
	if e_type == "Guard":
		enemy = Guard.instance()
	if e_type == "Spider":
		enemy = Spider.instance()
	if e_type == "Guard2":
		enemy = Guard2.instance()
	if e_type == "DM":
		enemy = DM.instance()
	if e_type == "Vamp":
		enemy = Vamp.instance()
	enemy.position = p
	add_child(enemy)
