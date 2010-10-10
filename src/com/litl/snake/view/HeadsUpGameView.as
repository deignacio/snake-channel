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
    import com.litl.snake.enum.PlayerColors;
    import com.litl.snake.model.GameModel;
    import com.litl.snake.model.Player;
    import com.litl.snake.model.PlayerPosition;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.utils.Dictionary;

    public class HeadsUpGameView implements IGameView {
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

        public function HeadsUpGameView(model:GameModel) {
            this.model = model;

            playerShapes = new Dictionary();

            sprite = new Sprite();
        }

        /** targets the new view, recalculates player sizes */
        public function set view(value:ViewBase):void {
            if (_view != value) {
                _view = value;

                _view.addChild(sprite);

                playerRadius = Math.min(_view.width / model.arena.size.cols / 2, _view.height / model.arena.size.rows / 2);
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
    }
}
