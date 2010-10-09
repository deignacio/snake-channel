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
package com.litl.snake.controls {
    import com.litl.helpers.enum.AccelerometerAxis;
    import com.litl.helpers.richinput.keypad.AccelerometerKeypad;
    import com.litl.helpers.richinput.keypad.KeypadButtonBase;
    import com.litl.helpers.richinput.keypad.KeypadButtonInterval;
    import com.litl.sdk.richinput.Accelerometer;
    import com.litl.snake.enum.PlayerDirection;

    /**
     * An AccelerometerKeypad with buttons pre-registered for the
     * different PlayerDirection values.
     *
     * @see com.litl.snake.enum.PlayerDirection PlayerDirection
     * @see com.litl.helpers.richinput.keypad.AccelerometerKeypad AccelerometerKeypad
     */
    public class PlayerDirectionKeypad extends AccelerometerKeypad {
        /** the minimum magnitude for an accelerometer value to press a button */
        public static const MIN_THRESHOLD:Number = 0.4;

        /** the maximum magnitude for an accelerometer value to press a button */
        public static const MAX_THRESHOLD:Number = 3.0;

        public function PlayerDirectionKeypad(accel:Accelerometer) {
            super(accel);

            // register the "up" or "north" button
            this.registerButton(new KeypadButtonBase(PlayerDirection.NORTH,
                [ new KeypadButtonInterval(AccelerometerAxis.Y,
                    MIN_THRESHOLD, MAX_THRESHOLD) ]));

            // register the "down"/"south" button
            this.registerButton(new KeypadButtonBase(PlayerDirection.SOUTH,
                [ new KeypadButtonInterval(AccelerometerAxis.Y,
                -1 * MAX_THRESHOLD, -1 * MIN_THRESHOLD) ]));

            // right/east
            this.registerButton(new KeypadButtonBase(PlayerDirection.EAST,
                [ new KeypadButtonInterval(AccelerometerAxis.X,
                    MIN_THRESHOLD, MAX_THRESHOLD) ]));

            // left/west
            this.registerButton(new KeypadButtonBase(PlayerDirection.WEST,
                [ new KeypadButtonInterval(AccelerometerAxis.X,
                    -1 * MAX_THRESHOLD, -1 * MIN_THRESHOLD) ]));
        }
    }
}
