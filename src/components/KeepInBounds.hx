package components;

import luxe.Component;
import luxe.Entity;
import luxe.options.ComponentOptions;


typedef KeepInBoundsOptions = {
    >ComponentOptions,
        /** The component name. This is extremely important,
            as it is the named under which this component will be attached,
            and referenced in functions like `get`.
            Think of the name like the attachment slot for a component. */
    @:optional var killOnExit : Bool;

} //ComponentOptions


class KeepInBounds extends Component {

    var killOnOutOfBounds: Bool;
	var radius : Int;

    override public function new(options:KeepInBoundsOptions){

        if(options.killOnExit){
            killOnOutOfBounds = true;
        }

        super(options);

    }


    override function init() {
        //called when initialising the component

        radius = Math.floor(25);

    }

    override function update(dt:Float) {
        //called every frame for you


        // againts zero value edges
        if(entity.pos.y < 0 + radius) {entity.pos.y = radius; if(killOnOutOfBounds){ this.entity.destroy();}}
        if(entity.pos.x < 0 + radius) {entity.pos.x = radius;if(killOnOutOfBounds){ this.entity.destroy();}}

        //againts max value edges
        if(entity.pos.y > Luxe.camera.bounds.w - radius) {entity.pos.y = Luxe.camera.bounds.w - radius;if(killOnOutOfBounds){ this.entity.destroy();}}
        if(entity.pos.x > Luxe.camera.bounds.h - radius) {entity.pos.x = Luxe.camera.bounds.h - radius;if(killOnOutOfBounds){ this.entity.destroy();}}
    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
