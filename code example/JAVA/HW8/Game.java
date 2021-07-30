import java.util.Scanner;

/**
This class implements Tic Tac Toe interface
 */
public class Game {

	//FTurn equals "Y"(user) or "N"(computer")
	public String FTurn;
	public String Computer=" O ";
	public String User=" X ";
	
	public Game(){
		
	}
	
	/**
	 Ask user if he wants to take the first turn, then save the turn. Any input other than Y or N is disabled
	 */
	void setTurn(){
		Scanner in=new Scanner(System.in);
		System.out.print("Do you want to take the first turn(Y for Yes and N for No): ");		
		FTurn=in.next();
		System.out.println();		
		while (!FTurn.equals("Y")&&!FTurn.equals("N")){
			System.out.println("Invalid input! Please enter \"Y\" or \"N\"");	
			System.out.print("Do you want to take the first turn(Y for Yes and N for No): ");			
			FTurn=in.next();
		}				
	}
	
	
	/**
	 This board will read user drop, check if it's valid, and then drop the user's move
	 @param board
	 */
	void userDrop(String[][] board){
		int row;
		int col;
		boolean flag=true;
		
		Scanner in=new Scanner(System.in);
		System.out.print("I will drop in row(1-3): ");
		row=2*in.nextInt()-1;
		System.out.print("I will drop in column(1-3): ");
		col=2*in.nextInt()-1;
		
		while (flag){
			if ((row!=1&&row!=3&&row!=5)||(col!=1&&col!=3&&col!=5)){
				System.out.println("Invalid input! row and column should be 1-3");
				System.out.print("I will drop in row(1-3): ");
				row=2*in.nextInt()-1;
				System.out.print("I will drop in column(1-3): ");
				col=2*in.nextInt()-1;
			}
			else if (board[row][col].equals(User)||board[row][col].equals(Computer)){
				System.out.println("Invalid input! This ceil has been occupied");
				System.out.print("I will drop in row(1-3): ");
				row=2*in.nextInt()-1;
				System.out.print("I will drop in column(1-3): ");
				col=2*in.nextInt()-1;
			}
			else {
				flag=false;
			}			
		}	
		board[row][col]=User;		
	}
	
	/**
	 this method implement game interface
	 */	
	void play(){
		int count=0;
		Board aBoard=new Board();
		computerDrop cp=new computerDrop();
		System.out.println("Welcome to Tic Tac Toe!\n");
		System.out.println("Tips:");
		System.out.println("The \"row,col\" pair on the board can help you find your position quickly.");
		System.out.println("You will play \"X\", and computer will play \"O\".");
		System.out.println();
		System.out.println("Game Start!\n");
		aBoard.printBoard();
		setTurn();
		
		if (FTurn.equals("Y")){
			while (count<5){
				System.out.println("It's your turn!");
				userDrop(aBoard.board);
				aBoard.printBoard();					
				cp.Drop(aBoard.board,User,Computer);
				if (cp.winSide==1){
					System.out.println("The winner is: You!");	
					return;
				}
				else if (cp.winSide==2){
					System.out.println("Computer's turn!");
					aBoard.printBoard();
					System.out.println("The winner is: Computer!");		
					return;
					}
				System.out.println("Computer's turn!");
				aBoard.printBoard();
				count++;
			}
		}
		else{
			System.out.println("Computer's turn!");
			cp.Drop(aBoard.board,User,Computer);
			aBoard.printBoard();	
			while (count<4){
				System.out.println("It's your turn!");
				userDrop(aBoard.board);
				aBoard.printBoard();	
				
				cp.Drop(aBoard.board,User,Computer);
				if (cp.winSide==1){
					System.out.println("The winner is: You!");	
					return;
				}
				else if (cp.winSide==2){
					System.out.println("Computer's turn!");
					aBoard.printBoard();	
					System.out.println("The winner is: Computer!");		
					return;
					}
				System.out.println("Computer's turn!");
				aBoard.printBoard();	
				count++;
			}
			
		}
		System.out.println("No winner!");
	}
	
	public static void main(String[] args) {
		Game game=new Game();		
		game.play();
		System.out.println("\nThank you for playing the game!");


	}

}
