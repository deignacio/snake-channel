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
    import com.litl.snake.enum.ArenaSize;
    import com.litl.snake.enum.PlayerDirection;

    import flash.utils.Dictionary;

    /**
     * the arena has several responsibilities:
     * <li>tracking the size of the arena
     *
     * @see com.litl.snake.model.PlayerPosition
     */
    public class ArenaModel {
        private var _size:ArenaSize = null;
        private var spots:Dictionary;

        public function ArenaModel(size:ArenaSize) {
            this.size = size;
        }

        /** the arena size of the arena */
        public function get size():ArenaSize {
            return _size;
        }

        /** if the size changes, triggers a reset of the arena */
        public function set size(value:ArenaSize):void {
            if (_size != value) {
                _size = value;

                reset();
            }
        }

        /** clear the internal spots dictionary */
        public function reset():void {
            spots = new Dictionary();
        }

        /** keep looking for a random unoccupied spot, and assign it */
        public function enterArena(player:Player):void {
            var spot:int = Math.random() * size.numSpots;
            while (isOccupied(spot)) {
                spot = Math.random() * size.numSpots;
            }
            moveToSpot(player, spot);
        }

        /** when leaving, a player's claimed spots are removed */
        public function leaveArena(player:Player):void {
            var unclaimSpot:Function = function(spot:int, claimer:Player):void {
                if (player.id == claimer.id) {
                    delete spots[String(spot)];
                }
            };

            forEachSpot(unclaimSpot);
        }

        /** convert an external player position to the internal spot format */
        protected function toSpot(pos:PlayerPosition):int {
            return pos.x + pos.y * size.cols;
        }

        /** convert an internal spot to an external player position */
        protected function toPosition(spot:int):PlayerPosition {
            return new PlayerPosition(spot % size.cols, spot / size.cols);
        }

        /** moves a player to a spot, and claims it */
        protected function moveToSpot(player:Player, spot:int):void {
            player.position.x = spot % size.cols;
            player.position.y = spot / size.cols;

            spots[String(spot)] = player;
        }

        /** returns if the spot specified is claimed/occupied */
        protected function isOccupied(spot:int):Boolean {
            return spots[String(spot)] != null;
        }

        /**
         * like Array.forEach, takes a function and applies
         * it to all claimed spots in the arena.
         *
         * the function is expected to have the signature:
         * function(spot:String, player:Player):void;
         *
         * where spot is the internal spot in the arena, player is
         * the player that claimed that spot
         */
        protected function forEachSpot(func:Function):void {
            if (func != null) {
                for (var spot:String in spots) {
                    func(int(spot), spots[spot] as Player);
                }
            }
        }

        /**
         * like Array.forEach, takes a function and applies
         * it to all claimed spots in the arena.
         *
         * the function is expected to have the signature:
         * function(pos:PlayerPosition, player:Player):void;
         *
         * where pos is the position in the arena, player is
         * the player that claimed that spot
         */
        public function forEachPosition(func:Function):void {
            if (func != null) {
                for (var spot:String in spots) {
                    func(toPosition(int(spot)), spots[spot] as Player);
                }
            }
        }
    }
}
