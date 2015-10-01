package physics;
import luxe.Rectangle;
import luxe.Vector;

class RectExt {
	public static function move(_this:Rectangle, v:Vector) {
		_this.x += v.x;
		_this.y += v.y;
	}
	
	public static function intersection( _this:Rectangle, _other:Rectangle ):Rectangle {
		if (!_this.overlaps(_other)) return null;
		var left = Math.max(_this.x, _other.x);
		var top = Math.max(_this.y, _other.y);
		var right = Math.min(_this.x + _this.w, _other.x + _other.w);
		var bottom = Math.min(_this.y + _this.h, _other.y + _other.h);
		return new Rectangle(left, top, right - left, bottom - top);
	}
	
	public static inline function right(_this:Rectangle):Float {
		return _this.x + _this.w;
	}
	
	public static inline function bottom(_this:Rectangle):Float {
		return _this.y + _this.h;
	}
	
	public static inline function leftOf(_this:Rectangle, _other:Rectangle):Bool {
		return right(_this) <= _other.x;
	}
	
	public static inline function rightOf(_this:Rectangle, _other:Rectangle):Bool {
		return _this.x >= right(_other);
	}
	
	public static inline function above(_this:Rectangle, _other:Rectangle):Bool {
		return bottom(_this) <= _other.y;
	}
	
	public static inline function below(_this:Rectangle, _other:Rectangle):Bool {
		return _this.y >= bottom(_other);
	}
}