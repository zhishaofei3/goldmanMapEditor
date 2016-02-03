package {

import flash.display.MovieClip;
import flash.utils.getQualifiedClassName;
import flash.events.Event;
import flash.events.SecurityErrorEvent;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.net.URLRequestMethod;
import com.adobe.serialization.json.JSON;

public class Main extends MovieClip {
    var levelArr:Array = [];

    public function Main() {
        var totalFrames:int = this.totalFrames;
        for (var i:int = 1; i <= totalFrames; i++) {
            gotoAndStop(i);
            ss();
        }
        postData();
    }

    private function ss() {
        var arr:Array = [];
        for (var i = 0; i < this.numChildren; i++) {
            var mc:MovieClip = this.getChildAt(i) as MovieClip;
            if (mc) {
                var objX:int = mc.x;
                var objY:int = mc.y;
                var objName:String = getQualifiedClassName(mc);
                var o:Object = {x: objX, y: objY, name: objName};
                arr.push(o);
            }
        }
        var goal:String = this.goal_txt.text || '0';
        levelArr.push({objsArr:arr, goal:goal});
    }

    private function postData():void {
        var s:String = JSON.stringify(levelArr);
        var variables:URLVariables = new URLVariables();
        variables.levelData = s;
        var request:URLRequest = new URLRequest("http://127.0.0.1:3000/level");
        request.data = variables;
        request.method = URLRequestMethod.POST;
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, completeHandler);
        urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        urlLoader.load(request);
    }

    private function completeHandler(e:Event):void {
        var loader:URLLoader = URLLoader(e.target);
        trace("completeHandler: " + loader.data);
    }

    private function securityErrorHandler(e:SecurityErrorEvent):void {
        trace("securityErrorHandler");
    }

    private function ioErrorHandler(e:IOErrorEvent):void {
        trace("ioErrorHandler");
    }
}
}