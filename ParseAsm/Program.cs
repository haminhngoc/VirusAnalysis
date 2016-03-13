using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace ParseAsm
{
    class Program
    {
        static List<string> files = new List<string>();

        static void Main(string[] args)
        {
            var folder = args.Length > 0 ? args[0] : "data";
            ParseFolder(folder);
            var workingDir = AppDomain.CurrentDomain.BaseDirectory;
            var logFolder = workingDir + "\\logs";
            var unparsedFiles = logFolder + "\\unparsedfile.log";

            Directory.CreateDirectory(logFolder);

            Console.WriteLine(workingDir);

            files.ForEach(file =>
            {
                try
                {

                    var command = $@" -jar ""{workingDir}BE-PUM.jar"" {file}";
                    Console.WriteLine(command);
                    var procStartInfo = new ProcessStartInfo(@"""C:\Program Files\Java\jre1.8.0_73\bin\java.exe""", command)
                    {
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        CreateNoWindow = true
                    };

                    procStartInfo.WorkingDirectory = workingDir;

                    var proc = new Process();
                    proc.StartInfo = procStartInfo;
                    proc.Start();

                    if (!proc.WaitForExit(3 * 60 * 1000))
                    {
                        proc.Kill();
                        File.AppendAllText(unparsedFiles, file + "\r\n");
                    }
                    //string result = proc.StandardOutput.ReadToEnd();
                    //Console.WriteLine(result);                    
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message + "\r\n" + ex.StackTrace);
                }
            });
        }



        static void ParseFolder(string folder)
        {
            files.AddRange(Directory.GetFiles(folder));
            foreach (var childFolder in Directory.GetDirectories(folder))
            {
                ParseFolder(childFolder);
            }
        }
    }
}
