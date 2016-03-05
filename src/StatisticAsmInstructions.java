import java.io.*;
import java.text.*;
import java.util.*;

public class StatisticAsmInstructions {

	static PrintStream console = System.out;
	static Scanner consoleReader = new Scanner(System.in);

	static String folderName = "asm";
	static String outFileName = getCurrentTimeStamp();
	static String outAllFileName = outFileName + "_all";

	static HashMap<String, HashMap<String, Instruction>> fileInsMap = new HashMap<String, HashMap<String, Instruction>>();
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

		ArrayList<File> asmFiles = new ArrayList<File>();
		for (File file : files) {
			if (file.getName().toLowerCase().endsWith(".asm")) {
				asmFiles.add(file);
			}
		}

		if (asmFiles.size() == 0) {
			showExitMessage("There is not any asm file in " + folderName + ".");
			return;
		}

		if (args.length > 1) {
			outFileName = args[1];
			outAllFileName = outFileName + "_all";
		}
		outFileName += ".csv";
		outAllFileName += ".csv";

		BufferedWriter outFileWriter = null;
		try {
			outFileWriter = new BufferedWriter(new FileWriter(outFileName, false));
		} catch (IOException ex) {
			ex.printStackTrace();
			return;
		}

		StringBuilder outBuffer = new StringBuilder();
		int MOD = Math.max(1, Math.min(10, asmFiles.size() / 100));
		for (int i = 0; i < asmFiles.size(); i++) {
			File file = asmFiles.get(i);
			String fileName = file.getName();
			console.println(String.format("Parsing file: %s (%d/%d)", fileName, i + 1, asmFiles.size()));

			try {

				parseFile(file.getAbsolutePath(), fileName);

				HashMap<String, Instruction> insMap = fileInsMap.get(fileName);
				if (insMap != null) {
					getText(outBuffer, insMap);
				}

				if (i % MOD == MOD - 1) {
					outFileWriter.write(outBuffer.toString());
					outFileWriter.flush();
					outBuffer = new StringBuilder();

					writeAllInstructions(outAllFileName);
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

		try {
			outFileWriter.write(outBuffer.toString());
			outFileWriter.close();

			writeAllInstructions(outAllFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	static void writeAllInstructions(String outAllFileName) {
		try {
			StringBuilder outAllBuffer = new StringBuilder();
			getText(outAllBuffer, allInstructionMap);
			BufferedWriter outAllFileWriter = new BufferedWriter(new FileWriter(outAllFileName, false));
			outAllFileWriter.write(outAllBuffer.toString());
			outAllFileWriter.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	static void parseFile(String filePath, String fileName) throws IOException {
		BufferedReader fileReader = new BufferedReader(new FileReader(filePath));

		HashMap<String, Instruction> insMap = fileInsMap.get(fileName);
		if (insMap == null) {
			insMap = new HashMap<String, Instruction>();
			fileInsMap.put(fileName, insMap);
		}

		String line;
		while ((line = fileReader.readLine()) != null) {
			int i = line.indexOf(":\t");
			if (i < 0) {
				continue;
			}
			String insText = line.substring(i + 2, line.length()).trim();

			Instruction instruction = insMap.get(insText);
			if (instruction == null) {
				instruction = new Instruction(insText, fileName);
				insMap.put(insText, instruction);
			}
			instruction.count++;

			instruction = allInstructionMap.get(insText);
			if (instruction == null) {
				instruction = new Instruction(insText);
				allInstructionMap.put(insText, instruction);
			}
			instruction.count++;
		}

		fileReader.close();
	}

	static void getText(StringBuilder bf, HashMap<String, Instruction> instructionMap) {
		Collection<Instruction> values = instructionMap.values();
		Instruction[] instructions = values.toArray(new Instruction[values.size()]);
		Arrays.sort(instructions, (i1, i2) -> i1.insText.compareTo(i2.insText));

		for (Instruction ins : instructions) {
			bf.append(String.format("\"%s\",\"%s\",%d\r\n", ins.fileName, ins.insText, ins.count));
		}
	}

	static void showExitMessage(String message) {
		console.print(message + " Press any key to exist");
		try {
			System.in.read();
		} catch (IOException e) {
		}
	}

	static public String getCurrentTimeStamp() {
		return new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date());
	}

	static class Instruction {
		public String insText;
		public String fileName = "";
		public int count = 0;

		public Instruction(String insText) {
			this.insText = insText;
		}

		public Instruction(String insText, String file) {
			this.insText = insText;
			this.fileName = file;
		}
	}
}
