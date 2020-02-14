import java.util.*;
import java.util.regex.Pattern;
import java.io.*;

// 

public class Driver {
	public static void main(String[] args) throws IOException{
		try{
			File input = new File("/Volumes/Drive/test/test-sample-v2.txt");
			Scanner in = new Scanner(input);
			PrintWriter out = new PrintWriter("/Volumes/Drive/test/10588498.txt");
			
			
			File file = new File("sample.txt");
			if (!file.exists()) {
		        file.createNewFile();
		      }
			FileWriter fw = new FileWriter(file, true);
			BufferedWriter bw = new BufferedWriter(fw);
			
			FileSystem fs = new FileSystem();			
			
			while (in.hasNextLine()){
				String line = in.nextLine();
				if (line.equals("")) out.println();
				else{
					String s[] = line.split(" ");
					String command = s[0];
					
					if (command.equals("in")){
						if (s.length==1){
							fs = new FileSystem();	
							out.println("disk initialized");
							bw.write(line+"\n");
						}
						
						else{				
							out.println("disk restored");
							File to_restore = new File(s[1]);
							if (!to_restore.exists()) {
						        out.println("error");
						      }	
							else{
								Ldisk ldisk = fs.restore(to_restore);						
								fs = new FileSystem(ldisk);	
							}
							
													
						}
						
					}
					
					
					else if (command.equals("sv")){
						out.println("disk saved");
						String filename = s[1];
						bw.flush();
						if (CopyFile.readText("sample.txt", filename));
						//file.renameTo(new File(filename));
						
					}
				   
					else if (command.equals("cr")){
						bw.write(line+"\n");
						String filename = s[1];
						if (fs.create(filename))out.println(filename+" created");
						else out.println("error");
					}
					
					else if (command.equals("de")){
						bw.write(line+"\n");
						String filename = s[1];
						if (fs.destroy(filename))out.println(filename+" destroyed");
						else out.println("error");
					}
					
					else if (command.equals("op")){
						bw.write(line+"\n");
						String filename = s[1];
						int index = fs.open(filename);
						if (index==-1)out.println("error");
						else out.println(filename+" opened "+index);
					}
					
					else if (command.equals("cl")){
						bw.write(line+"\n");
						int index = Integer.parseInt(s[1]);
						if (fs.close(index))out.println(index+" closed");
						else out.println("error");
						
					}
					
					else if (command.equals("rd")){
						bw.write(line+"\n");
						int index = Integer.parseInt(s[1]);
						int count = Integer.parseInt(s[2]);
						out.println(fs.read(index, count));
						
					}
					
					else if (command.equals("wr")){
						bw.write(line+"\n");
						int index = Integer.parseInt(s[1]);
						String c = s[2];
						int count = Integer.parseInt(s[3]);
						int written = fs.write(index, c, count);
						if (written==-1)out.println("error");
						else out.println(written+" bytes written");
					}
					
					else if (command.equals("sk")){
						bw.write(line+"\n");
						int index = Integer.parseInt(s[1]);
						int pos = Integer.parseInt(s[2]);
						if (fs.lseek(index, pos)) out.println("position is "+pos);
						else out.println("error");
						
					}
					
					else if (command.equals("dr")){
						fs.directory(out);
						out.println();
					}
					
					else if (command.equals("po")){
						fs.print_oft();
					}
					
					
				}
				
				
			}
		in.close();
		out.close();
		bw.close();	
		}
		catch (IOException e){
			System.out.println("Fail to read from usb");
			
		}
		



	}

}
