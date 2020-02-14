import java.util.Arrays;
public class OFT {
	private byte[] buffer;
	private int position;
	private int index;
	private int length;
	
	
	public OFT() {
		this.buffer=new byte[64];
		this.position=-1;
		this.index=-1;
		this.length=-1;
	}
	
	public byte[] getBuffer(){
		return this.buffer;
	}
	
	public void clearBuffer(){
		this.buffer=new byte[64];
	}
	
	public void setBuffer(byte[] block){
		this.buffer = Arrays.copyOf(block,64);
	}
	
	public int getPosition(){
		return this.position;
	}
	
	public void setPosition(int position){
		this.position=position;
	}
	
	public int getIndex(){
		return this.index;
	}
	
	public void setIndex(int index){
		this.index=index;
	}
	
	public int getLength(){
		return this.length;
	}
	
	public void setLength(int length){
		this.length=length;
	}
	
	
	
}
