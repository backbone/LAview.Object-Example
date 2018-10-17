namespace LAview.ObjectExample {

	public class AppSettings : Object {
		Settings settings;

		string _greeting = "lyx";

		public string greeting {
			get { return _greeting; }
			set {
				if (settings != null) settings.set_string ("greeting", value);
				_greeting = value;
			}
		}

		public AppSettings () throws Error {
			string schema_file = AppDirs.settings_dir+"/gschemas.compiled";
			if (!File.new_for_path (schema_file).query_exists ())
				throw new IOError.NOT_FOUND ("File "+schema_file+" not found");
			SettingsSchemaSource sss = new SettingsSchemaSource.from_directory (AppDirs.settings_dir, null, false);
			string schema_name = "ws.backbone.laview.object-example-"+Config.VERSION_MAJOR.to_string();
			SettingsSchema schema = sss.lookup (schema_name, false);
			if (schema == null) {
				throw new IOError.NOT_FOUND ("Schema "+schema_name+" not found in "+schema_file);
			}
			settings = new Settings.full (schema, null, null);

			_greeting = settings.get_string("greeting");
			settings.changed["greeting"].connect (() => {
				_greeting = settings.get_string("greeting");
			});
		}
	}
}
