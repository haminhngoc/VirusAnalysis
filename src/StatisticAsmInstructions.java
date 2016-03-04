import java.io.*;
import java.text.*;
import java.util.*;

public class StatisticAsmInstructions {

	static PrintStream console = System.out;
	static Scanner consoleReader = new Scanner(System.in);

	static String folderName = "./asm";
	static String outFileName = getCurrentTimeStamp() + ".asmout";

	static HashMap<String, HashMap<String, Instruction>> instructionMap = new HashMap<String, HashMap<String, Instruction>>();
	static HashMap<String, Instruction> allInstructionMap = new HashMap<String, Instruction>();

	static public void main(String[] args) {

		if (args.length > 0) {
			folderName = args[0];
		}

		File folderFile = new File(folderName);

		File[] files = new File[0];
		if (folderFile.isDirectory()) {
			files = folderFile.listFiles();
		} else if (folderFile.isFile()) {
			files = new File[]{folderFile};
		} else {
			showExitMessage("Folder or file does not exist: " + folderName + ".");
			return;
		}

		files = (File[]) Arrays.stream(files).filter(file -> file.getName().endsWith(".asm")).toArray();

		if (files.length == 0) {
			showExitMessage("There is not any asm file in " + folderName + ".");
			return;
		}

		if (args.length > 1) {
			outFileName = args[1];
		}
		File outFile = new File(outFileName);
		if (!outFile.isFile() || !outFile.canWrite()) {
			showExitMessage("Can't create or write to file: " + outFileName + ".");
			return;
		}

		BufferedWriter outFileWriter = null;
		try {
			outFileWriter = new BufferedWriter(new FileWriter(outFile, true));
		} catch (IOException ex) {
			ex.printStackTrace();
			return;
		}

		for (int i = 0; i < files.length; i++) {
			File file = files[i];
			try {
				String fileName = file.getName();
				console.println("Parsing file: " + fileName + "(" + i + "/" + files.length + ")");
				parseFile(file.getAbsolutePath(), fileName);

				if (i % 10 == 0) {
					outFileWriter.flush();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

		try {
			outFileWriter.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	static void parseFile(String filePath, String fileName) throws IOException {
		BufferedReader fileReader = new BufferedReader(new FileReader(filePath));

		HashMap<String, Instruction> fileMap = instructionMap.get(fileName);
		if (fileMap == null) {
			fileMap = new HashMap<String, Instruction>();
			instructionMap.put(fileName, fileMap);
		}

		String line;
		while ((line = fileReader.readLine()) != null) {
			int i = line.indexOf(":\t");
			String insText = line.substring(i + 2, line.length()).trim();

			Instruction instruction = fileMap.get(insText);
			if (instruction == null) {
				instruction = new Instruction(insText, fileName);
				fileMap.put(fileName, instruction);
			}
			instruction.count++;

			instruction = allInstructionMap.get(insText);
			if (instruction == null) {
				instruction = new Instruction(insText, fileName);
				allInstructionMap.put(fileName, instruction);
			}
			instruction.count++;
		}

		fileReader.close();
	}

	static StringBuffer getText(HashMap<String, Instruction> instructionMap) {
		StringBuffer bf = new StringBuffer();

		Collection<Instruction> values = instructionMap.values();
		Instruction[] instructions = values.toArray(new Instruction[values.size()]);
		Arrays.sort(instructions, (i1, i2) -> i1.insText.compareTo(i2.insText));

		for (Instruction ins : instructions) {
			bf.append(String.format("\"%s\",\"%s\",%d\r\n", ins.file, ins.insText, ins.count));
		}

		return bf;
	}

	static void showExitMessage(String message) {
		console.print(message + " Press any key to exist");
		try {
			System.in.read();
		} catch (IOException e) {
		}
	}

	static public String getCurrentTimeStamp() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date());
	}

	static class Instruction {
		public String insText;
		public String file;
		public int count;

		public Instruction(String insText, String file) {
			this.insText = insText;
			this.file = file;
			count = 0;
		}
	}
}
