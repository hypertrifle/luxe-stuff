package components;

import luxe.Component;
import luxe.components.sprite.SpriteAnimation;
import luxe.Vector;
import phoenix.Quaternion;

import luxe.options.ComponentOptions;
import luxe.utils.Maths;

import luxe.Sprite;


class MechAnimation extends Component {

	var topSprite : Sprite;
	var bottomSprite : Sprite;

	var movement: TopdownMovement;

	@:isVar public var _rotation_euler_feet (default,default): Vector = new Vector();
    @:isVar public var _rotation_quat_feet (default,default): Quaternion = new Quaternion();

    @:isVar public var lerpSpeed (default,default): Float = 0.1;


  	@:isVar public var topAnim (default, default): SpriteAnimation = new SpriteAnimation({ name:'anim' });

  	override public function new(options:ComponentOptions){
  		//these are required for the bottom sprite to animate.

  		super(options);
  	}

    override function init() {
        //called when initialising the component

        var image = Luxe.resources.texture('assets/head-guns.png');
        topSprite = new Sprite( {texture:image,size: new Vector( 50, 50 )});

        var image2 = Luxe.resources.texture('assets/feet.png');
        bottomSprite = new Sprite( {texture:image2,size: new Vector( 50, 50 )});


         //animation.

         movement = cast get('movement');
	   

    }

    override function update(dt:Float) {
        //called every frame for you
        topSprite.pos = bottomSprite.pos = pos;
        topSprite.rotation = rotation;

        //custom rotation for the bottom sprite.
        if(movement.velocity.y != 0 || movement.velocity.x != 0){
	        //lets get the angle from the velocity
	        var radians = Maths.radians((180/Math.PI) * Math.atan2(movement.velocity.y, movement.velocity.x) - 90);
	        _rotation_euler_feet.z = radians;
	        _rotation_quat_feet.setFromEuler( _rotation_euler_feet );


	        bottomSprite.rotation.z = Maths.lerp(bottomSprite.rotation.z, _rotation_quat_feet.clone().z, lerpSpeed);
	        bottomSprite.rotation.y = Maths.lerp(bottomSprite.rotation.y, _rotation_quat_feet.clone().y, lerpSpeed);
	        bottomSprite.rotation.x = Maths.lerp(bottomSprite.rotation.x, _rotation_quat_feet.clone().x, lerpSpeed);
	        bottomSprite.rotation.w = Maths.lerp(bottomSprite.rotation.w, _rotation_quat_feet.clone().w, lerpSpeed);
	    }

    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
