#include <string>
#include <iostream>
#include <fstream>
#include "ics46goody.hpp"
#include "array_queue.hpp"
#include "hash_graph.hpp"
#include "dijkstra.hpp"



std::string get_node_in_graph(const ics::DistGraph& g, std::string prompt, bool allow_QUIT) {
 std::string node;
 for(;;) {
   node = ics::prompt_string(prompt + " (must be in graph" + (allow_QUIT ? " or QUIT" : "") + ")");
   if ((allow_QUIT && node == "QUIT") || g.has_node(node))
     break;
 }
 return node;
}


int main() {
 try {
   ics::DistGraph g;

   std::ifstream in_graph;
   ics::safe_open(in_graph,"Enter graph file name","flightdist.txt");
   g.load(in_graph);
   std::cout << g << std::endl;

   std::string start_node = get_node_in_graph(g,"Enter start node", false);

   ics::CostMap answer_map = extended_dijkstra(g,start_node);
   std::cout << answer_map << std::endl;

   for(;;) {
     std::string stop_node = get_node_in_graph(g,"\nEnter stop node", true);
     if (stop_node == "QUIT")
       break;
     std::cout << "Cost is " << answer_map[stop_node].cost << "; path is " << recover_path(answer_map,stop_node) << std::endl;
   }

 } catch (ics::IcsError& e) {
   std::cout << e.what() << std::endl;
 }

 return 0;
}
