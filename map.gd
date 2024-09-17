extends TileMapLayer
func checkmove(position:Vector2)->bool:
	return get_cell_atlas_coords(position) == Vector2i(-1, -1)
