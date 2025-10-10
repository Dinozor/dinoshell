public class DinoBits.Bar: Astal.Window {
	public AstalRiver.Output output { get; private set; }
	public string clock { get; private set; }
	uint interval;

	unowned Gtk.Popover popover;
	unowned Gtk.Calendar calendar;

	public Bar() {
		anchor = TOP | LEFT | RIGHT;
		exclusivity = EXCLUSIVE;
		set_css_name("bar");

		AstalRiver.River river = null; AstalRiver.get_default ();
		if (river != null) {
			//this.output = river.get_output(gdkmonitor.get_connector());
			//if (this.output == null) {
			//	river.output_added.connect((riv, name) => {
			//		if (name == gdkmonitor.get_connector()) {
			//			this.output = river.get_output(name);
			//		}
			//	});
			//}
			foreach (var o in river.get_outputs ()) {
				stdout.printf("%s\n", o.name);
			}
		}
		
		//GLib.warning ("CLocl!");
		//
		//// clock
		//clock = new DateTime.now_local().format("%H:%M:%S");
		//interval = Timeout.add(1000, () => {
		//	clock = new DateTime.now_local().format("%H:%M:%S");
		//	GLib.warning(clock.to_string());
		//	return Source.CONTINUE;
		//}, Priority.DEFAULT);
		//
		//popover.notify["visible"].connect(() => {
		//          if (popover.visible) {
		//              calendar.select_day(new DateTime.now_local());
		//          }
		//      });

		var c = new DinoBits.Clock();
		child = c;
		//var button = new Gtk.Button.with_label ("Click me!");
		//button.clicked.connect (() => {
		//    button.label = "Thank you";
		//});
		//child = button;
		//add_css_class("bar");
		present();
	}
}

