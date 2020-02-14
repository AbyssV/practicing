#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include "ics46goody.hpp"
#include "array_queue.hpp"
#include "array_priority_queue.hpp"
#include "array_set.hpp"
#include "array_map.hpp"


typedef ics::ArraySet<std::string>          NodeSet;
typedef ics::pair<std::string,NodeSet>      GraphEntry;

bool graph_entry_gt (const GraphEntry& a, const GraphEntry& b)
{return a.first<b.first;}

typedef ics::ArrayPriorityQueue<GraphEntry,graph_entry_gt> GraphPQ;
typedef ics::ArrayMap<std::string,NodeSet>  Graph;


//Read an open file of edges (node names separated by semicolons, with an
//  edge going from the first node name to the second node name) and return a
//  Graph (Map) of each node name associated with the Set of all node names to
//  which there is an edge from the key node name.
Graph read_graph(std::ifstream &file) {
	Graph graph;
 std::string line;
	while (getline(file,line)) {
		std::vector<std::string> line_sp = ics::split(line,";");
		std::string source = line_sp[0];
		std::string dest   = line_sp[1];
   // Note: for maps, if source is not a key, it will create a key with an empty set
		//  to which dest is associated
		graph[source].insert(dest);
	}
	file.close();

 return graph;
}


//Print a label and all the entries in the Graph in alphabetical order
//  (by source node).
//Use a "->" to separate the source node name from the Set of destination
//  node names to which it has an edge.
void print_graph(const Graph& graph) {
 std::cout << "\nGraph: source -> set[destination] edges" << std::endl;
 GraphPQ nodes_sorted(graph);
 for (const GraphEntry& kv : nodes_sorted)
   std::cout << "  " << kv.first << " -> " << kv.second << std::endl;
}


//Return the Set of node names reaching in the Graph starting at the
//  specified (start) node.
//Use a local Set and a Queue to respectively store the reachable nodes and
//  the nodes that are being explored.
NodeSet reachable(const Graph& graph, std::string start) {
	NodeSet reached;
	ics::ArrayQueue<std::string> exploring;

	exploring.enqueue(start);
	while (exploring.size() != 0) {
		std::string s = exploring.dequeue();
		reached.insert(s);

		if (graph.has_key(s)) {
     for (const std::string& n : graph[s])
       if (!reached.contains(n))
         exploring.enqueue(n);
		}
	}

 return reached;
}





//Prompt the user for a file, create a graph from its edges, print the graph,
//  and then repeatedly (until the user enters "quit") prompt the user for a
//  starting node name and then either print an error (if that the node name
//  is not a source node in the graph) or print the Set of node names
//  reachable from it using the edges in the Graph.
int main() {
 try {
   std::ifstream in_graph;
   ics::safe_open(in_graph,"Enter graph file name","graph.txt");
   Graph graph = read_graph(in_graph);
   print_graph(graph);

   for(;;) {
     std::string start = ics::prompt_string("\nEnter starting node (enter quit to quit)");
     if (start == "quit")
       break;
     if (!graph.has_key(start))
       std::cout << "  " << start << " is not a source node name in the graph" << std::endl;
     else{
       NodeSet reached = reachable(graph,start);
       std::cout << "Reachable from node name " << start << " = " << reached << std::endl;
     }
   }

 } catch (ics::IcsError& e) {
   std::cout << e.what() << std::endl;
 }

 return 0;
}
