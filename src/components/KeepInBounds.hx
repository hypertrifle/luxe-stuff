package components;

import luxe.Component;
import luxe.Sprite;
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

	var sprite : Sprite;
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

        sprite = cast entity;
        radius = Math.floor(sprite.size.x/2);

    }

    override function update(dt:Float) {
        //called every frame for you


        // againts zero value edges
        if(sprite.pos.y < 0 + radius) {sprite.pos.y = radius; if(killOnOutOfBounds){ this.sprite.destroy();}}
        if(sprite.pos.x < 0 + radius) {sprite.pos.x = radius;if(killOnOutOfBounds){ this.sprite.destroy();}}

        //againts max value edges
        if(sprite.pos.y > Luxe.camera.bounds.w - radius) {sprite.pos.y = Luxe.camera.bounds.w - radius;if(killOnOutOfBounds){ this.sprite.destroy();}}
        if(sprite.pos.x > Luxe.camera.bounds.h - radius) {sprite.pos.x = Luxe.camera.bounds.h - radius;if(killOnOutOfBounds){ this.sprite.destroy();}}
    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
