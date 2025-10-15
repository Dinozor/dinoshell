class DinoBits.App: Astal.Application {
	static App instance;

	private DinoBits.Bar bar;
    private string css_dir;
    private string css_path;
    private Gtk.CssProvider css_provider;
    private GLib.FileMonitor css_file_monitor;

	//public override void request(string msg, SocketConnection conn) {
	//	AstalIO.write_sock.begin(conn, @"missing response implementation on $instance_name");
	//}

	public override void activate() {
		base.activate();
		if (AstalRiver.get_default() == null) {
			GLib.warning("could not connect to river.\n");
		}

        string exe_path = GLib.FileUtils.read_link("/proc/self/exe");
        css_dir = Path.get_dirname(exe_path);
        css_path = Path.build_filename(css_dir, "style.css");

		css_provider = new Gtk.CssProvider();
        css_provider.load_from_path(css_path);
		Gtk.StyleContext.add_provider_for_display(Gdk.Display.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        monitor_css();

		bar = new DinoBits.Bar();
		add_window(bar);
		this.hold();
	}


    private void monitor_css() {
        // --- Watch CSS file for changes ---
        try {
            var dir = File.new_for_path(css_dir);
            css_file_monitor = dir.monitor_directory(FileMonitorFlags.NONE, null);
            GLib.warning("CSS_file_monitor: %s", dir.get_path());
            css_file_monitor.changed.connect((monitored, child, event) => {
                string child_path = child != null ? child.get_path() : "(null)";
                string event_name = event.to_string();

                GLib.warning(
                    "📂 FileMonitor event:\n" +
                    "  • Path: %s\n" +
                    "  • Event: %s (%d)\n" +
                    "  • Monitor: %s\n",
                    child_path,
                    event_name,
                    (int) event,
                    monitored.get_path() ?? "(no description)"
                );
                if (monitored.get_basename() == "style.css") {
                    GLib.warning("reloading css...\n");
                    css_provider.load_from_path(monitored.get_path());
                }

                // if (event == FileMonitorEvent.CHANGES_DONE_HINT ||
                //     event == FileMonitorEvent.CHANGED ||
                //     event == FileMonitorEvent.MOVED_IN ||
                //     event == FileMonitorEvent.CREATED ||
                //     event == FileMonitorEvent.MOVED_OUT) {
                //     GLib.warning("Reloading CSS...\n");
                //     css_provider.load_from_path(css_dir);
                // }
            });
        } catch (Error e) {
            GLib.warning("Could not monitor CSS file: %s", e.message);
        }
    }


	private App() {
		application_id = "com.dinobits.dinoshell";
	}

	static int main(string[] args) {
		App.instance = new App();
		Environment.set_prgname("dinoshell");

		return App.instance.run(args);
	}
}
