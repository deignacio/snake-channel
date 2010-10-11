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
package com.litl.snake.event {
    import flash.events.Event;

    /**
     * dispatched when a crash scene begins and ends
     * this is used to let IGameView objects let the
     * game view manager to start skipping move/draw/cleanup
     * stages to let the tween/animations complete
     *
     * @see com.litl.snake.view.GameViewManager GameViewManager
     * @see com.litl.snake.controls.GameLoop
     */
    public class CrashSceneEvent extends Event {
        public static const BEGIN:String = "begin";
        public static const END:String = "end";

        public function CrashSceneEvent(type:String) {
            super(type);
        }

        /** @inheritDoc */
        override public function clone():Event {
            return new CrashSceneEvent(type);
        }
    }
}
