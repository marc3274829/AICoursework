package uk.ac.hw.macs.search;

public class HeuristicState implements State {

	private String value;
	private boolean goal;
	private int x;
	private int y;
	private Node goalNode;
	
	public HeuristicState (String value, boolean goal, int x, int y) {
		this(value, goal, x, y, null);
	}
	
	
	public HeuristicState (String value, int x, int y, Node goalNode) {
		this(value, false, x, y, goalNode);
	}
	
	public HeuristicState (String value, boolean goal, int x, int y, Node goalNode) {
		this.value = value; 
		this.goal = goal;
		this.x = x;
		this.y = y;
		this.goalNode = goalNode;
	}

	
	
	public int getHeuristic() {
		if(goal) {
			return 0;
		}
		
		HeuristicState goalState = (HeuristicState) goalNode.getValue();
		int goalX = goalState.x;
		int goalY = goalState.y;
		
		return Math.abs (this.x - goalX) + Math.abs(this.y - goalY);
	}
	
	public boolean isGoal() {
		return this.goal;
	}
	
	public String getValue() {
		return value;
	}

	
	public String toString() {
		return "HeuristicState [value=" + value + ", goal=" + goal +  ", x=" + x + ", y= " + y + "]";
	}
	
	
}
