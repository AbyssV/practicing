/**
 * 
 */

/**
this class controls how computer drops a tile, it also detects a winner 
 */
public class computerDrop {
	public int row=7;
	public int col=7;
	//when someone win, winFlag will set to true
	boolean winFlag=false;
	//0 represents no side win, 1 represents user win, 2 represents computer win
	int winSide=0;
	
	public computerDrop(){
		
	}
	
	/**
	 this method check if the checked has two tiles adjacent, if there is, and the third position has not been occupied by dposi, then return that position
	 if is occupied by its own tile, then winFlag will changed to win   
	 @param board
	 @param checked
	 @param dposi
	 @return a two size int of array
	 */
	int[] checkTwo(String[][] board, String checked,String dposi){
		int [] drop=new int[2];
		if (board[3][3].equals(checked)){
			if (board[3][1].equals(checked)&&!board[3][5].equals(dposi))
			{
				if (board[3][5].equals(checked)){
					winFlag=true;
				}
				drop[0]=3;
				drop[1]=5;
				return drop;
			}
			else if (board[3][5].equals(checked)&&!board[3][1].equals(dposi))
			{
				if (board[3][1].equals(checked)){
					winFlag=true;
				}
				drop[0]=3;
				drop[1]=1;
				return drop;
			}
			else if (board[1][3].equals(checked)&&!board[5][3].equals(dposi))
			{
				if (board[5][3].equals(checked)){
					winFlag=true;
				}
				drop[0]=5;
				drop[1]=3;
				return drop;
			}
			else if (board[5][3].equals(checked)&&!board[1][3].equals(dposi))
			{
				if (board[1][3].equals(checked)){
					winFlag=true;
				}
				drop[0]=1;
				drop[1]=3;
				return drop;
			}
			else if (board[1][1].equals(checked)&&!board[5][5].equals(dposi))
			{
				if (board[5][5].equals(checked)){
					winFlag=true;
				}
				drop[0]=5;
				drop[1]=5;
				return drop;
			}
			else if (board[5][5].equals(checked)&&!board[1][1].equals(dposi))
			{
				if (board[1][1].equals(checked)){
					winFlag=true;
				}
				drop[0]=1;
				drop[1]=1;
				return drop;
			}
			else if (board[1][5].equals(checked)&&!board[5][1].equals(dposi))
			{
				if (board[5][1].equals(checked)){
					winFlag=true;
				}
				drop[0]=5;
				drop[1]=1;
				return drop;
			}
			else if (board[5][1].equals(checked)&&!board[1][5].equals(dposi))
			{
				if (board[1][5].equals(checked)){
					winFlag=true;
				}
				drop[0]=1;
				drop[1]=5;
				return drop;
			}
		}
		else{
			if (board[3][1].equals(checked)){
				if (board[1][1].equals(checked)&&!board[5][1].equals(dposi))
				{
					if (board[5][1].equals(checked)){
						winFlag=true;
					}
					drop[0]=5;
					drop[1]=1;
					return drop;
				}
				else if (board[5][1].equals(checked)&&!board[1][1].equals(dposi))
				{
					if (board[1][1].equals(checked)){
						winFlag=true;
					}
					drop[0]=1;
					drop[1]=1;
					return drop;
				}
			}
			else if (board[1][3].equals(checked)){
				if (board[1][1].equals(checked)&&!board[1][5].equals(dposi))
				{
					if (board[1][5].equals(checked)){
						winFlag=true;
					}
					drop[0]=1;
					drop[1]=5;
					return drop;
				}
				else if (board[1][5].equals(checked)&&!board[1][1].equals(dposi))
				{
					if (board[1][1].equals(checked)){
						winFlag=true;
					}
					drop[0]=1;
					drop[1]=1;
					return drop;
				}
			}
			else if (board[3][5].equals(checked)){
				if (board[1][5].equals(checked)&&!board[5][5].equals(dposi))
				{
					if (board[5][5].equals(checked)){
						winFlag=true;
					}
					drop[0]=5;
					drop[1]=5;
					return drop;
				}
				else if (board[5][5].equals(checked)&&!board[1][5].equals(dposi))
				{
					if (board[1][5].equals(checked)){
						winFlag=true;
					}
					drop[0]=1;
					drop[1]=5;
					return drop;
				}
			}
			else if (board[5][3].equals(checked)){
				if (board[5][1].equals(checked)&&!board[5][5].equals(dposi))
				{
					if (board[5][5].equals(checked)){
						winFlag=true;
					}
					drop[0]=5;
					drop[1]=5;
					return drop;
				}
				else if (board[5][5].equals(checked)&&!board[5][1].equals(dposi))
				{
					if (board[5][1].equals(checked)){
						winFlag=true;
					}
					drop[0]=5;
					drop[1]=1;
					return drop;
				}
			}
		}
		
		if (board[1][1].equals(checked)){
			if (board[1][5].equals(checked)&&!board[1][3].equals(dposi)){
				drop[0]=1;
				drop[1]=3;
				return drop;
			}
			else if (board[5][1].equals(checked)&&!board[3][1].equals(dposi)){
				drop[0]=3;
				drop[1]=1;
				return drop;
			}
		}
		else if (board[5][5].equals(checked)){
			if (board[1][5].equals(checked)&&!board[3][5].equals(dposi)){
				drop[0]=3;
				drop[1]=5;
				return drop;
			}
			else if (board[5][1].equals(checked)&&!board[5][3].equals(dposi)){
				drop[0]=5;
				drop[1]=3;
				return drop;
			}
		}
		drop[0]=-1;
		drop[1]=-1;
		return drop;				
	}

	/**
	 this method detects a winner, and controls how computer drops a tile
	 if there are two adjacent computer tile on the board, then computer will take offensive drop. If there is not, them computer will defend user.
	 if there is no two adjacent tile of the user, then the computer will take a drop based on priority
	 * @param board
	 * @param user
	 * @param computer
	 */
	void Drop(String[][] board, String user, String computer){

		int [] dposition=checkTwo(board,computer,user);		
		int drow=dposition[0];
		int dcol=dposition[1];	
	
		
		if (drow==-1&&dcol==-1){

			int [] dposition2=checkTwo(board,user,computer);
			int drow2=dposition2[0];
			int dcol2=dposition2[1];	
			if (winFlag==true){
				winSide=1;
				return;
			}
			if (drow2==-1&&dcol2==-1){
				if (!board[3][3].equals(user)&&!board[3][3].equals(computer)){
					board[3][3]=computer;
					
				}
				else if (!board[1][1].equals(user)&&!board[1][1].equals(computer)){
					board[1][1]=computer;
				}
				else if (!board[1][5].equals(user)&&!board[1][5].equals(computer)){
					board[1][5]=computer;
				}
				
				else if (!board[5][1].equals(user)&&!board[5][1].equals(computer)){
					board[5][1]=computer;
				}
				else if (!board[5][5].equals(user)&&!board[5][5].equals(computer)){
					board[5][5]=computer;
				}
				else if (!board[1][3].equals(user)&&!board[1][3].equals(computer)){
					board[1][3]=computer;
				}
				else if (!board[3][1].equals(user)&&!board[3][1].equals(computer)){
					board[3][1]=computer;
				}
				else if (!board[3][5].equals(user)&&!board[3][5].equals(computer)){
					board[3][5]=computer;
				}
				else if (!board[5][3].equals(user)&&!board[5][3].equals(computer)){
					board[5][3]=computer;
				}
			
			}
			else{
				board[drow2][dcol2]=computer;
				
			}
				
		}	
		
		else{
			board[drow][dcol]=computer;
			int[] temp=checkTwo(board,computer,user);
			if (winFlag=true){
				winSide=2;
			}
			
		}

	}
	

}
