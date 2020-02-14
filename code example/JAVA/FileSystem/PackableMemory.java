//This class contains implementations of methods to 
//   -- pack an integer into 4 consecutive bytes of a byte array
import java.util.Arrays;
//   -- unpack an integer from 4 consecutive bytes of a byte array
//   -- exhaustively test the pack and unpack methods.
// 
// This file should be saved as PackableMemory.java.  Once it has been
//  compiled, the tester can be invoked by typing "java PackableMemory"

class PackableMemory
{
   int size; 
   public byte mem[] = null;

   public PackableMemory(int size)
   {
      this.size = size;
      this.mem = new byte[size];
   }
   
   public PackableMemory(byte[] block){
	   this.mem = Arrays.copyOf(block, block.length);
   }
   
   public byte[] getMem(){
	   return this.mem;
   }
   
   public void setMem(byte[] block){
	   this.mem = Arrays.copyOf(block, block.length);
   }
   
   public int getSize(){
	   return this.size;
   }

   // Pack the 4-byte integer val into the four bytes mem[loc]...mem[loc+3].
   // The most significant porion of the integer is stored in mem[loc].
   // Bytes are masked out of the integer and stored in the array, working
   // from right(least significant) to left (most significant).
   public void pack(int val, int loc)
   {
      final int MASK = 0xff;
      for (int i=3; i >= 0; i--)
      {
         mem[loc+i] = (byte)(val & MASK);
         val = val >> 8;
      }
   }
   


   // Unpack the four bytes mem[loc]...mem[loc+3] into a 4-byte integer,
   //  and return the resulting integer value.
   // The most significant porion of the integer is stored in mem[loc].
   // Bytes are 'OR'ed into the integer, working from left (most significant) 
   //  to right (least significant)
   public int unpack(int loc)
   {
      final int MASK = 0xff;
      int v = (int)mem[loc] & MASK;
      for (int i=1; i < 4; i++)
      {
         v = v << 8; 
         v = v | ((int)mem[loc+i] & MASK);
      }
      return v;
   }
   public void clearMem(){
	   this.mem = new byte[this.size];

   }
   //copy string s to mem from loc (include loc) to the end of mem
   public void setString(String s, int loc){
	   byte[] temp = s.getBytes();
	   for (int i=0;i<this.mem.length-loc&&i<temp.length;i++){
		   this.mem[loc+i]=temp[i];
	   }

   }
   
   // return a string of size len from loc (include loc)
   public String getString(int loc, int len){
	   byte[] temp = new byte[len];
	   System.arraycopy(this.mem, loc, temp, 0, len);
	   String s=new String(temp);
	   return s;
   }
   
   public boolean compareString(String s){
	   byte[] temp=s.getBytes();
	   byte[] b1 = Arrays.copyOf(temp, 4);
	   for (int i=0;i<4;i++)
		   if (b1[i]!=this.mem[i])return false;
	   
	   return true;
   }



   // Test the above pack and unpack methods by iterating the following
   //  over all possible 4-byte integers: pack the integer,
   //  then unpack it, and then verify that the unpacked integer equals the
   //  original integer.  It tests all nonnegative numbers in ascending order
   //  and then all negative numbers in ascending order.  The transition from
   //  positive to negative numbers happens implicitly due to integer overflow.
   public void packTest()
   {
 
      int i = 0;
      long k = 0;
      do 
      {
         this.pack(i,4);
         int j = this.unpack(4);
         if (j != i)
         {
            System.out.printf("pack/unpack test failed: i = %d, j = %d\n",i,j);
            System.exit(0);
         }
         i++; k++;
      }
      while (i != 0);
      System.out.printf("pack/unpack test successful, %d iterations\n",k);
   }

   // main routine to test the PackableMemory class by running the 
   //  packTest() method.
   public static void main(String[] args)
   {
      PackableMemory pm = new PackableMemory(16);
    
     /* pm.pack(100, 0);
      pm.pack(101, 4);
      pm.pack(102, 8);
      pm.pack(103, 12);
      System.out.printf("1st: %d, 2nd: %d, 3rd: %d, 4th: %d\n", pm.unpack(0), pm.unpack(4),pm.unpack(8),pm.unpack(12));
      
      PackableMemory pm_string = new PackableMemory(16);
      pm_string.setString("1", 0);
      pm_string.setString("22", 1);
      pm_string.setString("333", 3);
      pm_string.setString("4444", 6);
      
      System.out.printf("%s %s %s %s\n", pm_string.getString(0, 4), pm_string.getString(4, 4),pm_string.getString(8, 4),pm_string.getString(12, 4));*/
      pm.setString("1",0);
      pm.setString("222",4);
      pm.setString("3333",9);
      pm.setString("4",14);
      String s=pm.getString(0,1);
      System.out.println(s.equals("1"));
   }
}
