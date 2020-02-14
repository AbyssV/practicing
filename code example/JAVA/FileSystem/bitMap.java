import java.util.Arrays;

public class bitMap {
	private int[] BM=null;
	private int[] MASK=null;
	
	public bitMap(){
		BM=new int[2];
		MASK=new int[32];
		init();
		MASK[31]=1;
		for(int i=30;i>=0;i--){MASK[i]=MASK[i+1] << 1;}	
	}
	
	public bitMap(int first, int second){
		BM=new int[2];
		MASK=new int[32];
		BM[0]=first;
		BM[1]=second;
		MASK[31]=1;
		for(int i=30;i>=0;i--){MASK[i]=MASK[i+1] << 1;}	
		
	}
	
	public void init(){
		BM[0]=0xFF000000; // 1111 1111 0000 0000
		BM[1]=0;
	}
	
	public byte[] getbitBlock(){
		PackableMemory block = new PackableMemory(64);
		block.pack(BM[0], 0);
		block.pack(BM[1], 4);
		// 8 bytes to represent bitmap
		byte[] bitBlock = Arrays.copyOf(block.getMem(), 64);
		return bitBlock;
	}
	
	// free block j in bitmap
	public void free(int j){
		int[] MASK2 = new int[32];
		
		for(int i=0;i<32;i++){MASK2[i] = ~MASK[i];}
		

		if(j>=0&&j<32)
		{
			BM[0]=BM[0] & MASK2[j];
		}
		
		else if(j>=32&&j<64)
		{
			j-=32;
			BM[1]=BM[1] & MASK2[j];
		}
		else{
			System.out.println("block number out of range(shoube be 0-63).");
		}
	}
	
	// mark block j as occupied in bitmap
	public void occupy(int j){
		if(j>=0&&j<32)
		{
			BM[0]=BM[0] | MASK[j];
		}
		
		else if(j>=32&&j<64)
		{
			j-=32;
			BM[1]=BM[1] | MASK[j];
		}
		else{
			System.out.println("block number out of range(shoube be 0-63).");
		}
	}
	
	// search for a bit equal to “0” in BM, return block number j
	public int search(){
		int test;
		for (int i=0;i<2;i++){
			for (int j=0;j<32;j++){
				test = BM[i] & MASK[j];
				if(test ==0)
				{
					if(i==0) return j;
					else if (i==1){
						j+=32;
						return j;
					}
					
				}
			}
		}
		return -1; //not found
	}
	
	
	public static void main(String[] args){
	
		bitMap test = new bitMap();
		PackableMemory pm = new PackableMemory(test.getbitBlock());

	    System.out.println(Integer.toBinaryString(pm.unpack(0)));
	    System.out.println(Integer.toBinaryString(pm.unpack(4)));
	    test.occupy(10);
	    test.occupy(15);
	    test.occupy(20);
	    test.occupy(25);
	    test.occupy(32);
	    test.occupy(50);
	    test.occupy(55);
	    test.occupy(60);

	    pm.setMem(test.getbitBlock());
	    System.out.println(Integer.toBinaryString(pm.unpack(0)));
	    System.out.println(Integer.toBinaryString(pm.unpack(4)));
	    System.out.println();
	    test.free(25);
	    System.out.println(Integer.toBinaryString(pm.unpack(0)));
	    System.out.println(Integer.toBinaryString(pm.unpack(4)));
	    System.out.println();
	    System.out.println(test.search());
	      
	   }
}
