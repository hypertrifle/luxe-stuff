package components;

import luxe.Component;
import luxe.Sprite;
import luxe.Vector;

import io.InputManager;


class TopdownMovement extends Component {
	var sprite : Sprite;
	var maxMovementSpeed:Int = 200;
	var accelleration:Int = 800;
	var drag:Int = 600;

	var velocity:Vector = new Vector(0,0);
    override function init() {
        //called when initialising the component
        sprite = cast entity;
    }

    override function update(dt:Float) {
        //called every frame for you

	    if(InputManager.playerdown.down()){
	    	velocity.y = (velocity.y < maxMovementSpeed)? velocity.y + accelleration*dt: maxMovementSpeed;

	    } else if(InputManager.playerup.down()){
	    	velocity.y = (velocity.y > -maxMovementSpeed)? velocity.y - accelleration*dt: -maxMovementSpeed;
	    } else {
	    	//apply decelleration
	    	if(velocity.y > 0) {
	    		velocity.y = (velocity.y - drag*dt < 0)? 0 : velocity.y - drag*dt;
	    	} else {
	    		velocity.y = (velocity.y - drag*dt < 0)? 0 : velocity.y + drag*dt;
	    	}
	    }

	    if(InputManager.playerleft.down()){
	    	velocity.x = (velocity.x > -maxMovementSpeed)? velocity.x - accelleration*dt: -maxMovementSpeed;
	    } else if(InputManager.playerright.down()){
	    	velocity.x = (velocity.x < maxMovementSpeed)? velocity.x + accelleration*dt: maxMovementSpeed;
	    } else {
	    	//apply decelleration
	    	if(velocity.x > 0) {
	    		velocity.x = (velocity.x - drag*dt < 0)? 0 : velocity.x - drag*dt;
	    	} else {
	    		velocity.x = (velocity.x - drag*dt < 0)? 0 : velocity.x + drag*dt;
	    	}

	    }

	    this.sprite.pos.x += velocity.x*dt;
	    this.sprite.pos.y += velocity.y*dt;

    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
