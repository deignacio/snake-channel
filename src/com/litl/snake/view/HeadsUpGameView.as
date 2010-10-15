/* Copyright (c) 2010 litl, LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to
* deal in the Software without restriction, including without limitation the
* rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
* sell copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
* IN THE SOFTWARE.
*/
package com.litl.snake.view {
    import com.litl.helpers.view.ViewBase;
    import com.litl.sdk.util.Tween;
    import com.litl.snake.enum.PlayerColors;
    import com.litl.snake.event.CrashSceneEvent;
    import com.litl.snake.model.GameModel;
    import com.litl.snake.model.Player;
    import com.litl.snake.model.PlayerPosition;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

    /** dispatch this event when you start drawing a crash scene */
    [Event(name=CrashSceneEvent.BEGIN, type="com.litl.snake.event.CrashSceneEvent")]

    /** dispatch this event when your crash scene animation/tweens are done */
    [Event(name=CrashSceneEvent.END, type="com.litl.snake.event.CrashSceneEvent")]

    public class HeadsUpGameView extends EventDispatcher implements IGameView {
        /** the color of the arena */
        public static const ARENA_COLOR:uint = 0x000000;

        /** the color drawn for parts of the screen behind the arena */
        public static const BACKGROUND_COLOR:uint = 0xcdc9c9;

        private var model:GameModel;
        private var _view:ViewBase;
        private var sprite:Sprite;
        private var background:Shape;
        protected var playerShapes:Dictionary;
        protected var tails:Sprite

        protected var playerRadius:Number;
        protected var maxDist:Number;

        protected var explodeCenter:Object;
        protected var crashTweens:Array;

        public function HeadsUpGameView(model:GameModel) {
            this.model = model;

            playerShapes = new Dictionary();
            crashTweens = new Array();

            sprite = new Sprite();
        }

        /** targets the new view, recalculates player sizes */
        public function set view(value:ViewBase):void {
            if (_view != value) {
                _view = value;

                _view.addChild(sprite);

                playerRadius = Math.min(_view.width / model.arena.size.cols / 2, _view.height / model.arena.size.rows / 2);
                maxDist = Math.sqrt(Math.pow(_view.width, 2) + Math.pow(_view.height, 2));
            }
        }

        /** clears the current view, draws a new background, removes any tails */
        public function clear():void {
            if (background != null && background.parent != null) {
                background.parent.removeChild(background);
            }

            background = new Shape();
            background.graphics.clear();
            background.graphics.beginFill(BACKGROUND_COLOR);
            background.graphics.drawRect(0, 0, _view.width, _view.height);
            background.graphics.endFill();
            background.graphics.beginFill(ARENA_COLOR);
            background.graphics.drawRect(0, 0, model.arena.size.cols * playerRadius * 2, model.arena.size.rows * playerRadius * 2);
            background.graphics.endFill();
            sprite.addChild(background);

            if (tails != null && tails.parent != null) {
                tails.parent.removeChild(tails);
            }

            tails = new Sprite();
            sprite.addChild(tails);
        }

        /** draws the latest move for each player */
        public function drawMove():void {
            model.forEachPlayer(drawPlayer);
        }

        /** draws the whole arena */
        public function refresh():void {
            model.arena.forEachPosition(drawTail);
        }

        /** moves the large player shape to the new position, create a new tail spot */
        protected function drawPlayer(player:Player):void {
            if (!playerShapes.hasOwnProperty(player.id)) {
                playerShapes[player.id] = new PlayerShape(player.id,
                    PlayerColors.getColor(player.id),
                    0,
                    0,
                    playerRadius);
            }

            var s:PlayerShape = playerShapes[player.id];
            mapToScreen(s, player.position);
            s.redraw();
            sprite.addChild(s);
            tails.addChild(s.makeTailShape());
        }

        /** used when refreshing, draws a tail shape in a position */
        protected function drawTail(pos:PlayerPosition, player:Player):void {
            var s:PlayerShape = playerShapes[player.id];
            if (s != null) {
                mapToScreen(s, pos);
                tails.addChild(s.makeTailShape());
            }
        }

        /** translates a player position into onscreen coords */
        protected function mapToScreen(obj:Object, pos:PlayerPosition):void {
            obj.x = pos.x * playerRadius * 2;
            obj.y = pos.y * playerRadius * 2;
        }

        /**
         * begins a crash scene animation
         * <li>dispatches a new CrashSceneEvent.BEGIN event
         * <li>determines the epicenter of the crash (if multiple players crashed)
         * <li>"explodes" each crashed player
         * <li>throws all other players and tail shapes off the screen
         */
        public function drawCrash():void {
            dispatchEvent(new CrashSceneEvent(CrashSceneEvent.BEGIN));

            explodeCenter = calculateExplodeCenter();

            var t:PlayerShape;
            for (var i:int = 0; i < tails.numChildren; i++) {
                t = tails.getChildAt(i) as PlayerShape;
                throwPlayerShapeOffscreen(t);
            }

            model.forEachPlayer(crashOrExplodePlayer);

            explodeCenter = null;
        }

        /**
         * a model.forEachPlayer callback.
         * if the player has crashed, explode it, otherwise throw it
         * off the screen
         */
        protected function crashOrExplodePlayer(player:Player):void {
            var shape:PlayerShape = playerShapes[player.id];
            if (model.crashes.indexOf(player) != -1) {
                explodePlayerShape(shape);
            } else {
                throwPlayerShapeOffscreen(shape);
            }
            delete playerShapes[player.id];
        }

        /**
         * explodes the crashed player
         * currently just grows it to 20x size and fades to transparent
         */
        protected function explodePlayerShape(s:PlayerShape):void {
            s.tweening = true;
            var tween:Tween = Tween.tweenTo(s,
                2,
                { "radius":20*playerRadius,
                    "alpha":0.0 });
            tween.addEventListener("complete", onCrashComplete);
            crashTweens.push(tween);
        }

        /** throws the player shape off the screen. */
        protected function throwPlayerShapeOffscreen(s:PlayerShape):void {
            s.tweening = true;
            var crashParams:Object = calculateThrowDestination(s, explodeCenter);
            crashParams["alpha"] = 0.0;
            var tween:Tween = Tween.tweenTo(s,
                1.5, crashParams);
            tween.addEventListener("complete", onCrashComplete);
            crashTweens.push(tween);
        }

        /**
         * when the crash related tween is done, removes it from
         * the list of existing crash tweens
         */
        protected function onCrashComplete(e:Event):void {
            var tween:Tween = e.currentTarget as Tween;
            var s:PlayerShape = tween.subject as PlayerShape;
            s.tweening = false;

            if (s.parent != null) {
                s.parent.removeChild(s);
            }

            var index:int = crashTweens.indexOf(tween);
            if (index != -1) {
                crashTweens.splice(index, 1);
            }
            maybeDoneCrashing();
        }

        /** if no more crash tweens, dispatch CrashSceneEvent.END */
        protected function maybeDoneCrashing():void {
            if (crashTweens.length == 0) {
                dispatchEvent(new CrashSceneEvent(CrashSceneEvent.END));
            }
        }

        /** calculates the centroid of polygon formed by all crashed players */
        protected function calculateExplodeCenter():Object {
            var center:PlayerPosition = new PlayerPosition(0, 0);

            var p:Player;
            for (var i:int = 0; i < model.crashes.length; i++) {
                p = model.crashes[i];
                center.x += p.position.x;
                center.y += p.position.y;
            }

            center.x /= model.crashes.length;
            center.y /= model.crashes.length;

            var obj:Object = {};
            mapToScreen(obj, center);
            return obj;
        }

        /** calculates the throw shape destination centered around the crash epicenter */
        protected function calculateThrowDestination(s:PlayerShape, center:Object):Object {
            var proximity:Number = Math.sqrt(Math.pow(center.x - s.x, 2) + Math.pow(center.y - s.y, 2));
            var ratio:Number = maxDist / proximity;
            var dx:Number = ratio * (center.x - s.x);
            var dy:Number = ratio * (center.y - s.y);

            var dest:Object = { "x":center.x - dx, "y":center.y - dy };
            return dest;
        }
    }
}
