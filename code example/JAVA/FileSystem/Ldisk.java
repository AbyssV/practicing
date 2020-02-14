public class Ldisk {
	private byte[][] ldisk;
	
	public Ldisk() {	
		ldisk = new byte[64][64]; //64 blocks, each block is 64 bytes
	}
	
	
	public void read_block(int i, byte[] p) {
		for (int posi=0;posi<p.length;posi++){
			p[posi]=ldisk[i][posi];
		}		
	}
	
	public void write_block(int i, byte[] p) {
		for (int posi=0;posi<p.length;posi++){
            ldisk[i][posi]=p[posi];
		}
	}
	
    public byte[][] getLdisk() {
        return ldisk;
    }

    // may not be useful, care for copy
    public void setLdisk(byte[][] ldisk) {
        this.ldisk = ldisk;
    }
}
