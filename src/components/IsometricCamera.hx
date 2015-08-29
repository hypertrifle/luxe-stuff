package components;

import luxe.Component;

class IsometricCamera extends Component {

    override function init() {
        //called when initialising the component
        startIsometric();
    }

    function startIsometric(){
    	//Rotate the camera such that z points up and x to the right
        var o:Quaternion = new Quaternion().setFromEuler(new Vector().set_xyz(-90, 0, 0).radians());

        //Rotate by Arctan(sin(45°)) (grabbed from wikipedia) around x, to get the top-down part
        var q:Quaternion = new Quaternion().setFromEuler(new Vector().set_xyz(Math.atan(Math.sin(45 * Maths._PI_OVER_180)), 0, 0));

        //Rotate around z by -45° to get the side-on part
        var p:Quaternion = new Quaternion().setFromEuler(new Vector().set_xyz(0, 0, -45).radians());

        //Combine the rotations and apply to the camera
        //Quaterions are combined through multiplication, order of rotation is "from the inside out"
        //Order of rotation here is o, then q, the p
        //Meaning, first rotate around -90° around x, then back by Atan(sin(45°)) around x, finally -45° around z
        Luxe.camera.rotation = p.multiply(q.multiply(o));
    }

    override function update(dt:Float) {
        //called every frame for you
    }

    override function onreset() {
        //called when the scene starts or restarts
    }

}
