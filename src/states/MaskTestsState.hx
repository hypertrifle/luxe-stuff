package states;

import luxe.States;

class MaskTestsState extends State {

  override function init(){

  	walls.push(new Sprite({
  	        geometry: Luxe.draw.box({
  	            x: 0,
  	            y: 0,
  	            w: 200,
  	            h: 200
  	        }),
  	        color: new Color(1, 1, 1, 1),
  	        depth: 3,
  	        rotation_z: 0,
  	        pos: new Vector(550,200),
  	    })); 

  	   walls.push(new Sprite({
  	        geometry: Luxe.draw.circle({
  	            x: 0,
  	            y: 0,
  	            r: 100
  	        }),
  	        color: new Color(1, 1, 1, 0.5),
  	        depth: 3,
  	        rotation_z: 0,
  	        pos: new Vector(150,200),
  	    }));


  	var image = Luxe.resources.texture('assets/testlayer1.png');

  	maskShader = Luxe.resources.shader('maskShader');
  	maskShader.set_texture('mask', walls[1].texture);
  	maskShader.set_float('distortamount', 1);

  	layer1 = new Sprite( {texture:image,size: new Vector( 800, 600 ),pos: new Vector(Luxe.screen.w/2,Luxe.screen.h/2)});

  	image = Luxe.resources.texture('assets/testlayer2.png');
  	layer1 = new Sprite( {texture:image,size: new Vector( 800, 600 ),pos: new Vector(Luxe.screen.w/2,Luxe.screen.h/2),shader:maskShader});

  	/*var test:Sprite = new Sprite({
  	        geometry: new StencilWriteGeometry({
  	            x: 0,
  	            y: 0,
  	            w: 200,
  	            h: 200,
  	            id:'quadstencil.geometry',
  	            batcher: Luxe.renderer.batcher
  	        }),
  	        color: new Color(1, 1, 1, 1),
  	        depth: 3,
  	        rotation_z: 0,
  	        pos: new Vector(300,200),
  	    });*/



  	//draw some test shapes



  }//init

  override function update(dt:Float){

  }//update

}//MaskTestsState
