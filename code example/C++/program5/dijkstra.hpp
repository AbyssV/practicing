#ifndef DIJKSTRA_HPP_
#define DIJKSTRA_HPP_

#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <limits>                    //Biggest int: std::numeric_limits<int>::max()
#include "array_queue.hpp"
#include "array_stack.hpp"
#include "heap_priority_queue.hpp"
#include "hash_graph.hpp"


namespace ics {


class Info {
  public:
    Info() { }

    Info(std::string a_node) : node(a_node) { }

    bool operator==(const Info &rhs) const { return cost == rhs.cost && from == rhs.from; }

    bool operator!=(const Info &rhs) const { return !(*this == rhs); }

    friend std::ostream &operator<<(std::ostream &outs, const Info &i) {
      outs << "Info[" << i.node << "," << i.cost << "," << i.from << "]";
      return outs;
    }

    //Public instance variable definitions
    std::string node = "?";
    int cost = std::numeric_limits<int>::max();
    std::string from = "?";
  };


  bool gt_info(const Info &a, const Info &b) { return a.cost < b.cost; }

  typedef ics::HashGraph<int> DistGraph;
  typedef ics::HeapPriorityQueue<Info, gt_info> CostPQ;
  typedef ics::HashMap<std::string, Info, DistGraph::hash_str> CostMap;
  typedef ics::pair<std::string, Info> CostMapEntry;


//Return the final_map as specified in the lecture-node description of
//  extended Dijkstra algorithm
  CostMap extended_dijkstra(const DistGraph &g, std::string start_node) {
    CostMap info_map, answer_map;
    CostPQ info_pq;

    //Initialize info_map and info_pq
    for (auto &e : g.all_nodes()) {
      Info i = Info(e.first);
      if (e.first == start_node)
        i.cost = 0;
      info_map[e.first] = i;
      info_pq.enqueue(i);
    }



    //While there are still nodes available in the info_map, expand
    //  the frontier by movingthe  smallest cost Info from info_pq into
    //  answer_map, and then updating (and enqueueing into info_pq) any
    //  newly minimal costs.
    while (!info_map.empty()) {
      Info min_info = info_pq.dequeue();
      std::string min_node = min_info.node;
      int min_cost = min_info.cost;

      if (min_cost == std::numeric_limits<int>::max())
        break;

      if (!answer_map.has_key(min_node)) {
        //Move found smallest cost to answer_map
        answer_map[min_node] = info_map[min_node];
        info_map.erase(min_node);

        //Update info_map and info_pq if new smaller costs found
        for (const typename DistGraph::NodeName &d : g.out_nodes(min_node))
          if (!answer_map.has_key(d)) {
            int new_cost = min_cost + g.edge_value(min_node, d);
            Info &i = info_map[d];
            if (new_cost < i.cost) {
              i.cost = new_cost;
              i.from = min_node;
              info_pq.enqueue(i);
            }
          }
      }
    }

    return answer_map;
  }


//Return a queue whose front is the start node (implicit in answer_map) and whose
//  rear is the end node
  ArrayQueue <std::string> recover_path(const CostMap &answer_map, std::string end_node) {
    ics::ArrayStack<std::string> reverse_path;
    while (end_node != "?") {
      reverse_path.push(end_node);
      end_node = answer_map[end_node].from;
    }

    return ArrayQueue<std::string>(reverse_path);
  }


}

#endif /* DIJKSTRA_HPP_ */
