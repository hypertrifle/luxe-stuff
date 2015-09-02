package states;

import luxe.States;
import luxe.Color;
import mint.Control;
import mint.types.Types;
import mint.render.luxe.Convert;
import mint.render.luxe.Label;
import mint.layout.margins.Margins;


class MenuState extends MintState {

    var check: mint.Checkbox;
    var progress: mint.Progress;
    


	public function new(){
		 super({ name:'menu' });

	}

  override function init(){

  	//get a list of the states


  	create_basics();

  	//this.gotoState("play");
  }//init

  override function update(dt:Float){

  }//update


  public function gotoState(state:String){
	Main.states.set(state);
  }

  function create_basics() {

    new mint.Label({
        parent: canvas,
        name: 'labelmain',
        x:10, y:10, w:100, h:32,
        text: 'hello mint',
        align:left,
        text_size: 14,
        onclick: function(e,c) {trace('hello mint! ${Luxe.time}' );}
    });

    inline function make_slider(_n,_x,_y,_w,_h,_c,_min,_max,_initial,_step:Null<Float>,_vert, _label) {

        var _s = new mint.Slider({
            parent: canvas, name: _n, x:_x, y:_y, w:_w, h:_h,
            options: { color_bar:new Color().rgb(_c) },
            min: _min, max: _max, step: _step, vertical:_vert, value:_initial
        });

        var _l = new mint.Label({
            parent:_s, text_size:12, x:0, y:0, w:_s.w, h:_s.h,
            align: TextAlign.center, align_vertical: TextAlign.center,
            name : _s.name+'.label', text: '${_s.value}'
        }); 

        var _l2 = new mint.Label({
            parent:_s, text_size:12, x:_w+5, y:0, w:_s.w, h:_s.h,
            align: TextAlign.left, align_vertical: TextAlign.center,
            name : _s.name+'.label', text: _label
        });

        _s.onchange.listen(function(_val,_) { _l.text = '$_val';});

    } //make_slider

    make_slider('slider1', 10, 330, 128, 24, 0x9dca63, -100, 100, 0, 10, false,"Test");
    make_slider('slider2', 10, 357, 128, 24, 0x9dca63, 0, 100, 50, 1, false,"Test2");
    make_slider('slider3', 10, 385, 128, 24, 0xf6007b, null, null, null, null, false,"Test3");

} //create_basics


}//MenuState
