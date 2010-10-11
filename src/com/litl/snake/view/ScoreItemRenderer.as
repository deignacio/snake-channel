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
    import com.litl.control.ControlBase;
    import com.litl.control.Label;
    import com.litl.control.listclasses.IItemRenderer;

    import flash.display.Sprite;
    import flash.text.TextFieldAutoSize;

    /**
     * A custom item renderer for the VerticalList control.
     *
     * Assumes that a data item will be an object with three
     * values:  name, crashCount, and causedCount
     */
    public class ScoreItemRenderer extends ControlBase implements IItemRenderer {

        protected var _data:Object;
        protected var nameLabel:Label;
        protected var scoreLabel:Label;

        protected var background:Sprite;

        /** @inheritDoc */
        override protected function createChildren():void {
            mouseChildren = false;

            background = new Sprite();
            addChild(background);

            nameLabel = new Label();
            nameLabel.autoSize = TextFieldAutoSize.LEFT;
            addChild(nameLabel);

            scoreLabel = new Label();
            scoreLabel.autoSize = TextFieldAutoSize.LEFT;
            addChild(scoreLabel);
        }

        /** @inheritDoc */
        override protected function updateProperties():void {
            var name:String = _data == null ? "" : _data.name;
            var score:String = _data == null ? "" : "crashed: " + _data.crashCount + ", caused: "+ _data.causedCount;

            if (nameLabel != null) {
                nameLabel.text = name;
            }

            if (scoreLabel != null) {
                scoreLabel.text = score;
            }
        }

        /** @inheritDoc */
        override protected function layout():void {
            if (_width > 0 && _height > 0) {
                graphics.clear();

                var backgroundColor:uint = myStyles.backgroundColor == undefined ? 0 : myStyles.backgroundColor;
                graphics.beginFill(backgroundColor, 1);
                graphics.drawRect(0, 0, _width, _height);
                graphics.endFill();
            }

            nameLabel.width = _width * 0.4 - 8;
            nameLabel.move(8, Math.floor((_height - nameLabel.height) / 2));

            scoreLabel.width = _width * 0.6 - 8;
            scoreLabel.move(nameLabel.width + 16, Math.floor((_height - scoreLabel.height) / 2));
        }

        /** @inheritDoc */
        public function get data():Object {
            return _data;
        }

        /** @inheritDoc */
        public function set data(value:Object):void {
            _data = value;

            invalidateProperties();
        }

        /** @inheritDoc */
        public function set enabled(b:Boolean):void {
            alpha = b ? 1 : 0.75;
        }

        /** @inheritDoc */
        public function set selected(b:Boolean):void {
        }

        /** @inheritDoc */
        public function get selected():Boolean {
            return false;
        }

        /** @inheritDoc */
        public function get isReady():Boolean {
            return true;
        }
    }
}
