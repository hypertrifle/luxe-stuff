package physics;
import luxe.Color;
import luxe.Physics.PhysicsEngine;
import luxe.Rectangle;
import luxe.utils.Maths;
import luxe.Vector;
using physics.RectExt;

//This should really be called the Mosaaic engine
//Anagram for "MOve Stuff Around And It Collides" Engine
//Alternatively just "Mosaic", for "MOve Stuff And It Collides"
class RectPhysics extends PhysicsEngine {
	
	public var dynamicBodies:Array<PhysBody>;
	public var staticBodies:Array<Rectangle>;
	
	public var staticColor:Color = new Color(0.5, 0.5, 1);
	public var dynamicColor:Color = new Color(0.5, 1, 0.5);
	public var collisionColor:Color = new Color(0.8, 0.0, 0.0);
	
	public var touchingThreshold:Float = 0.5;
	override public function init() {
		dynamicBodies = new Array<PhysBody>();
		staticBodies = new Array<Rectangle>();
	}
	
	override public function render() {
		if (!draw) return;
		for (rect in staticBodies) {
			Luxe.draw.rectangle( {
				immediate:true,
				rect:rect,
				color:staticColor
			});
		}
		for (body in dynamicBodies) {
			Luxe.draw.rectangle( {
				immediate:true,
				rect:body.rect,
				color:dynamicColor
			});
			if (body.touching.left) {
				Luxe.draw.line( {
					p0:new Vector(body.rect.x, body.rect.y),
					p1:new Vector(body.rect.x, body.rect.bottom()),
					color:collisionColor,
					immediate:true
				});
			}
			if (body.touching.right) {
				Luxe.draw.line( {
					p0:new Vector(body.rect.right(), body.rect.y),
					p1:new Vector(body.rect.right(), body.rect.bottom()),
					color:collisionColor,
					immediate:true
				});
			}
			if (body.touching.top) {
				Luxe.draw.line( {
					p0:new Vector(body.rect.x, body.rect.y),
					p1:new Vector(body.rect.right(), body.rect.y),
					color:collisionColor,
					immediate:true
				});
			}
			if (body.touching.bottom) {
				Luxe.draw.line( {
					p0:new Vector(body.rect.x, body.rect.bottom()),
					p1:new Vector(body.rect.right(), body.rect.bottom()),
					color:collisionColor,
					immediate:true
				});
			}
		}
	}
	
	override public function update() {
		if (paused) return;
		
		var oldBodyRect = new Rectangle();
		var vel = new Vector();
		var acc = new Vector();
		var intersection:Rectangle;
		for (body in dynamicBodies) {
			
			oldBodyRect.copy_from(body.rect);
			
			acc.copy_from(body.acc);
			acc.multiplyScalar(Luxe.physics.step_delta * Luxe.timescale);
			
			body.vel.add(acc);
			
			body.vel.x = Maths.sign(body.vel.x) * Math.min(Math.abs(body.vel.x), body.velCap.x);
			body.vel.y = Maths.sign(body.vel.y) * Math.min(Math.abs(body.vel.y), body.velCap.y);
			
			vel.copy_from(body.vel);
			vel.multiplyScalar(Luxe.physics.step_delta * Luxe.timescale);
			
			body.rect.move(vel);
			
			body.clearTouching();
			
			var intersection:Rectangle;
			for (rect in staticBodies) {
				intersection = oldBodyRect.intersection(rect);
				
				if (intersection != null) {
					if (intersection.h <= intersection.w) {
						oldBodyRect.y += (oldBodyRect.y < rect.y) ? -intersection.h : intersection.h;
					}
					else {
						oldBodyRect.x += (oldBodyRect.x < rect.x) ? -intersection.w : intersection.w;
					}
				}
				
				if (body.rect.overlaps(rect)) {
					if (oldBodyRect.leftOf(rect)) {
						body.rect.x = rect.x - body.rect.w;
					}
					else if (oldBodyRect.rightOf(rect)) {
						body.rect.x = rect.right();
					}
					else if (oldBodyRect.above(rect)) {
						body.rect.y = rect.y - body.rect.h;
					}
					else if (oldBodyRect.below(rect)) {
						body.rect.y = rect.bottom();
					}
				} // if dynamic overlaps static
				
				
				//the body is regarded as touching when it is less than one pixel away from the edge of the object
				//(i.e. difference between the edge of the body and the edge of the obstacle is less than one)
				//Use range check because the body may be far beyond the obstacle, so the difference will be negative, and less than 1 would be true
				if (body.rect.bottom() > rect.y && body.rect.y < rect.bottom()) {
					if (Maths.within_range(rect.x - body.rect.right(), 0, touchingThreshold)) body.touching.right = true;
					if (Maths.within_range(body.rect.x - rect.right(), 0, touchingThreshold)) body.touching.left = true;
				}
				
				if (body.rect.right() > rect.x && body.rect.x < rect.right()) {
					if (Maths.within_range(body.rect.y - rect.bottom(), 0, touchingThreshold)) body.touching.top = true;
					if (Maths.within_range(rect.y - body.rect.bottom(), 0, touchingThreshold)) body.touching.bottom = true;
				}
			} // for each static body
		} // for each dynamic body
		
		Luxe.events.fire('RectPhysics.update.complete');
	} // update
}