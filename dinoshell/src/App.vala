class DinoBits.App: Astal.Application {
	static App instance;

	private DinoBits.Bar bar;

	//public override void request(string msg, SocketConnection conn) {
	//	AstalIO.write_sock.begin(conn, @"missing response implementation on $instance_name");
	//}

	public override void activate() {
		base.activate();
		if (AstalRiver.get_default() == null) {
			GLib.warning("could not connect to river.\n");
		}

		var provider = new Gtk.CssProvider();
		var file = GLib.File.new_for_path("style.css");
		provider.load_from_file(file);
		//provider.load_from_resource("/tmp/style.css");
		Gtk.StyleContext.add_provider_for_display(Gdk.Display.get_default(), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
		bar = new DinoBits.Bar();
		add_window(bar);
		this.hold();
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
