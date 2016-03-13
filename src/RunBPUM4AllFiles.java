import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.lang.ProcessBuilder.Redirect;
import java.util.*;
import java.util.concurrent.*;

public class RunBPUM4AllFiles {

	static ArrayList<String> commands = new ArrayList<String>();
	static String template = " -jar \"%s\\BE-PUM.jar\" \"%s\"";
	static String workingdirectory = System.getProperty("user.dir");

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

		System.out.println(workingdirectory);

		for (String command : commands) {
			System.out.println(command);
			Process pr = null;
			try {
				//				Runtime rt = Runtime.getRuntime();
				//				pr = rt.exec(command);
				ProcessBuilder pb = new ProcessBuilder("\"C:\\Program Files\\Java\\jre1.8.0_73\\bin\\java\"", command);
				pb.directory(new File(workingdirectory));
				pb.redirectOutput(Redirect.INHERIT);
				pb.redirectError(Redirect.INHERIT);
				pb.redirectInput(Redirect.INHERIT);
				pr = pb.start();

				pr.waitFor(15, TimeUnit.SECONDS);

				//				String line;
				//
				//				BufferedReader error = new BufferedReader(new InputStreamReader(pr.getErrorStream()));
				//				while ((line = error.readLine()) != null) {
				//					System.out.println(line);
				//				}
				//				error.close();
				//
				//				BufferedReader input = new BufferedReader(new InputStreamReader(pr.getInputStream()));
				//				while ((line = input.readLine()) != null) {
				//					System.out.println(line);
				//				}
				//
				//				input.close();

			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (pr != null) {
					pr.destroyForcibly();
				}
				pr = null;
			}
		}
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
				commands.add(String.format(template, workingdirectory, file.getAbsolutePath()));
			}
		}
	}
}
