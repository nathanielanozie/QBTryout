﻿package com{		import com.Moving2dSpriteThatCatchesYMoves;	import flash.utils.Timer;//for timer	import flash.events.*;	import flash.geom.Point;		public class ColliderForTwoMoving2dSprite{		//moving 2d object, moving 2d object 		private var playBackTime:Timer;		private var a2dSprite:Moving2dObject;		private var b2dSprite:Moving2dSpriteThatCatchesYMoves;		private var catchers_array:Array;		private var aPoint:Point;		private var bPoint:Point;		private var shouldAddCatch:Boolean;		private var numberTicksFromLastCatch:Number;				private var currentindex:Number = 0;//First element of Moving Catchers Array					//Moving2dObject, Array:Moving2dSpriteThatCatchesYMoves		public function ColliderForTwoMoving2dSprite(a:Moving2dObject, b:Array):void{			a2dSprite=a;			b2dSprite=b[currentindex];			catchers_array=b;			var temp:Timer = a2dSprite.playBackTimer();			playBackTime= new Timer( temp.delay, temp.repeatCount ) ;			shouldAddCatch=true;			numberTicksFromLastCatch=0;			trace("created collision detection");			setCoordinateFrom2DSprite();			trace("set to global coordinates");			setTimer();		}						//accessor get methods		private function xcollision():Boolean{			var aCollision:Boolean = false;			var a:Number= a2dSprite.localToGlobal(aPoint).x;			var b:Number =b2dSprite.localToGlobal(bPoint).x;						var adistance:Number= Math.round( Math.abs(a - b) );						if( adistance < 10 ){			aCollision=true;			trace("x collision at: "+a);}						return aCollision;		}				private function ycollision():Boolean{			var aCollision:Boolean = false;			var a:Number= a2dSprite.localToGlobal(aPoint).y;			var b:Number =b2dSprite.localToGlobal(bPoint).y;						var adistance:Number= Math.round( Math.abs(a - b) );						if( adistance < 40 ){			aCollision=true;			trace("y collision at: "+a);}						return aCollision;		}								//accessor set method		private function setCoordinateFrom2DSprite():void{			/* //before 			aPoint = new Point( a2dSprite.xposition(), a2dSprite.yposition());			bPoint = new Point( b2dSprite.xposition(), b2dSprite.yposition());			*/			aPoint = new Point( a2dSprite.xposition(), a2dSprite.yposition());			bPoint = new Point( b2dSprite.moverXPosition(), b2dSprite.moverYPosition());		}		private function setTimer():void {			playBackTime.addEventListener(TimerEvent.TIMER, playBackOnTick);			playBackTime.addEventListener(TimerEvent.TIMER_COMPLETE, stopTimer);		}		private function playBackOnTick(event:TimerEvent):void {			//loop			var i:Number=0;			for(i=0; i< catchers_array.length; i++)			{				currentindex=i;				b2dSprite= catchers_array[i];							//coordinates in stage coordinates			setCoordinateFrom2DSprite();			trace("catcher y position: "+b2dSprite.moverYPosition());			//trace("object 1 x position: "+a2dSprite.xposition());						var xcolide:Boolean = xcollision();//detect x collision;			var ycolide:Boolean=ycollision();									trace("ticks from last catch "+ticksFromLastCatch());			if(xcolide && ycolide  && shouldAddCatch){				setCatches(1);			}			trace("Total Catches :) "+b2dSprite.totalCatches());						}		}		private function setCatches(num:Number):void{			b2dSprite.addToCatches(num);			shouldAddCatch=false;		}		private function ticksFromLastCatch():Number{			if(!shouldAddCatch){				numberTicksFromLastCatch = numberTicksFromLastCatch+1;				//if ticks larger than a certain bound				//time to go through the object				//should add catch  gets TRUE				return numberTicksFromLastCatch;				}			else{				numberTicksFromLastCatch=0;			return numberTicksFromLastCatch };		}		private function stopTimer(event:TimerEvent):void {			playBackTime.stop();			trace("end time");		}		public function startTimerAndMove():void {			playBackTime.start();		}	}	}