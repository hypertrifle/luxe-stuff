package states;

import luxe.States;
import luxe.options.StateOptions;

class MintState extends State {

	public var canvas: mint.Canvas;

override function new(_options:StateOptions) {
	super(_options);
	canvas = Main.canvas;
}

  override function init(){
  	

  }//init

  override function update(dt:Float){

  }//update

  override function onleave<T>(_:T) {
  		canvas.destroy_children();
        canvas = null;

   } //onleave

   override function onenter<T>(_:T) {

        canvas = Main.canvas;

   }


}//MintState
