using AstalHyprland;

public class DinoBits.WorkspaceMap: Astal.Box {
    private AstalHyprland.Hyprland hypr;
    // private Dictionary<int, Gtk.Label> labels;

    public WorkspaceMap() {
        orientation = Gtk.Orientation.VERTICAL;
        hypr = AstalHyprland.get_default();
        if (null == hypr) {
            GLib.warning("Hyprland not found");
            return;
        }

        hypr.workspace_added.connect(on_workspace_added);
        hypr.workspace_removed.connect(on_workspace_removed);

        hypr.event.connect(on_event);

        // hypr.notify["focused-workspace"].connect(() => recreate_map());
        // hypr.notify.connect((pspec) => {
        //     GLib.warning("Notify: %s", pspec.get_name());
        //     });

        recreate_map();
    }

    private void test(GLib.ParamSpec pspec) {

    }

    private void recreate_map() {
        foreach (var child in children)
            remove(child);

        foreach (var ws in hypr.workspaces) {
            var label = new Gtk.Label(ws.name ?? ws.id.to_string());
            if (ws.id == hypr.focused_workspace.id)
                label.add_css_class("active");
            append(label);
        }
    }

    private void on_workspace_added(Workspace workspace) {
        // var label = new Gtk.Label(workspace.id.to_string());
        // append(label);
        recreate_map();
    }

    private void on_event(string event, string args) {
        // GLib.warning("Hyprland even: %s; args: %s", event, args);
        switch (event) {
            case "workspacev2":
                recreate_map();
                break;
        }
    }

    private void on_workspace_removed(int id) {
        recreate_map();
    }

    static construct {
        set_css_name("workspace-map");
    }
}
