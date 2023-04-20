extends Node

var spawn_position = Vector2(100,100)
var init_spawn_pos = Vector2(100,100)
var in_combat = false
var score = 0
var level = 20
var room = 1
var saferoom = 1
var rooms = [0,'res://Levels/Room1.tscn',
'res://Levels/Room2.tscn','res://Levels/Room3.tscn','res://Levels/Room4.tscn','res://Levels/Room5.tscn'
,'res://Levels/Room6.tscn','res://Levels/Room7.tscn','res://UI/Game_Over.tscn']
var potions = ['potion','potion','potion','potion','potion']

var combats_completed = {0:false,1:false,2:false,3:false,4:false,5:false,6:false,7:false,8:false}

var room_enemy_type = {0:'',
	1:'',
	2:'Guard',
	3:'Spider',
	4: 'DM',
	5: 'Guard2',
	6: 'Spider2',
	7: 'Vamp',
	8: ''
}
var room_enemy_pos = {0:Vector2.ZERO,
	1:Vector2.ZERO,
	2:Vector2(520,450),
	3:Vector2(200, 200),
	4:Vector2(800, 300),
	5:Vector2(200,600),
	6:Vector2(200, 200),
	7:Vector2(800,300),
	8:Vector2.ZERO
}
var spawned = false
var enemy_combat_pos = [Vector2(600,150)]

var stats = {"max_health":20, 'health':20,
	"base_defense":12,'defense':12,
	'base_attack':20, 'attack':20,
}

func _unhandled_input(event):
	if event.is_action_pressed("menu") and not in_combat:
		get_node("/root/Game/Pause_Menu").show()

func stat_raise(target, stat, amount):
	if target == 'player':
		stats[stat] += amount

func stat_lower(target,stat,amount):
	if target == 'player':
		stats[stat] -= amount

func reset():
	spawn_position = init_spawn_pos
	score = 0
	for key in combats_completed :
		combats_completed[key] = false
	stats = {"max_health":10, 'health':10,
		"base_defense":10,'defense':10,
		'base_attack':10, 'attack':10,
		'max_mana':10, 'mana':10
	}

func decrease_level():
	level -= 1
	stats['health'] -= 1
	stats['max_health'] -= 1
	stats['attack'] -= 1
	stats['base_attack'] -= 1
	stats['defense'] -= 1
	stats['base_defense'] -= 1
