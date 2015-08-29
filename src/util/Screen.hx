package util;

import luxe.Vector;


class Screen {

	public static function toScreen(pos:Vector):Vector {

		return new Vector(pos.x-Luxe.camera.pos.x,pos.y-Luxe.camera.pos.y);
	}
}