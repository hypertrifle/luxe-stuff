package entities;

import luxe.Entity;
import luxe.Vector;
import phoenix.Texture.FilterType;
import phoenix.Texture;

import components.MouseAim;
import components.TopdownMovement;
import components.CameraFollow;
import components.KeepInBounds;
import components.MechAnimation;

import luxe.Vector;
import luxe.Rectangle;
import luxe.options.EntityOptions;

import io.InputManager;


typedef AvatarOptions = {

  >EntityOptions,

  @:optional var aim : MouseAim;
  @:optional var anim : MechAnimation;
  @:optional var movement : TopdownMovement;
  @:optional var camera : CameraFollow;
}


class Avatar extends Entity {


  @:isVar public var aim (default, default): MouseAim = new MouseAim({ name:'mouse'});

  @:isVar public var anim (default, default): MechAnimation = new MechAnimation({ name:'anim' });

  @:isVar public var movement (default, default): TopdownMovement = new TopdownMovement({ name:'movement' });
  @:isVar public var camera (default, default): CameraFollow = new CameraFollow({ name:'camera' });


  public function new(options:AvatarOptions) {

    if(options.aim != null) {
      aim = new MouseAim(options.aim);
    }
    if(options.movement != null) {
      movement = new TopdownMovement(options.movement);
    }


     if(options.anim != null) {
      anim = new MechAnimation(options.anim);
    }
    
    if(options.camera != null) {
      camera = new CameraFollow(options.camera);
    }

   // options.size = ;



    super( options );
  }



  override function init(){
  	
    if(aim != null){
        add(aim);
    }
    if(movement != null){
        add(movement);
    }
    if(camera != null){
        add(camera);
    }

    if(camera != null){
        add(anim);
    }

    add(new KeepInBounds({name:"keepinbounds"}));


    //animation.
    /*if(anim != null){
      add(anim);
     var anim_object = Luxe.resources.json('assets/playeranim.json');
      anim.add_from_json_object( anim_object.asset.json );
      //set the idle animation to active
      anim.animation = 'aim';
      anim.play();
      
    }*/


  }//init


  override function update(dt:Float){
  	super.update(dt);




  }//update

}//Avatar
