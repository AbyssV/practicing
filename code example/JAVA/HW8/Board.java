/*
This class is used to control and print board
 */
public class Board {
	
	public int row=7;
	public int col=7;
	public String[][] board=new String[row][col];
	
	/*
	 default constructor, generate an empty board
	 */
	public Board(){
		for (int i=0;i<row;i++){
			for (int j=0;j<col;j++){
				if (i%2==0&&j%2==0)
					board[i][j]="+";
				else if (i%2==0&&j%2!=0)
					board[i][j]="---";
				else if (i%2!=0&&j%2==0)
					board[i][j]="|";
				else 
					board[i][j]="   ";
			}
		}
	}
	
	/*
	 print board
	 */	
	void printBoard(){
		System.out.println("The current board: ");
		for (int i=0;i<row;i++){
			for (int j=0;j<col;j++){
				if (board[i][j].equals("   "))
					System.out.printf("%d,%d",(i+1)/2,(j+1)/2);
				else
					System.out.print(board[i][j]);
			}
			System.out.println();
		}	
		System.out.println();
	}
	
}
