using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as Act;

class PTGWatchView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {

        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [getHour(), clockTime.min.format("%.2d")]);
        var secString = clockTime.sec.format("%.2d");
        var view = View.findDrawableById("TimeLabel");
        var seconds = View.findDrawableById("Seconds");
        var nowInfo = Gregorian.info(Time.now(),Time.FORMAT_MEDIUM);
        var dateStr = nowInfo.day_of_week + " " + nowInfo.month + " " + nowInfo.day;
        var date = View.findDrawableById("Date");
        var battery = Sys.getSystemStats().battery.toString();
        var battString = View.findDrawableById("Battery");
        var stepOut = View.findDrawableById("Steps");
        var actInfo = Act.getInfo();
        var steps = actInfo.steps;
        var sbr = View.findDrawableById("SBR");

        view.setText(timeString);
        
        seconds.setText(clockTime.sec.format("%02d"));   

        date.setText(dateStr);        

        battString.setText("Battery: " + battery.substring(0, 2)+"%");
        
        stepOut.setText("Steps: " + steps.toString());        

        sbr.setText("SWIM - BIKE - RUN");      

        View.onUpdate(dc);
        
        var image = Ui.loadResource(Rez.Drawables.Smiley);
        dc.drawBitmap(00,00,image);
    }


    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }
    
    function getHour(){
    var result,hour,time;
	var settings = Sys.getDeviceSettings();
    var ampm = settings.is24Hour;    
    
    time = Sys.getClockTime();
    
    	if(ampm){
    		result = time.hour;
    		Sys.println("24");
    	}else{
    		hour = time.hour;
    			if(hour > 12){
    				hour = (hour % 12);
    				if(hour == 0){
    					hour = 12;
    				}
    			
    				result = hour;
    			}
    		result = hour;

    	}
    	if(result < 10){
    		result = result.format("%01d");
    	}else{
    		result = result;
    	}
    	
    	return result;
    		
    }

}
