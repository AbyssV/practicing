import java.util.*;
import java.io.*;


public class FileSystem {
	private Ldisk ldisk;
	private bitMap bitmap;
	private OFT[] oft;
	
	private PackableMemory[] descriptor = new PackableMemory[24]; // 24 entries
	private byte[] descriptorBlock = new byte[64]; //each descriptor Block block 4 entries
	
	private PackableMemory pm;
	private PackableMemory[] directory = new PackableMemory[24]; // 24 entries
	private byte[] directoryBlock = new byte[64]; //each directory block 8 entries
	// record the block number of directory because directory also expands dynamically
	int db1; 
	int db2;
	int db3;
	
	
	public FileSystem(){
		init();
	}
	
	public void init(){
		this.ldisk = new Ldisk();

		// initialize bitmap
		this.bitmap = new bitMap(); // block 0-6 is reserved for bitmap and descriptor, 7 is preoccupied by the first directory block
		ldisk.write_block(0, bitmap.getbitBlock()); // write 8 bytes back to disk	
		
		// initialize oft
		init_oft();
		
		// initialize descriptor	
		db1=7;
		for (int i=0; i<descriptor.length;i++)descriptor[i] = new PackableMemory(16); // each entry is 16 bytes, 
		descriptor[0].pack(0, 0);// descriptor[0] is reserved for directory
		descriptor[0].pack(db1, 4); // 7 is preoccupied by the first directory block
		// filldescriptorBlock(descriptorBlock, descriptor, 0); 
		// ldisk.write_block(1, descriptorBlock); // write back to disk
		descriptor[0].pack(-1, 8);
		descriptor[0].pack(-1, 12);
		for (int i=1;i<descriptor.length;i++)descriptor[i].pack(-1, 0); // for descriptor 1-23, the length is -1	
		for (int i=1;i<descriptor.length;i++)descriptor[i].pack(-1, 4);
		for (int i=1;i<descriptor.length;i++)descriptor[i].pack(-1, 8);
		for (int i=1;i<descriptor.length;i++)descriptor[i].pack(-1, 12);
		
		// initialize directory
		for (int i=0; i<directory.length;i++)directory[i] = new PackableMemory(8);
		for (int i=0;i<directory.length;i++)directory[i].pack(-1, 4); // 0-3 is for the file name, 4-7 is for descriptor
	}
	
	// restore from a disk
	public FileSystem(Ldisk rdisk){
		this.ldisk = rdisk;
		this.pm = new PackableMemory(64); // 1 block
		
		// initialize bitmap
		byte[] temp = new byte[64];
		ldisk.read_block(0, temp);
		pm.setMem(temp);
		this.bitmap = new bitMap(pm.unpack(0), pm.unpack(4));
		
		// initialize oft
		init_oft();
		
		// initialize descriptor
		for (int i=0; i<descriptor.length;i++)descriptor[i] = new PackableMemory(16);
		for (int i=0;i<6;i++){
			temp = new byte[64];
			ldisk.read_block(i+1, temp);
			byte[] temp2 = new byte[16];
			for (int j=0;j<4;j++){
				for (int k=0;k<16;k++){
					temp2[k]=temp[16*j+k];
					
				}
				descriptor[i*4+j].setMem(temp2);
				
			}
		}
		
		// initialize directory
		for (int i=0; i<directory.length;i++)directory[i] = new PackableMemory(8);
		db1=descriptor[0].unpack(4);
		db2=descriptor[0].unpack(8);
		db3=descriptor[0].unpack(12);
		temp=new byte[64];
		byte[] temp3 = new byte[8];
		if (db1!=-1){
			ldisk.read_block(db1, temp);
			for (int i=0;i<8;i++){			
				for (int j=0;j<8;j++){
					temp3[j]=temp[i*8+j];
				}
				directory[i].setMem(temp3);		
			}
			if (db2!=-1){
				ldisk.read_block(db2, temp);
				for (int i=0;i<8;i++){			
					for (int j=0;j<8;j++){
						temp3[j]=temp[i*8+j];
					}
					directory[8+i].setMem(temp3);		
				}
				if (db3!=-1){
					ldisk.read_block(db3, temp);
					for (int i=0;i<8;i++){			
						for (int j=0;j<8;j++){
							temp3[j]=temp[i*8+j];
						}
						directory[16+i].setMem(temp3);		
					}
				}
				
			}
		
		}

	}
	
	public void init_oft(){
		this.oft = new OFT[4]; 
		for (int i=0;i<oft.length;i++)oft[i]=new OFT();
		oft[0].setLength(0); // initial empty
		oft[0].setPosition(0);
		oft[0].setIndex(0); // descriptor 0 is reserved for directory	
	}
	
	
	// copy 4 entries of descriptor to dest 
	// loc = 0, 4, 8, 12, 16, 20
	private void filldescriptorBlock(byte[] dest, PackableMemory[] sour, int loc){
		for (int i=0;i<4;i++){
			byte[] temp=sour[loc+i].getMem(); 
			for (int j=0;j<temp.length;j++) // temp.length = 16
				dest[(i*16)+j]=temp[j];
		}
	}
	
	
	// copy 8 entries of descriptor to dest 
	// loc = 0, 8, 16
	private void filldirectoryBlock(byte[] dest, PackableMemory[] sour, int loc){
		for (int i=0;i<8;i++){
			byte[] temp=sour[loc+i].getMem(); //temp.length = 8
			for (int j=0;j<temp.length;j++)
				dest[(i*8)+j]=temp[j];
		}
	}
	
	
	public boolean create(String name){
		int new_length; // new length of directory
		// check if there is a file with the same name
		for (int i=0; i<directory.length;i++)
			if (directory[i].unpack(4)!=-1 && directory[i].compareString(name))
				return false;
			
		// find a free file descriptor	
		int index=-1;
		for (int i=0;i<descriptor.length;i++){
			if (descriptor[i].unpack(0)==-1){
				index=i;
				descriptor[i].pack(0, 0); // we havn't write anything yet, so the length is 0
				break;
			}
		}
		
		if (index==-1)
			return false; // no free descriptor
		else{
			for (int i=0;i<8;i++){
				if (directory[i].unpack(4)==-1){
					directory[i].pack(index, 4);
					directory[i].setString(name, 0);
					new_length=descriptor[0].unpack(0)+8;
					descriptor[0].pack(new_length, 0); // update directory length in descriptor[0]
					//filldescriptorBlock(descriptorBlock, descriptor, index/4*4);// copy descriptor block back to disk
					//ldisk.write_block(index/4+1, descriptorBlock);				
					return true;
				}					
			}
			// if the first directory buffer is fill, copy back to disk
			filldirectoryBlock(directoryBlock, directory, 0);
			ldisk.write_block(db1, directoryBlock);
			
			// allocate block for next directory block if necessary
			db2 = descriptor[0].unpack(8);
			if (db2==-1){
				db2=bitmap.search();
				bitmap.occupy(db2);
				descriptor[0].pack(db2, 8);
			}			
			
			for (int i=8;i<16;i++){
				if (directory[i].unpack(4)==-1){
					directory[i].pack(index, 4);
					directory[i].setString(name, 0);
					new_length=descriptor[0].unpack(0)+8;
					descriptor[0].pack(new_length, 0);
					//filldescriptorBlock(descriptorBlock, descriptor, index/4*4);// copy descriptor block back to disk
					//ldisk.write_block(index/4+1, descriptorBlock);				
					return true;
				}	
				
			}
			
			// if the second directory buffer is fill, copy back to disk
			filldirectoryBlock(directoryBlock, directory, 8);
			ldisk.write_block(db2, directoryBlock);
			
			// allocate block for next directory block if necessary
			db3 = descriptor[0].unpack(12);
			if (db3==-1){
				db3=bitmap.search();
				bitmap.occupy(db3);
				descriptor[0].pack(db3, 12);
			}			
			
			for (int i=16;i<24;i++){
				if (directory[i].unpack(4)==-1){
					directory[i].pack(index, 4);
					directory[i].setString(name, 0);
					new_length=descriptor[0].unpack(0)+8;
					descriptor[0].pack(new_length, 0);
					//filldescriptorBlock(descriptorBlock, descriptor, index/4*4);// copy descriptor block back to disk
					//ldisk.write_block(index/4+1, descriptorBlock);				
					return true;
				}	
				
			}
			
			return false; // no empty directory
		}

	}
	
	public boolean destroy(String name){
		int index=-1;
		for (int i=0;i<directory.length;i++){
			if (directory[i].compareString(name)){
				index = directory[i].unpack(4); // get file descriptor
				directory[i].clearMem();
				directory[i].pack(-1, 4); // clear directory entry
				descriptor[index].pack(-1, 0); // set length to -1
				for (int j=4;j<=12;j+=4){
					int deleted_block = descriptor[index].unpack(j);  // if data block is not empty
					if (deleted_block!=-1){ 
						byte[] empty_block=new byte[64];				
						ldisk.write_block(deleted_block, empty_block); // clear the data block
						descriptor[index].pack(-1, j); // clear entry in descriptor
						bitmap.free(deleted_block);	// free bitmap					
					}
				}
				
				for (int k=1;k<oft.length;k++){ // clear oft entry if the destroyed file is opened
					if (oft[k].getIndex()==index){
						oft[k].setIndex(-1);
						oft[k].setPosition(-1);
						oft[k].setLength(-1);
						oft[k].clearBuffer();
					}
					
				}
				return true;
			}
		}
		return false; // destroy a file that does not exist -> error
	}
	
	
	// return -1 if there is an error
	public int open(String name){
		int index=-1;
		for (int i=0;i<directory.length;i++){
			if (directory[i].compareString(name)){
				index = directory[i].unpack(4); // get file descriptor
				for (int j=1;j<oft.length;j++){
					if (oft[j].getIndex()==index)
						return -1; // if the file is already opened, report error
				}
				for (int j=1;j<oft.length;j++){
					if (oft[j].getIndex()==-1){
						oft[j].setIndex(index);
						oft[j].setPosition(0);
						oft[j].setLength(descriptor[index].unpack(0));
						int b = descriptor[index].unpack(4);
						if (b==-1){// read-ahead if the file is not empty
							b = bitmap.search();
							bitmap.occupy(b);
							descriptor[index].pack(b, 4);
						}
						byte[] temp = new byte[64];
						ldisk.read_block(b, temp);
						oft[j].setBuffer(temp);// note buffer in OFT is private							
						return j; // return oft index
					}
				}
				return -1; // if on entry in oft available, report error
			}
		}
		return -1; // if no file name match, report error
	}
	
	
	public boolean close(int index){
		if (index==0) return false;
		if (oft[index].getIndex()==-1)return false;
		int d = oft[index].getIndex(); // get file descriptor
		int b = oft[index].getPosition()/64; // b+1 is block number
		if (b==3)b=2;
		ldisk.write_block(descriptor[d].unpack((b+1)*4), oft[index].getBuffer());// write buffer back to disk
		descriptor[d].pack(oft[index].getLength(), 0); // update file length in descriptor
		//filldescriptorBlock(descriptorBlock, descriptor, d/4*4);// copy descriptor block back to disk
		//ldisk.write_block(d/4+1, descriptorBlock);	
		oft[index].clearBuffer(); // free OFT entry
		oft[index].setIndex(-1);
		oft[index].setLength(-1);
		oft[index].setPosition(-1);
		return true;
	}	
	
	// return "error" if there is an error
	public String read(int index, int count){
		if (index==0)return "error";  // user cant access oft[0]
		if (oft[index].getIndex()==-1)return "error"; // if the file is not opened, report an error
		String result;
		count = Math.min(count, oft[index].getLength()-oft[index].getPosition()); // make sure do not exceed to length of the file
		if (count<=0) return ""; // if nothing can read, print an empty line
		int d = oft[index].getIndex();
		int current_block_number = oft[index].getPosition()/64; // current block number is 0, 1, or 2
		if (current_block_number==3)current_block_number=2;
		int current_position = oft[index].getPosition()%64; // current position in current block
		String current_block = new String(oft[index].getBuffer());
		int new_position = oft[index].getPosition()+count;
		oft[index].setPosition(new_position); // change position first
		int can_read = 64-current_position; 
		if (count<can_read || current_block_number==2){ // if no need to switch to next buffer
			result = current_block.substring(current_position, current_position+count);
			return result;
		}
		else{
			result = current_block.substring(current_position, 64);
			if (new_position==192&&current_block_number==2)return result;
			count-=can_read; // count>=0
			ldisk.write_block(descriptor[d].unpack((current_block_number+1)*4), oft[index].getBuffer()); // write buffer to disk
			byte[] temp = new byte[64];
			ldisk.read_block(descriptor[d].unpack((current_block_number+2)*4), temp); // read next buffer
			oft[index].setBuffer(temp); // read next block
			current_block = new String(oft[index].getBuffer());
			if (count<=63){					
				result+=current_block.substring(0, count);
				return result;
			}
			else{
				result+=current_block.substring(0, 64);
				if (new_position==192&&current_block_number==1)return result;
				count-=64; // read to the third block
				ldisk.write_block(descriptor[d].unpack((current_block_number+2)*4), oft[index].getBuffer());// write buffer to disk
				temp = new byte[64];
				ldisk.read_block(descriptor[d].unpack((current_block_number+3)*4), temp); // read next buffer
				oft[index].setBuffer(temp); // read next block
				current_block = new String(oft[index].getBuffer());
				result+=current_block.substring(0, count);
				return result;
			}
		}
		
		
	}
	
	public int write(int index, String c, int count){
		if (index==0)return -1; // user cant access oft[0]
		if (oft[index].getIndex()==-1)return -1; // if the file is not opened, report an error		
		count = Math.min(count, 192-oft[index].getPosition()); // make sure do not exceed to length of the file
		if (count<=0) return 0; // if nothing can write, return 0
		int d = oft[index].getIndex();
		int current_block_number = oft[index].getPosition()/64; // current block number is 0, 1, or 2
		if (current_block_number==3)current_block_number=2;
		int current_position = oft[index].getPosition()%64; // current position in current block
		byte[] current_block = oft[index].getBuffer();
		
		String s = "";
		for (int i=0;i<count;i++)s+=c;
		byte [] to_write = s.getBytes(); // to_write stores everything we need to write into
		
		int new_length = oft[index].getLength();
		if (oft[index].getPosition()+count>oft[index].getLength()){
			new_length = oft[index].getPosition()+count;
			oft[index].setLength(new_length);//update length		
		} 
		descriptor[d].pack(new_length, 0); // update file length in descriptor
		int new_position = oft[index].getPosition()+count;
		oft[index].setPosition(new_position); // change position first
		int count_copy=count;
		int can_write = 64-current_position; 
		
		if (count<can_write){ // if no need to switch to next buffer
			for (int i=current_position, j=0;i<current_position+count && j<to_write.length;i++, j++)current_block[i]=to_write[j];
			oft[index].setBuffer(current_block);
			return count_copy;
		}
		else{
			for (int i=current_position, j=0;i<64 && j<to_write.length;i++, j++)current_block[i]=to_write[j];
			oft[index].setBuffer(current_block);
			// outofbound exception
			if (new_position==192&&current_block_number==2)return count_copy;
			count-=can_write; // count>=0
			ldisk.write_block(descriptor[d].unpack((current_block_number+1)*4), oft[index].getBuffer()); // write buffer to disk
			int block_number2 = descriptor[d].unpack((current_block_number+2)*4);
			if (block_number2==-1){
				block_number2 = bitmap.search(); // allocate new block
				if (block_number2==-1) return -1; // if not free block in disk report an error
				bitmap.occupy(block_number2);
				descriptor[d].pack(block_number2, (current_block_number+2)*4); // update file descriptor
			}						
			byte[] temp = new byte[64];
			ldisk.read_block(block_number2, temp); // read next buffer
			oft[index].setBuffer(temp); // copy into oft
			current_block = oft[index].getBuffer();
			if (count<=63){					
				for (int i=0, j=can_write; i< count&& j<to_write.length;i++,j++) current_block[i]=to_write[j];
				oft[index].setBuffer(current_block);
				return count_copy;
			}
			
			
			else{ // if we need the 3rd block
				for (int i=0, j=can_write;i<64 && j<to_write.length;i++,j++)current_block[i]=to_write[j];
				oft[index].setBuffer(current_block);
				// outofbound exception
				if (new_position==192&&current_block_number==1)return count_copy;
				count-=64; // read to the third block
				ldisk.write_block(block_number2, oft[index].getBuffer());// write buffer to disk
				int block_number3 = descriptor[d].unpack((current_block_number+3)*4);
				if (block_number3==-1){
					block_number3 = bitmap.search(); // allocate new block
					if (block_number3==-1) return -1; // if not free block in disk report an error
					bitmap.occupy(block_number3);
					descriptor[d].pack(block_number3, (current_block_number+3)*4); // update file descriptor
				}	
				temp = new byte[64];
				ldisk.read_block(block_number3, temp); // read next buffer
				oft[index].setBuffer(temp); // read next block
				current_block = oft[index].getBuffer();
				can_write+=64;
				for (int i=0, j=can_write;i<count&&j<to_write.length;i++,j++)current_block[i]=to_write[j];
				oft[index].setBuffer(current_block);
				return count_copy;
			}
		}
		
	}
	
	public boolean lseek(int index, int pos){
		if (index==0)return false; // user cant access oft[0]
		if (pos>oft[index].getLength() || pos>191) return false;
		int d = oft[index].getIndex();
		if (d==-1) return false; // if the file is not opened, report an error	
		
		int current_block_number;
		if (oft[index].getPosition()==192)current_block_number=2;
		else current_block_number=oft[index].getPosition()/64;
		
		
		int block_number = pos/64;
		if (current_block_number==block_number){
			oft[index].setPosition(pos);
			return true;
		}
		else{
			ldisk.write_block(descriptor[d].unpack((current_block_number+1)*4), oft[index].getBuffer());
			byte[] temp=new byte[64];
			ldisk.read_block(descriptor[d].unpack((block_number+1)*4), temp);
			oft[index].setBuffer(temp);
			oft[index].setPosition(pos);
			return true;
		}
		
	}
	
	// run the command from file and return disk
	public Ldisk restore(File input){
		//init();
		try{
			Scanner in = new Scanner(input);
			while (in.hasNextLine()){
				String line = in.nextLine();
				if (line.equals(""))continue;
				else{
					String s[] = line.split(" ");
					String command = s[0];
					
					if (command.equals("in")){
						init();
					}
					
					else if (command.equals("cr")){
						String filename = s[1];
						if (create(filename));
						else continue;
						
					}
					
					else if (command.equals("de")){
						String filename = s[1];
						if (destroy(filename));
						else continue;
					}
					
					else if (command.equals("op")){
						String filename = s[1];
						int index = open(filename);
						if (index==-1) continue;;
					}
					
					else if (command.equals("cl")){
						int index = Integer.parseInt(s[1]);
						if (close(index));
						else continue;
						
					}
					
					else if (command.equals("rd")){
						int index = Integer.parseInt(s[1]);
						int count = Integer.parseInt(s[2]);
						String result = read(index, count);
						
					}
					
					else if (command.equals("wr")){
						int index = Integer.parseInt(s[1]);
						String c = s[2];
						int count = Integer.parseInt(s[3]);
						int written = write(index, c, count);
					}
					
					else if (command.equals("sk")){
						int index = Integer.parseInt(s[1]);
						int pos = Integer.parseInt(s[2]);
						if (lseek(index, pos));
						else continue;
						
					}
					
					
				}
				
				
			}			
			in.close();
			// copy bitmap back to disk
			byte[] temp = bitmap.getbitBlock();
			ldisk.write_block(0, temp);
			
			// copy descriptor back to disk
			for (int i=0;i<6;i++){
				filldescriptorBlock(descriptorBlock, descriptor, i*4);
				ldisk.write_block(i+1, descriptorBlock);
			}
			
			// copy directory back to disk
			db1 = descriptor[0].unpack(4);
			db2 = descriptor[0].unpack(8);
			db3 = descriptor[0].unpack(12);
			
			
			if (db1!=-1){
				for (int i=0;i<8;i++){
					for (int j=0;j<8;j++){
						directoryBlock[8*i+j] = directory[i].getMem()[j];						
					}
				}
				ldisk.write_block(db1, directoryBlock);
				if (db2!=-1){
					for (int i=0;i<8;i++){
						for (int j=0;j<8;j++){
							directoryBlock[8*i+j] = directory[i+8].getMem()[j];						
						}
					}
					ldisk.write_block(db2, directoryBlock);
					
					if (db3!=-1){
						for (int i=0;i<8;i++){
							for (int j=0;j<8;j++){
								directoryBlock[8*i+j] = directory[i+16].getMem()[j];						
							}
						}
						ldisk.write_block(db3, directoryBlock);
						
					}
				}
			}
		
			return ldisk;
			
		}
		catch(FileNotFoundException e){
			
			System.out.println("error");
			return ldisk; // ?
		}
		
		
	}
	
	
	public void directory(PrintWriter out){
		for (int i=0;i<directory.length;i++){
			if (directory[i].unpack(4)!=-1){
				out.print(directory[i].getString(0, 4).trim()+" ");
			}
		}
		
	}
	
	// helper function to print oft
	public void print_oft(){
		for (int i=1;i<oft.length;i++){
			System.out.printf("%1d: position: %3d index: %3d length: %3d\n", i, oft[i].getPosition(), oft[i].getIndex(), oft[i].getLength());
		}
	}
	
	
}
