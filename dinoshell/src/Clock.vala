public class DinoBits.Clock: Astal.Box {
	private uint interval;

	private Gtk.Label hour;
	private Gtk.Label minute;
	private Gtk.Label day;

	public Clock() {
		interval = GLib.Timeout.add(15000, () => {
			this.update_clock();
			return GLib.Source.CONTINUE;
		});

		hour = new Gtk.Label("hour");
		minute = new Gtk.Label("minute");
		day = new Gtk.Label("day");

		children.append(minute);
		children.append(hour);
		children.append(day);

		this.update_clock();
	}

	private void update_clock() {
		GLib.DateTime now = new GLib.DateTime.now_local();
		this.hour.label = now.format("%H");
		this.minute.label = now.format("%M");
		this.day.label = now.format("%d%m");
	}

}
