namespace Get {
	extern void library_path (string so_path, void *addr);
}

namespace LAview.ObjectExample {

	class AppDirs : Object {

		public static File so_path;
		public static File exec_dir;
		public static File common_dir;
		public static string ui_dir;
		public static string settings_dir;

		public static void init () {
			char _so_path[256];
			Get.library_path ((string)_so_path, (void*)init);
			so_path = File.new_for_path ((string)_so_path);
			exec_dir = so_path.get_parent ();
			common_dir = exec_dir.get_parent ();
			common_dir = common_dir.get_parent().get_parent();
			ui_dir = Path.build_path (Path.DIR_SEPARATOR_S, common_dir.get_path(),
			                          "share/laview-object-example-"+Config.VERSION_MAJOR.to_string()+"/ui");
			stdout.printf ("Vala:so_path=%s\n", so_path.get_path());
			settings_dir = Path.build_path (Path.DIR_SEPARATOR_S, common_dir.get_path(), "share/glib-2.0/schemas");
			stdout.printf ("ui_dir = %s\n", ui_dir);
			stdout.printf ("settings_dir = %s\n", settings_dir);

		}

		public static void terminate () {
		}
	}
}
