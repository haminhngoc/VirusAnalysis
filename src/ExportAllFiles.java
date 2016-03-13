import java.io.File;

public class ExportAllFiles {

	static StringBuilder bf = new StringBuilder();
	static String template = "java -jar BE-PUM.jar \"%s\"";

	public static void main(String[] args) {
		String folderName = "data";
		if (args.length > 0) {
			folderName = args[0];
		}
		if (args.length > 2) {
			template = args[1];
		}
		File folder = new File(folderName);
		traverseFiles(folder);
		System.out.print(bf);
	}

	static void traverseFiles(File folder) {
		if (!folder.isDirectory()) {
			return;
		}
		for (File file : folder.listFiles()) {
			if (file.isDirectory()) {
				traverseFiles(file);
			}
			else if (file.isFile()) {
				bf.append(String.format(template, file.getAbsolutePath()) + "\r\n");
			}
		}
	}
}
