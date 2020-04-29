using LAview, Core, GObject.Plugins;

extern const string GETTEXT_PACKAGE;

namespace LAview.ObjectExample {
	/**
	 * Object Plugin Example.
	 */
	public class Plugin : PluginObject {

		MainDialog object_dialog = null;
		ObjectExample.PreferencesDialog preferences_dialog = null;
		AppSettings settings;

		/**
		 * Constructs a new ``Plugin``.
		 */
		construct {
			stdout.puts ("ObjectExample.Plugin init () called\n");
			AppDirs.init ();
			try {
				settings = new AppSettings();
			} catch (Error err) {
				stderr.printf("Error: %s\n", err.message);
			}
		}

		/**
		 * Destroys the ``Plugin``.
		 */
		~Plugin () {
			stdout.puts ("ObjectExample.Plugin deinit () called\n");
			AppDirs.terminate();
		}

		/**
		 * Gets a name of the plugin.
		 */
		public override string get_name () {
			return "ProtObjEx";
		}

		/**
		 * Gets readable name of the plugin.
		 */
		public override string get_readable_name () {
			stdout.puts ("ObjectExample.Plugin.get_readable_name () called\n");
			stdout.puts ("Call IHostCore.get_cache_dir () from ObjectExample.Plugin:\n  ");
			var h = host as IHostCore;
			assert (h != null);
			var cache_dir = h.get_cache_dir ();
			stdout.printf ("cache dir = %s\n", cache_dir);
			return _("Protocol Object Example");
		}

		/**
		 * Compose the object.
		 */
		public override bool compose (Object parent, Gee.HashMap<string, AnswerValue> answers) throws Error {
			if (object_dialog == null) object_dialog = new MainDialog (parent);

			object_dialog.show_all ();

			var h = host as IHostCore;
			assert (h != null);
			var data_obj_ex = h.get_data_object ("DataExample") as LAview.DataExample.Plugin;

			stdout.puts ("Compose() called\n");

			foreach (var a in answers.entries) {
				switch (a.key) {
					case "MainChart":
						break;

					case "arr1d":
						if (a.value is AnswerArray1D)
							((AnswerArray1D)a.value).value = data_obj_ex.get_array1d_data (a.key);
						break;

					case "arr2d":
						if (a.value is AnswerArray2D)
							((AnswerArray2D)a.value).value = data_obj_ex.get_array2d_data (a.key);
						break;

					case "AnotherRequest":
					case "SampleRequest":
					case "Manual.SampleRequest":
						if (a.value is AnswerString)
							((AnswerString)a.value).value = data_obj_ex.get_string_data (a.key);
						break;

					default:
						break;
				}
			}

			return object_dialog.composed;
		}

		/**
		 * Open Preferences.
		 */
		public override void preferences (Object parent) throws Error {
			if (preferences_dialog == null) preferences_dialog = new ObjectExample.PreferencesDialog (parent);

			preferences_dialog.show_all ();
		}
	}
}

[ModuleInit]
public Type plugin_init (GLib.TypeModule type_module) {
	stdout.puts ("---ModuleInit called()---\n");
	return typeof (LAview.ObjectExample.Plugin);
}
