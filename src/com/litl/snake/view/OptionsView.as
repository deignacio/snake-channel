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
    import com.litl.control.Label;
    import com.litl.control.TextButton;
    import com.litl.control.VerticalList;
    import com.litl.helpers.view.ViewBase;
    import com.litl.snake.controls.GameLoop;
    import com.litl.snake.enum.ArenaSize;
    import com.litl.snake.enum.ArenaWrap;
    import com.litl.snake.enum.GameSpeed;
    import com.litl.snake.model.GameModel;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    /**
    * a paused view that displays game options
    * <li>arena size
    * <li>game speed
    * <li>wrap across walls
    */
    public class OptionsView extends ViewBase implements IPausedView {
        private var background:Shape;
        private var gameLoop:GameLoop;
        private var model:GameModel;

        private var sizeList:VerticalList;
        private var speedList:VerticalList;
        private var wrapList:VerticalList;

        public function OptionsView(gameLoop:GameLoop, model:GameModel) {
            super();
            height = 400;
            width = 225;
            x = 450;
            y = 30;

            this.gameLoop = gameLoop;
            this.model = model;

            background = new Shape();
            background.graphics.beginFill(0x000000);
            background.graphics.drawRect(0, 0, width, height);
            background.graphics.endFill();
            addChild(background);

            var label:Label = new Label();
            label.text = "game options";
            label.move(25, 20);
            addChild(label);

            label = new Label();
            label.text = "arena size";
            label.move(50, 50);
            addChild(label);

            sizeList = new VerticalList();
            sizeList.verticalScrollPolicy = "off";
            sizeList.itemSize = 20;
            sizeList.setSize(100, 80);
            sizeList.move(50, 70);
            addChild(sizeList);
            sizeList.dataProvider = ArenaSize.ALL_SIZES;
            sizeList.addEventListener(Event.SELECT, onSizeSelect, false, 0, true);

            label = new Label();
            label.text = "game speed";
            label.move(50, 175);
            addChild(label);

            speedList = new VerticalList();
            speedList.verticalScrollPolicy = "off";
            speedList.itemSize = 20;
            speedList.setSize(100, 80);
            speedList.move(50, 195);
            addChild(speedList);
            speedList.dataProvider = GameSpeed.ALL_SPEEDS;
            speedList.addEventListener(Event.SELECT, onSpeedSelect, false, 0, true);

            label = new Label();
            label.text = "wall wrap";
            label.move(50, 305);
            addChild(label);

            wrapList = new VerticalList();
            wrapList.verticalScrollPolicy = "off";
            wrapList.itemSize = 20;
            wrapList.setSize(150, 50);
            wrapList.move(50, 325);
            addChild(wrapList);
            wrapList.dataProvider = ArenaWrap.ALL_WRAPS;
            wrapList.addEventListener(Event.SELECT, onWrapSelect, false, 0, true);

            refresh();
        }

        /** sets the new arena size */
        protected function onSizeSelect(e:Event):void {
            var size:ArenaSize = sizeList.selectedItem as ArenaSize;
            model.arena.size = size;
        }

        /** sets the new speed */
        protected function onSpeedSelect(e:Event):void {
            var speed:GameSpeed = speedList.selectedItem as GameSpeed;
            gameLoop.speed = speed;
        }

        /** sets the new wall wrap setting */
        protected function onWrapSelect(e:Event):void {
            var wrap:ArenaWrap = wrapList.selectedItem as ArenaWrap;
            model.arena.wrap = wrap;
        }

        /** @inheritDoc */
        public function refresh():void {
            sizeList.selectedIndex = ArenaSize.ALL_SIZES.indexOf(model.arena.size);
            speedList.selectedIndex = GameSpeed.ALL_SPEEDS.indexOf(gameLoop.speed);
            wrapList.selectedIndex = ArenaWrap.ALL_WRAPS.indexOf(model.arena.wrap);
        }
    }
}
