package entities;

import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture.FilterType;
import phoenix.Texture;

import components.MouseAim;
import components.TopdownMovement;
import components.CameraFollow;
import components.KeepInBounds;
import luxe.components.sprite.SpriteAnimation;

import luxe.Vector;
import luxe.Rectangle;
import luxe.options.SpriteOptions;

import io.InputManager;


typedef AvatarOptions = {

  >SpriteOptions,

  @:optional var aim : MouseAim;
  @:optional var anim : SpriteAnimation;
  @:optional var movement : TopdownMovement;
  @:optional var camera : CameraFollow;
}


class Avatar extends Sprite {


  @:isVar public var aim (default, default): MouseAim = new MouseAim({ name:'mouse'});

  @:isVar public var anim (default, default): SpriteAnimation = new SpriteAnimation({ name:'anim' });

  @:isVar public var movement (default, default): TopdownMovement = new TopdownMovement({ name:'movement' });
  @:isVar public var camera (default, default): CameraFollow = new CameraFollow({ name:'camera' });


  public function new(options:AvatarOptions) {

    if(options.aim != null) {
      aim = new MouseAim(options.aim);
    }

    if(options.anim != null) {
      anim = new SpriteAnimation(options.anim);
    }
    if(options.movement != null) {
      movement = new TopdownMovement(options.movement);
    }
    if(options.camera != null) {
      camera = new CameraFollow(options.camera);
    }

    options.size = new Vector( 132/2, 139/2 );



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

    add(new KeepInBounds({name:"keepinbounds"}));


    //animation.
    if(anim != null){
      add(anim);
     var anim_object = Luxe.resources.json('assets/playeranim.json');
      anim.add_from_json_object( anim_object.asset.json );
      //set the idle animation to active
      anim.animation = 'aim';
      anim.play();
      
    }


  }//init


  override function update(dt:Float){
  	super.update(dt);




  }//update

}//Avatar
