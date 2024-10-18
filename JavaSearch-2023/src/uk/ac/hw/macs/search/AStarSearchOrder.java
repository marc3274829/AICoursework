package uk.ac.hw.macs.search;

import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;
import java.util.Comparator;
import java.util.HashSet;

import uk.ac.hw.macs.search.ChildWithCost;
import uk.ac.hw.macs.search.FringeNode;
import uk.ac.hw.macs.search.SearchOrder;


public class AStarSearchOrder implements SearchOrder {
	
	private Set<Node> visitedStates = new HashSet<>();
	@Override
	public void addToFringe(List<FringeNode> frontier, FringeNode parent, Set<ChildWithCost> children) {
	
		PriorityQueue<FringeNode> fringe = new PriorityQueue<>(new Comparator<FringeNode>() {
			
			// Check which cost is cheaper between fringes
			@Override
			public int compare(FringeNode fn1, FringeNode fn2) {
				int fValueComparison =  Integer.compare(fn1.getFValue(), fn2.getFValue());
				
				// If costs are equal, use the earlier letter in the alphabet
				if (fValueComparison == 0) {
					String node1Value = ((HeuristicState) fn1.node.getValue()).getValue();
					String node2Value = ((HeuristicState) fn2.node.getValue()).getValue();
					return node1Value.compareTo(node2Value);
				}
				return fValueComparison;
			}
		});
		
		// Add all nodes in the frontier to the priority queue
	   for (FringeNode fn : frontier) {
	            fringe.add(fn);
	   }
		
		for (ChildWithCost childWithCost : children) {
			// If the child node hasn't been visited yet, add it to the fringe
			if (!visitedStates.contains(childWithCost.node)) {
				FringeNode childFringeNode = new FringeNode(childWithCost.node, parent, childWithCost.cost);
				fringe.add(childFringeNode);
				visitedStates.add(childWithCost.node);
			}
		
		}
			
		// Clear the frontier list to update it
		frontier.clear();
		// Add all nodes from the fringe to the frontier
		while (!fringe.isEmpty()) {
			frontier.add(fringe.poll());
			
		}
	
}

}