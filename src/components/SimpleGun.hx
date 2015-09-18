package components;

import phoenix.Texture;


import luxe.Component;



typedef GunModel = {
	 @:optional var speed : Float; // Speed of the bullets (possibly calculates Range of RayCast?)
	 @:optional var speedSpread : Float; // realspeed = speed -(spreadSpeed/2) + rng*spreadSpeed;
	 @:optional var accuracy : Float; // base accuracy when fireing, possible degrees?
	 @:optional var damagePerBullet : Float; //damage of a single bullet 'fragment' hitting an player bang in the center
	 @:optional var knockback : Float; // amount of knockback shooting has on our player.
	 @:optional var fragmentsPerShot : Int; //amount of bullet fragments pershot ( e.g. Sniper -> 1, Shotty -> 10).
	 @:optional var reloadTime : Float; // time to reload between magazines? this might be dropped due to mechs
	 @:optional var shootReloadTime : Float; // time required between individual shots.
	 @:optional var magazineSize : Int; // bullets fired before reload is required.

	 @:optional var texture:Texture; // the gun's texture
	 
}

typedef BaseEvent = {
	@:optional var model : GunModel;

}

class SimpleGun extends Component {

	var model:GunModel;

    override function init() {
        //called when initialising the component
         entity.events.listen('player.fire', this.fire );
         entity.events.listen('player.endfire', this.endfire );
         entity.events.listen('player.pickup-gun', newGun);
    }

    override function update(dt:Float) {
        //called every frame for you
    }

    override function onreset() {
        //called when the scene starts or restarts
    }

     function newGun(?gunEvent:BaseEvent){
    	model = gunEvent.model;

    	//reset any gun varibles (should be full ammo, maybe this is also passed through gunEvent);
    }

     function fire(?fireEvent:BaseEvent) {
     	trace("fire");

    	// can we fire?

    	//raycast fragments
        


    	//signal bullet pool to render fragments
    	entity.events.fire('bullets.create', {fragments: {}} );

    }

     function endfire(?fireEvent:BaseEvent){

    }

}
