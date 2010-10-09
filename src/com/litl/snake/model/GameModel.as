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
    import com.litl.helpers.richinput.remotehandler.RemoteHandlerManager;
    import com.litl.sdk.richinput.IRemoteControl;
    import com.litl.sdk.service.LitlService;
    import com.litl.snake.enum.ArenaSize;
    import com.litl.snake.enum.ArenaWrap;

    public class GameModel extends RemoteHandlerManager {
        private var crashes:Array;

        /** the arena */
        public var arena:ArenaModel;

        public function GameModel(service:LitlService) {
            super(service, new PlayerFactory());
            crashes = new Array();

            arena = new ArenaModel(ArenaSize.MEDIUM, ArenaWrap.WRAP_YES);

            start();
        }

        protected function resetGame():void {
            crashes = new Array();

            arena.reset();
            forEachPlayer(arena.enterArena);
        }

        /**
         * builds the player object, and enters the arena
         *
         * @inheritDoc
         */
        override protected function onRemoteConnected(remote:IRemoteControl, handler:IRemoteHandler):void {
            var player:Player = handler as Player;
            arena.enterArena(player);
        }

        /**
         * removes the player from the arena
         *
         * @inheritDoc
         */
        override protected function onRemoteDisconnected(remote:IRemoteControl, handler:IRemoteHandler):void {
            var player:Player = handler as Player;
            arena.leaveArena(player);
        }

        public function forEachPlayer(func:Function):void {
            var outer:Function = function(handler:IRemoteHandler):void {
                func(handler as Player);
            };
            forEachHandler(outer);
        }

        protected function oneTurn():void {
            if (crashes.length) {
                return;
            }

            forEachPlayer(onePlayer);
            if (crashes.length) {
                // do some crash stuff
                resetGame();
            }
        }

        private function onePlayer(player:Player):void {
            player.checkKeypad();
            if (arena.advancePlayer(player)) {
                crashes.push(player);
            }
        }
    }
}
