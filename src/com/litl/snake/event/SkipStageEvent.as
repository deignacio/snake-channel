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
     * Dispatch this event when a IGameLoopMember wants to control
     * the skipping of game loop stages in the game loop.
     *
     * @see com.litl.snake.controls.GameLoop
     * @see com.litl.snake.controls.IGameLoopMember
     */
    public class SkipStageEvent extends Event {
        /** this event wants to start skipping stages */
        public static const SKIP_STAGE:String = "skip-stage";

        /** this event wants to stop skipping some stages */
        public static const UNSKIP_STAGE:String = "unskip-stage";

        /** the stage to be skipped/unskipped */
        public var stage:String;

        public function SkipStageEvent(type:String, stage:String) {
            super(type);

            this.stage = stage;
        }

        /** @inheritDoc */
        override public function clone():Event {
            return new SkipStageEvent(type, stage);
        }
    }
}
