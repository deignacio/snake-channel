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
    import com.litl.snake.controls.PlayerDirectionKeypad;
    import com.litl.snake.enum.PlayerDirection;

    /**
     * represents a player in the game.
     * <li>has a keypad remote handler for control
     * <li>the player's position
     * <li>the player's direction
     */
    public class Player extends KeypadRemoteHandler implements IRemoteHandler {
        private var _id:int;

        private var _dir:String = null;

        /** the player's position */
        public var position:PlayerPosition = new PlayerPosition();

        public function Player(id:int) {
            super();

            _id = id;
        }

        public function get id():int {
            return _id;
        }

        /** the direction the player is facing/moving */
        public function get direction():String {
            return _dir;
        }

        /**
         * Ensure that only valid values are accepted.
         *
         * @param value the new direction
         * @see com.litl.snake.enum.PlayerDirection PlayerDirection
         */
        public function set direction(value:String):void {
            switch (value) {
                case PlayerDirection.NORTH:
                case PlayerDirection.SOUTH:
                case PlayerDirection.WEST:
                case PlayerDirection.EAST:
                    _dir = value;
                    break;
            }
        }

        /**
         * use a PlayerDirectionKeypad, automatically start it
         *
         * @inheritDoc
         */
        override protected function createKeypad(accelerometer:Accelerometer):AccelerometerKeypad {
            var keypad:AccelerometerKeypad = new PlayerDirectionKeypad(accelerometer);
            keypad.start();
            return keypad;
        }

        /** checks the player's keypad, changes direction if appropriate */
        public function checkKeypad():void {
            switch (direction) {
                case PlayerDirection.NORTH:
                case PlayerDirection.SOUTH:
                    if (keypad.isButtonPressed(PlayerDirection.EAST)) {
                        direction = PlayerDirection.EAST;
                    } else if (keypad.isButtonPressed(PlayerDirection.WEST)) {
                        direction = PlayerDirection.WEST;
                    }
                    break;
                case PlayerDirection.WEST:
                case PlayerDirection.EAST:
                    if (keypad.isButtonPressed(PlayerDirection.NORTH)) {
                        direction = PlayerDirection.NORTH;
                    } else if (keypad.isButtonPressed(PlayerDirection.SOUTH)) {
                        direction = PlayerDirection.SOUTH;
                    }
                    break;
                default:
                    direction = PlayerDirection.NORTH;
                    break;
            }
        }
    }
}
