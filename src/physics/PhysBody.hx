package physics;

import luxe.Component;
import luxe.Rectangle;
import luxe.Vector;

class PhysBody {
	public var rect:Rectangle;
	public var vel:Vector;
	public var acc:Vector;
	
	public var velCap:Vector;
	
	public var touching:DirectionStates;
	
	public function new(?_rect:Rectangle) {
		rect = (_rect == null) ? new Rectangle() : _rect;
		vel = new Vector();
		acc = new Vector();
		velCap = new Vector();
		
		touching = { left:false, right:false, top:false, bottom:false };
	}
	
	public function clearTouching():Void {
		touching.left = false;
		touching.right = false;
		touching.top = false;
		touching.bottom = false;
	}
}

typedef DirectionStates = {
	var left:Bool;
	var right:Bool;
	var top:Bool;
	var bottom:Bool;
}