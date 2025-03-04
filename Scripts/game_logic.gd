class_name GameLogic

var gameBoard=[['BR', 'BN', 'BB', 'BQ', 'BK', 'BB', 'BN', 'BR'],
	   ['Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp', 'Bp'],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['','','','','','','',''],
	   ['Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp', 'Wp'],
	   ['WR', 'WN', 'WB', 'WQ', 'WK', 'WB', 'WN', 'WR']]

func test():
	print("Hello")

func _init():
	test()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func get_possible_moves(board,piece,loc):

	var row=loc.x
	var col=loc.y
	var moves=[]

	if piece[1]=='N':
		var temp_moves=[Vector2i(row+2,col+1),Vector2i(row+2,col-1),Vector2i(row-2,col+1),
			Vector2i(row-2,col-1),Vector2i(row+1,col+2),Vector2i(row+1,col-2),Vector2i(row-1,col+2),
			Vector2i(row-1,col-2)]

		for move in temp_moves:
			var row1=move.x
			var col1=move.y
			var possible=true

			if (row1<0 or row1>7 or col1<0 or col1>7):
				possible=false
				continue
	
			elif board[row1][col1]!='':
				if board[row1][col1][0]==piece[0]:
					possible=false
					continue

			if(possible==true):
				moves.append(move)

	elif piece[1]=='K':
		var temp_moves=[Vector2i(row+1,col+1),Vector2i(row+1,col),Vector2i(row+1,col-1),
			Vector2i(row-1,col+1),Vector2i(row-1,col),Vector2i(row-1,col-1),Vector2i(row,col+1),
			Vector2i(row,col-1)]

		for move in temp_moves:
			var row1=move.x
			var col1=move.y
			var possible=true

			if (row1<0 or row1>7 or col1<0 or col1>7):
				possible=false
				continue
	
			elif board[row1][col1]!='':
				if board[row1][col1][0]==piece[0]:
					possible=false
					continue

			if(possible==true):
				moves.append(move)

	elif piece=='Bp':
		moves.append(Vector2i(row+1,col))

	elif piece=='Wp':
		moves.append(Vector2i(row-1,col))


		

	else:
		moves=incremental_moves(board,piece,loc)

	moves.append_array(get_special_moves(board,piece,loc))

	return moves
		

#for incremental moves that stops on obstruction(Rook,Bishop,Queen)
func incremental_moves(board,piece,loc):
	var row=loc.x
	var col=loc.y
	var increments={'R':[Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(0,-1)],
		'B':[Vector2i(1,1),Vector2i(-1,-1),Vector2i(1,-1),Vector2i(-1,1)],
		'Q':[Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,1),
			Vector2i(-1,-1),Vector2i(1,-1),Vector2i(-1,1)]}
	var moves=[]
	#print(increments[piece[1]])
	for increment in increments[piece[1]]:
		var row1=loc.x
		var col1=loc.y
		var possible=true
		var obstruction=false
		while possible and !obstruction:
			row1+=increment[0]
			col1+=increment[1]
			if (row1<0 or row1>7 or col1<0 or col1>7):
				possible=false

			elif board[row1][col1]!='':
				obstruction=true
				if board[row1][col1][0]==piece[0]:
					possible=false

			if possible:
				moves.append(Vector2i(row1,col1))

	return moves
	
func get_special_moves(board,piece,loc):
	var row=loc.x
	var col=loc.y
	var moves=[]
	if piece=='Bp':
		var temp=[Vector2i(row+1,col+1),Vector2i(row+1,col-1)]
		for move in temp:
			if is_valid_coords(move):
				var t=board[move[0]][move[1]]
				if t!='':
					if t[0]=='W':
						moves.append(move)
		if row==1:
			moves.append(Vector2i(row+2,col))

	elif piece=='Wp':
		var temp=[Vector2i(row-1,col+1),Vector2i(row-1,col-1)]
		for move in temp:
			if is_valid_coords(move):
				var t=board[move[0]][move[1]]
				if t!='':
					if t[0]=='B':
						moves.append(move)

		if row==6:
			moves.append(Vector2i(row-2,col))


	return moves
	
func is_valid_coords(cords):
	if cords.x<0 or cords.x>7 or cords.y<0 or cords.y>7:
		return false
		
	else:
		return true
