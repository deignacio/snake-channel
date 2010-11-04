package com.litl.snake.view {
    import com.litl.helpers.richinput.Stats;
    import com.litl.helpers.richinput.remotehandler.IRemoteHandler;
    import com.litl.helpers.richinput.stats.StatsRemoteHandler;
    import com.litl.helpers.richinput.stats.StatsStyle;
    import com.litl.sdk.service.LitlService;

    public class RemoteStats extends Stats implements IPausedView {
        public function RemoteStats(service:LitlService) {
            var style:StatsStyle = new StatsStyle();
            style.textFormat.color = 0xdfdfdf;
            style.background = true;
            style.showDot = false;

            super(service, style);
            x = 450;
            y = 475;
        }

        public function refresh():void {
        }
    }
}
