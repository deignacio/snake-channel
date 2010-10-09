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
    import com.litl.helpers.richinput.remotehandler.IRemoteHandler;
    import com.litl.helpers.richinput.remotehandler.IRemoteHandlerFactory;

    /**
     * used by the game model to create new player objects
     * for new remotes
     *
     * @see com.litl.helpers.richinput.remotehandler.RemoteHandlerManager
     * @see com.litl.snake.model.Player
     */
    public class PlayerFactory implements IRemoteHandlerFactory {
        public static const INVALID_PLAYER_ID:int = -1;

        private var nextPlayerId:int = INVALID_PLAYER_ID;

        /** @inheritDoc */
        public function createHandler():IRemoteHandler {
            return new Player(++nextPlayerId);
        }

        /** @inheritDoc */
        public function get klass():Class {
            return Player;
        }
    }
}
