public class DinoBits.Bar: Astal.Window {
	// public AstalRiver.Output output { get; private set; }
	public string clock { get; private set; }

	// unowned Gtk.Popover popover;
	// unowned Gtk.Calendar calendar;

	public Bar() {
		anchor = TOP | LEFT | BOTTOM;
		exclusivity = EXCLUSIVE;

        var center_box = new Gtk.CenterBox ();
        center_box.orientation = VERTICAL;
        child = center_box;
		var c = new DinoBits.Clock();
        center_box.end_widget = c;

        var w = new DinoBits.WorkspaceMap ();
        center_box.center_widget = w;

		present();
	}

    static construct {
        set_css_name("bar");
    }
}

