public class DinoBits.Clock: Astal.Box {
	private uint interval;

	private Gtk.Label hour;
	private Gtk.Label minute;
	private Gtk.Label day;
    private Gtk.Label year;

	public Clock() {
        this.set_name("clock");
        this.add_css_class("clock");
        this.orientation = VERTICAL;
		interval = GLib.Timeout.add(15000, () => {
			this.update_clock();
			return GLib.Source.CONTINUE;
		});


		hour = new Gtk.Label("hour");
        hour.add_css_class("hour");
		minute = new Gtk.Label("minute");
        minute.add_css_class("minute");
		day = new Gtk.Label("day");
        day.add_css_class("day");
        year = new Gtk.Label("year");
        year.add_css_class("year");

		children.append(day);
		children.append(hour);
		children.append(minute);
        children.append(year);

		this.update_clock();
	}

	private void update_clock() {
		GLib.DateTime now = new GLib.DateTime.now_local();
		this.hour.label = now.format("%H");
		this.minute.label = now.format("%M");
		this.day.label = now.format("%d%m");
        this.year.label = now.format("%Y");
	}

    public override void dispose() {
        GLib.Source.remove(this.interval);
        base.dispose();
    }

    static construct {
        set_css_name("clock");
    }
}
