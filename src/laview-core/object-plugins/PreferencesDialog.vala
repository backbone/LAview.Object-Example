namespace LAview.ObjectExample {
	using Gtk, LAview;

	public class PreferencesDialog : GLib.Object {
		Dialog dialog;

		public bool apply { get; private set; default = false; }

		public PreferencesDialog (Object parent) throws Error {
			var builder = new Builder ();
			builder.add_from_file (AppDirs.ui_dir + "/laview-object-example.glade");
			builder.connect_signals (this);

			dialog = builder.get_object ("preferences_dialog") as Dialog;
			if (parent is Window) {
				dialog.destroy_with_parent = true;
				dialog.transient_for = parent as Window;
				dialog.modal = true;
				dialog.delete_event.connect ((source) => {
					dialog.hide_on_delete();
					return true;
				});
			}
		}

		public void show_all () {
			apply = false;
			dialog.run ();
		}

		[CCode (instance_pos = -1)]
		public void button_apply_clicked (Button button) {
			apply = true;
		}

		[CCode (instance_pos = -1)]
		public void button_ok_clicked (Button button) {
			apply = true;
			dialog.hide ();
		}

		[CCode (instance_pos = -1)]
		public void button_cancel_clicked (Button button) {
			dialog.hide ();
		}
	}
}
