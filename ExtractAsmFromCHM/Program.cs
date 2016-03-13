using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using HtmlAgilityPack;

namespace ExtractAsmFromCHM
{
    class Program
    {
        static private string htmlFolder = AppDomain.CurrentDomain.BaseDirectory + Settings.Default.HtmlFolder;
        static private string asmFolder = AppDomain.CurrentDomain.BaseDirectory + Settings.Default.AsmFolder;

        static void Main(string[] args)
        {
            Directory.CreateDirectory(asmFolder);

            foreach (var file in Directory.GetFiles(htmlFolder, "*.htm", SearchOption.AllDirectories))
            {
                if (Path.GetExtension(file).Trim().ToLower() == ".htm")
                {
                    ExtractAsm(file);
                }
            }
        }

        private static void ExtractAsm(string filePath)
        {
            var doc = new HtmlDocument();
            doc.Load(filePath);
            var textareaNode = doc.DocumentNode.SelectSingleNode(@"//body/table//tr[1]/td[2]//textarea");
            var filename = Path.GetFileNameWithoutExtension(filePath);

            var message = "";
            if (textareaNode != null && filename != "index")
            {                   
                
                var asmFilename = asmFolder + "\\" + Path.GetFileNameWithoutExtension(filename);
                if (asmFilename.EndsWith("_asm"))
                {
                    asmFilename = asmFilename.Replace("_asm", ".asm");
                }
                else
                {
                    asmFilename += ".asm";
                }

                File.WriteAllText(asmFilename, textareaNode.InnerHtml, Encoding.UTF8);
                message = "Parse completed: ";
            }
            else
            {
                message = "Parse failed: ";
            }
            Console.WriteLine(message + filePath);
        }
    }
}
