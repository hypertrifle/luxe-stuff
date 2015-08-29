package components;

import luxe.Component;
import luxe.Sprite;
import luxe.Input;
import luxe.States;
import luxe.Emitter;

class FrameInput extends Component {

	var sprite : Sprite;
	var inputs: Array<Frame>;
	var record:Array<{frame:Frame,time:Float}>;
	var prev:Frame;
	var current:Frame;
	var gampadID:Int;
	var inputWindow:Int = 30;
	var currentTime:Float = 0;

	var axisconfig:Array<{xboxID:Int, direction:Float, cutoff:Float, gameID:String}>;


	override public function init(){
		sprite = cast entity;
		inputs = new Array<Frame>();
		axisconfig = new Array<{xboxID:Int, direction:Float, cutoff:Float, gameID:String}>();
		prev = new Frame();
		record = new Array<{frame:Frame,time:Float}>();
		currentTime = 0;

		loadInputConfiguration();

	}

	override function update( dt:Float ) {
		currentTime += dt;
		

		current = prev;
		inputs.unshift(current);
		if(inputs.length > inputWindow){
			inputs = inputs.splice(0,inputWindow);
			
		}

		if(record.length < 2 || record[1].frame.isDifferent(current)){
			record.push({frame: current, time: currentTime });
			trace(current);
		}



		


	}

	override function oninputdown( event:{name:String, event:InputEvent} ) {
    	
    	keyDown(event.name);
    	Reflect.setField(prev,name,true);

    } //oninputdown

    override function oninputup( event:{name:String, event:InputEvent} ) {
    	
    	keyUp(event.name);
    	Reflect.setField(prev,name,false);

    } //oninputup

    override function ongamepadaxis(event:GamepadEvent ) {

    	

    	//lets check the axis configuration
    	for (i in 0 ... axisconfig.length) {
    		if(axisconfig[i].xboxID == event.axis){
    			//effects this axis
    			if(axisconfig[i].direction > 0){
    				// get boolean if true / false
    				var val:Bool = (event.value >  axisconfig[i].direction * axisconfig[i].cutoff)? true : false;
    				//set frame value
    				Reflect.setField(prev,axisconfig[i].gameID,val);

    			} else if(axisconfig[i].direction < 0){
    				// get boolean if true / false
    				var val:Bool = (event.value <  axisconfig[i].direction * axisconfig[i].cutoff)? true : false;
    				//set frame value
    				Reflect.setField(prev,axisconfig[i].gameID,val);

    			}

    		}
    		
    	}
    }

	public function loadInputConfiguration(){


		axisconfig.push({xboxID:5, direction:1, cutoff:0.3, gameID:"b6"});
		Luxe.input.bind_gamepad('b', Key.left);
    	Luxe.input.bind_gamepad('f', Key.right);
    	Luxe.input.bind_gamepad('u', Key.up);
    	Luxe.input.bind_gamepad('d', Key.down);
    	Luxe.input.bind_gamepad('b1', Key.key_q);
    	Luxe.input.bind_gamepad('b2', Key.key_w);
    	Luxe.input.bind_gamepad('b3', Key.key_e);
    	Luxe.input.bind_gamepad('b4', Key.key_a);
    	Luxe.input.bind_gamepad('b5', Key.key_s);
    	Luxe.input.bind_gamepad('b6', Key.key_d);
	}

	public function keyUp(e:String){
		trace("up:" + e);
	}

	public function keyDown(e:String){
		trace("down:" + e);
	}



	
}

class Frame {
	var f:Bool;
	var d:Bool;
	var b:Bool;
	var u:Bool;

	var b1:Bool = false;
	var b2:Bool = false;
	var b3:Bool = false;
	var b4:Bool = false;
	var b5:Bool = false;
	var b6:Bool = false;

	public function new(){

	}

	public function isDifferent(prevFrame:Frame):Bool {
		if(prevFrame.f != this.f) {return true;}
		if(prevFrame.d != this.d) {return true;}
		if(prevFrame.b != this.b) {return true;}
		if(prevFrame.u != this.u) {return true;}
		if(prevFrame.b1 != this.b1) {return true;}
		if(prevFrame.b2 != this.b2) {return true;}
		if(prevFrame.b3 != this.b3) {return true;}
		if(prevFrame.b4 != this.b4) {return true;}
		if(prevFrame.b5 != this.b5) {return true;}
		if(prevFrame.b6 != this.b6) {return true;}



		return false;
		


	}

	public function reset(){
		f = false;
		d = false;
		b = false;
		u = false;

		b1 = false;
		b2 = false;
		b3 = false;
		b4 = false;
		b5 = false;
		b6 = false;
	}
}