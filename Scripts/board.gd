extends TileMapLayer

var logic=preload("res://Scripts/game_logic.gd")
var gameInstance=GameLogic.new()

var pieces_sprites={"WK":Vector2i(0,0),"WQ":Vector2i(1,0),"WB":Vector2i(2,0),
	"WN":Vector2i(3,0),"WR":Vector2i(4,0),"Wp":Vector2i(5,0),
	"BK":Vector2i(0,1),"BQ":Vector2i(1,1),"BB":Vector2i(2,1),"BN":Vector2i(3,1),
	"BR":Vector2i(4,1),"Bp":Vector2i(5,1),"":Vector2i(-1,-1)}
	
var board=[['BR', 'BN', 'BB', 'BQ', 'BK', 'BB', 'BN', 'BR'],
	   ['Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp'],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp'],
	   ['WR', 'WN', 'WB', 'WQ', 'WK', 'WB', 'WN', 'WR']]


	
@onready var selectionLayer=get_node("../selectionLayer")

var selected=false
var selected_cell=Vector2i(-1,-1)
var possible_moves

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in 8:
		for j in 8:
			set_cell(Vector2i(j,i),0,pieces_sprites[board[i][j]])
			



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		selected_cell=local_to_map(to_local(get_global_mouse_position()))
		selected=!selected
		if selected:
			selectionLayer.set_cell(selected_cell,1,Vector2i(0,0))
			#print(selected_cell)
			possible_moves=gameInstance.get_possible_moves(board,board[selected_cell.y][selected_cell.x],Vector2i(selected_cell.y,selected_cell.x))
			for move in possible_moves:
				selectionLayer.set_cell(Vector2i(move.y,move.x),1,Vector2i(1,0))
				
			
		else:
			selectionLayer.clear()
			
		
