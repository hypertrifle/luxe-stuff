package components;

import luxe.Component;
import luxe.options.ComponentOptions;



typedef DamageEvent = {
	@:optional var healthDamage : Float;
	@:optional var shieldDamage : Float;

}


class Resources extends Component {

	var health:Float = 100;
	var shield:Float = 100;
	var energy:Float = 100;



	override public function new(options:ComponentOptions) {
		super(options);

	}

    override function init() {
        //called when initialising the component
        entity.events.listen('player.hit.*', this.hit );

    }



    override function update(dt:Float) {
        //called every frame for you

        //replenish shields and energy over time (possibly if not moving?)

        //if()


    }

    override function onreset() {
        //called when the scene starts or restarts
    }

    function hit(?hitEvent:DamageEvent){
    	trace('hit');
    	this.health -= hitEvent.healthDamage;
    	this.shield -= hitEvent.shieldDamage;


    	if(health <= 0){
    		entity.events.fire("player.die");
    	}


    }

}
