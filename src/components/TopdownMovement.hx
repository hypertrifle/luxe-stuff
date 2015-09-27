package components;

import luxe.Component;
import luxe.Vector;

import io.InputManager;


class TopdownMovement extends Component {
	var maxMovementSpeed:Int = 50;
	var accelleration:Int = 800;
	var drag:Int = 600;


	var boostMovementSpeed:Int = 200;
	var boosting:Bool = false;

	
	var boostTotal:Float = 1;
	var boostCurrent:Float = 1;
	var boostRefilRate:Float = 1;
	var boostUsageRate:Float = 1;


	public var velocity:Vector = new Vector(0,0);
	
    override function init() {
        //called when initialising the component
    }

    override function update(dt:Float) {
        //called every frame for you
        boosting = false;
        if(InputManager.playerboost.down()){
        	if(boostCurrent > 0){
        		boosting = true;
        		boostCurrent -= dt * boostUsageRate;
        	} 
        } 

        if(!boosting){
        	boostCurrent = (boostCurrent + (boostRefilRate*dt) >= boostTotal)? boostTotal : boostCurrent + (boostRefilRate*dt);
        }

        var moveSpeed:Float = (boosting)? boostMovementSpeed : maxMovementSpeed;

	    if(InputManager.playerdown.down()){
	    	velocity.y = (velocity.y < moveSpeed)? velocity.y + accelleration*dt: moveSpeed;

	    } else if(InputManager.playerup.down()){
	    	velocity.y = (velocity.y > -moveSpeed)? velocity.y - accelleration*dt: -moveSpeed;
	    } else {
	    	//apply decelleration
	    	if(velocity.y > 0) {
	    		velocity.y = (velocity.y - drag*dt < 0)? 0 : velocity.y - drag*dt;
	    	} else {
	    		velocity.y = (velocity.y - drag*dt < 0)? 0 : velocity.y + drag*dt;
	    	}
	    }

	    if(InputManager.playerleft.down()){
	    	velocity.x = (velocity.x > -moveSpeed)? velocity.x - accelleration*dt: -moveSpeed;
	    } else if(InputManager.playerright.down()){
	    	velocity.x = (velocity.x < moveSpeed)? velocity.x + accelleration*dt: moveSpeed;
	    } else {
	    	//apply decelleration
	    	if(velocity.x > 0) {
	    		velocity.x = (velocity.x - drag*dt < 0)? 0 : velocity.x - drag*dt;
	    	} else {
	    		velocity.x = (velocity.x - drag*dt < 0)? 0 : velocity.x + drag*dt;
	    	}

	    }

	    entity.pos.x += velocity.x*dt;
	    entity.pos.y += velocity.y*dt;

    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
