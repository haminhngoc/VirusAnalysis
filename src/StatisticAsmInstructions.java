import java.io.*;
import java.util.*;

public class StatisticAsmInstructions {

	public static void main(String[] args) {
		String folder = args.length > 0 ? args[0] : "./";
		File folderFile = new File(folder);

		File[] files = new File[0];
		if (folderFile.isDirectory()) {
			files = folderFile.listFiles();
		} else if (folderFile.isFile()) {
			files = new File[]{folderFile};
		}

		for (File file : files) {
			parseFile(file);
		}
	}

	static void parseFile(File file) {

	}

	static class Instruction {
		public String fullIns;
		public String file;
		public int count;
	}

	static void write(List<Instruction> instructions, String fileName) {

	}
}
