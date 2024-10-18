package uk.ac.hw.macs.search;

import uk.ac.hw.macs.search.Node;
import uk.ac.hw.macs.search.example.BreadthFirstSearchOrder;
import uk.ac.hw.macs.search.example.IntState;

public class Main {

	
	public static void main(String[] args) {
		
		Node G = new Node(new HeuristicState("G", true, 3, 6));
		Node S = new Node(new HeuristicState("S", 1, 1, G));
		Node A = new Node(new HeuristicState("A", 1, 2, G));
		Node E = new Node(new HeuristicState("E", 2, 1, G));
		Node F = new Node(new HeuristicState("F", 2, 2, G));
		Node L = new Node(new HeuristicState("L", 3, 1, G));
		Node M = new Node(new HeuristicState("M", 3, 2, G));
		Node P = new Node(new HeuristicState("P", 4, 1, G));
		Node H = new Node(new HeuristicState("H", 2, 3, G));
		Node I = new Node(new HeuristicState("I", 2, 4, G));
		Node B = new Node(new HeuristicState("B", 1, 4, G));
		Node N = new Node(new HeuristicState("N", 3, 4, G));
		Node Q = new Node(new HeuristicState("Q", 4, 4, G));
		Node C = new Node(new HeuristicState("C", 1, 5, G));
		Node J = new Node(new HeuristicState("J", 2, 5, G));
		Node O = new Node(new HeuristicState("O", 3, 5, G));
		Node R = new Node(new HeuristicState("R", 4, 5, G));
		Node D = new Node(new HeuristicState("D", 1, 6, G));
		Node K = new Node(new HeuristicState("K", 2, 6, G));
		Node T = new Node(new HeuristicState("T", 4, 6, G));	
		
		S.addChild(A, 1);
		S.addChild(E, 2);
		A.addChild(F, 2);
		A.addChild(S, 1);
		E.addChild(F, 2);
		E.addChild(L, 1);
		F.addChild(H, 1);
		F.addChild(M, 1);
		F.addChild(A, 1);
		F.addChild(E, 2);
		L.addChild(E, 2);
		L.addChild(P, 2);
		L.addChild(M, 1);
		M.addChild(F, 2);
		M.addChild(L, 1);
		P.addChild(L, 1);
		H.addChild(F, 2);
		H.addChild(I, 2);
		I.addChild(H, 1);
		I.addChild(B, 2);
		I.addChild(N, 2);
		I.addChild(J, 1);
		B.addChild(I, 2);
		B.addChild(C, 1);
		N.addChild(I, 2);
		N.addChild(O, 2);
		N.addChild(Q, 1);
		Q.addChild(N, 2);
		Q.addChild(R, 2);
		R.addChild(Q, 1);
		R.addChild(O, 2);
		R.addChild(T, 2);
		T.addChild(R, 2);
		T.addChild(G, 1);
		G.addChild(T, 2);
		G.addChild(O, 2);
		G.addChild(K, 1);
		K.addChild(G, 1);
		K.addChild(J, 1);
		K.addChild(D, 1);
		D.addChild(K, 1);
		D.addChild(C, 1);
		C.addChild(D, 1);
		C.addChild(J, 1);
		C.addChild(B, 2);
		J.addChild(C, 1);
		J.addChild(I, 2);
		J.addChild(O, 2);
		J.addChild(K, 1);
		O.addChild(J, 1);
		O.addChild(N, 2);
		O.addChild(R, 2);
		O.addChild(G, 1);
		
		// Run the search
		SearchOrder order = new AStarSearchOrder();
		SearchProblem problem = new SearchProblem(order);
		problem.doSearch(S);
		
	}

}