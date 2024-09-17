extends TileMapLayer
##This will need an editor if I wanna make this an actual thing but rn maps are kinda hard coded with tiles
##If you want to make a new map just edit the tileset.
##Anything that has a sprite is a legal square anything empty will make you crash
func checkmove(position:Vector2)->bool:
	return get_cell_atlas_coords(position) == Vector2i(-1, -1)
