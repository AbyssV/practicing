import java.io.*;
import java.util.*;



public class CopyFile{
	
	public CopyFile(){
		
	}

	public static boolean readText(String file, String copy){

		BufferedInputStream br;

		BufferedOutputStream bw;
		FileOutputStream fw;
		try {
			br = new BufferedInputStream(new FileInputStream(file));
			fw = new FileOutputStream(copy);
			bw = new BufferedOutputStream(fw);
			int a;

			while ((a = br.read()) != -1) {
				bw.write(a);
			}
			bw.close();
			fw.close();
			return true;
		} 
		catch (IOException e) {
			return false;
		}
	}
	public static void main(String[] args){
		CopyFile.readText("input3.txt", "testfile.txt");
		try{
			File file = new File("input3.txt");
			if (!file.exists()) {
		        file.createNewFile();
		      }
			FileWriter fw = new FileWriter(file, true);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("LOVE\n");
			bw.close();
		}
		catch(IOException e){
			System.out.println("Fail");
		}
	}
}
