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
	
	
	@Override
	public void addToFringe(List<FringeNode> frontier, FringeNode parent, Set<ChildWithCost> children) {
	
		PriorityQueue<FringeNode> fringe = new PriorityQueue<>(new Comparator<FringeNode>() {
			
			@Override
			public int compare(FringeNode fn1, FringeNode fn2) {
				int fValueComparison =  Integer.compare(fn1.getFValue(), fn2.getFValue());
				
				if (fValueComparison == 0) {
					String node1Value = ((HeuristicState) fn1.node.getValue()).getValue();
					String node2Value = ((HeuristicState) fn2.node.getValue()).getValue();
					return node1Value.compareTo(node2Value);
				}
				return fValueComparison;
			}
		});
		
		HashSet<Node> visited = new HashSet<>();
		
	   for (FringeNode fn : frontier) {
	            fringe.add(fn);
	   }
		
		for (ChildWithCost childWithCost : children) {
			FringeNode childFringeNode = new FringeNode(childWithCost.node, parent, childWithCost.cost);
			
			if(!visited.contains(childFringeNode.node)) {
				fringe.add(childFringeNode);
				visited.add(childFringeNode.node);
			}
		}
			
		
		frontier.clear();
		while (!fringe.isEmpty()) {
			frontier.add(fringe.poll());
			
		}
	
}

}