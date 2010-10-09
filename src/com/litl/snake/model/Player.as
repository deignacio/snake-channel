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
package com.litl.snake.model {
    import com.litl.helpers.richinput.keypad.AccelerometerKeypad;
    import com.litl.helpers.richinput.remotehandler.IRemoteHandler;
    import com.litl.helpers.richinput.remotehandler.KeypadRemoteHandler;
    import com.litl.sdk.richinput.Accelerometer;

    public class Player extends KeypadRemoteHandler implements IRemoteHandler {
        private var _id:int;

        public function Player(id:int) {
            super();

            _id = id;
        }

        override protected function createKeypad(accelerometer:Accelerometer):AccelerometerKeypad {
            var keypad:AccelerometerKeypad = new AccelerometerKeypad(accelerometer);
            keypad.start();
            return keypad;
        }
    }
}
