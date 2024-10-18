

// Define a class to represent a Rute with associated text and destination node
class Rute {
  final int value; // The distance value of the rute
  final Vertices destination; // The destination node

  Rute(this.value, this.destination);
}

// Define Vertices class, which represents a node
class Vertices {
  String text; // Name of the node (e.g., A, B, C)
  List<Rute> rutes; // A list of possible rute distances associated with their text

  Vertices(this.text, this.rutes);
}

// Define MyLinkedList class, which contains a linked list of Vertices
class MyLinkedList {
  List<Vertices> list = []; // Changed to a simple list for easier access
  List<List<Rute>> validRoutes = []; // Store valid routes
  List<Rute>? shortestRoute; // Store the shortest route found

  // Add a new node with multiple rute values and their associated texts
  void append(String text, List<Rute> rutes) {
    Vertices newNode = Vertices(text, rutes);
    list.add(newNode);

    // Add reverse rutes to each node
    for (Rute rute in rutes) {
      rute.destination.rutes.add(Rute(rute.value, newNode)); // Add the reverse connection
    }
  }

  // Function to traverse through each node and calculate valid routes
  void findAllRoutes() {
    // Start from the specified starting node (A)
    Vertices startNode = list.firstWhere(
      (node) => node.text == "A",
      orElse: () => throw Exception("Start node A not found."),
    );

    // Call the recursive function starting from node A
    calculateRoutes([], startNode, {}, 0);

    // Output valid routes and the shortest route
    _printValidRoutes();
    _printShortestRoute();
  }

  // Helper function to calculate valid routes recursively
  void calculateRoutes(List<Rute> currentRoute, Vertices currentNode, Set<String> visited, int count) {
    // Mark the current node as visited
    visited.add(currentNode.text);

    // Check if we have visited all nodes (A, B, C, D, E)
    if (visited.length == 5 && currentNode.text == 'A') {
      validRoutes.add(currentRoute); // Add the valid route to validRoutes
      // Update the shortest route if necessary
      if (shortestRoute == null || _calculateRouteDistance(currentRoute) < _calculateRouteDistance(shortestRoute!)) {
        shortestRoute = currentRoute;
      }
    } else {
      // Traverse all rute options for the current node
      for (Rute rute in currentNode.rutes) {
        if (!visited.contains(rute.destination.text) || (rute.destination.text == 'A' && visited.length == 5)) {
          // Move to the next node by adding the current rute to the route
          List<Rute> newRoute = [...currentRoute, rute];

          // Recursively call the function for the destination node
          calculateRoutes(newRoute, rute.destination, Set.from(visited), count + 1);
        }
      }
    }

    // Backtrack: remove the current node from the visited set after exploring
    visited.remove(currentNode.text);
  }

  // Calculate the total distance of a given route
  int _calculateRouteDistance(List<Rute> route) {
    return route.map((rute) => rute.value).reduce((a, b) => a + b);
  }

  // Function to print valid routes
  void _printValidRoutes() {
    print("Valid routes visiting all nodes:");
    if (validRoutes.isEmpty) {
      print("No valid routes found.");
    } else {
      for (var route in validRoutes) {
        String routeDescription = route.map((rute) => '${rute.value} (to ${rute.destination.text})').join(' -> ');
        print(routeDescription);
      }
    }
  }

  // Function to print the shortest route
  void _printShortestRoute() {
    if (shortestRoute != null) {
      String shortestDescription = shortestRoute!.map((rute) => '${rute.value} (to ${rute.destination.text})').join(' -> ');
      print("Shortest route: $shortestDescription with total distance: ${_calculateRouteDistance(shortestRoute!)}");
    } else {
      print("No shortest route found.");
    }
  }
}

void main() {
  MyLinkedList ll = MyLinkedList();

  // Create vertices and their possible rutes with connections
  Vertices a = Vertices("A", []);
  Vertices b = Vertices("B", []);
  Vertices c = Vertices("C", []);
  Vertices d = Vertices("D", []);
  Vertices e = Vertices("E", []);
  Vertices f = Vertices("F", []);

  // Adding rutes connecting nodes
  a.rutes.add(Rute(10, e)); // A to E
  a.rutes.add(Rute(8, b));  // A to B
  a.rutes.add(Rute(3, c));  // A to C
  a.rutes.add(Rute(4, d));  // A to D
  b.rutes.add(Rute(5, c));   // B to C
  b.rutes.add(Rute(7, e));   // B to E
  b.rutes.add(Rute(2, d));   // B to D
  c.rutes.add(Rute(6, e));   // C to E
  c.rutes.add(Rute(1, d));   // C to D
  d.rutes.add(Rute(3, e));   // D to E
  e.rutes.add(Rute(12, f));  // E to F

  // Add vertices to the linked list
  ll.append("A", a.rutes);
  ll.append("B", b.rutes);
  ll.append("C", c.rutes);
  ll.append("D", d.rutes);
  ll.append("E", e.rutes);
  ll.append("F", f.rutes);

  // Find and print valid routes
  ll.findAllRoutes();
}
