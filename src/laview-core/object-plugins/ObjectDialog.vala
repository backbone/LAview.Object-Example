namespace LAview.ObjectExample {
	using Gtk, LAview;

	public class MainDialog : Object {
		Dialog dialog;
		PreferencesDialog preferences_dialog;

		public bool composed { get; private set; default = false; }

		public MainDialog (Object parent) throws Error {
			var builder = new Builder ();
			builder.add_from_file (AppDirs.ui_dir + "/laview-object-example.glade");
			builder.connect_signals (this);

			dialog = builder.get_object ("object_example_dialog") as Dialog;
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
			composed = false;
			dialog.run ();
		}

		[CCode (instance_pos = -1)]
		public void button_apply_clicked (Button button) {
			composed = true;
		}

		[CCode (instance_pos = -1)]
		public void button_ok_clicked (Button button) {
			composed = true;
			dialog.hide ();
		}

		[CCode (instance_pos = -1)]
		public void button_cancel_clicked (Button button) {
			dialog.hide ();
		}

		[CCode (instance_pos = -1)]
		public void button_preferences_clicked (Button button) {
			if (preferences_dialog == null)
				try {
					preferences_dialog = new PreferencesDialog (dialog);
				} catch (Error err) {
					var msg = new MessageDialog (dialog, DialogFlags.MODAL, MessageType.ERROR,
					                             ButtonsType.CLOSE, _("Error: ")+err.message);
					msg.response.connect ((response_id) => { msg.destroy (); } );
					msg.show ();
				}
			preferences_dialog.show_all ();
		}
	}
}
