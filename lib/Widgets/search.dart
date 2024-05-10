import 'package:flutter/material.dart';
class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          // Notify the parent widget about the search query
          // You can use a callback function passed from the parent widget to handle this
        },
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.black),
          hintText: "Chercher N° commande",
        ),
      ),
    );
  }
}
/*
class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
   
  @override
  Widget build(BuildContext context) {
    return Container(
decoration: BoxDecoration(
 borderRadius: const BorderRadius.all(Radius.circular(8)),
 color: Colors.white,
 border: Border.all(color: Colors.grey),
),
padding: const EdgeInsets.symmetric(horizontal: 8) ,
child:const TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(Icons.search, color: Colors.black, ),
        hintText: "Chercher N° commande",
      ),
    ),



    );

  }
}


-----------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final TextEditingController _searchController = TextEditingController();
  List<String> docIDs = [];
  List<String> filteredDocIds = []; // Declare filteredDocIds list

  @override
  void initState() {
    super.initState();

    // Add listener to searchController
    _searchController.addListener(() {
      setState(() {
        // Trigger search on query change
        filterDocIds(_searchController.text);
      });
    });

    // Call getDocId in initState
    getDocId();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }

  // Function to filter document IDs based on search input
void filterDocIds(String searchQuery) {
  setState(() {
    print('Search query: $searchQuery'); // Add this line for debugging
    // Filtering docIDs based on search query
    filteredDocIds = docIDs
        .where((id) => id.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    print('Filtered document IDs: $filteredDocIds'); // Add this line for debugging
  });
}


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference commandes = FirebaseFirestore.instance.collection('commandes');

  // Function to get document IDs
  Future<void> getDocId() async {
    try {
      final snapshot = await commandes.get();
      setState(() {
        docIDs = snapshot.docs.map((doc) => doc.id).toList();
        filteredDocIds = List.from(docIDs); // Initially set filteredDocIds to all docIDs
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
  }

  bool showPinView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchWidget(searchController: _searchController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          showPinView = false;
                        });
                      },
                      color: GlobalColors.mainColor,
                      icon: Image.asset(
                        "images/liste_icon.png",
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GlobalColors.childmainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showPinView = true;
                      });
                    },
                    color: GlobalColors.mainColor,
                    icon: Image.asset(
                      "images/pin-icon.png",
                    ),
                  ),
                ),
              ],
            ),
            if (!showPinView) ...[
              SizedBox(height: 20),
              Text(
                "NEW ORDER ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: '40 Nouveaux ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'commandes sont disponibles'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Tous les commandes ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("images/filtre.png"),
                  ),
                ],
              ),
            Expanded(
                 child: FutureBuilder<void>(
  future: getDocId(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // or any loading indicator
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return ListView.builder(
        itemCount: docIDs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GetCommande(documentId: docIDs[index], fromHomepage: true),
          );
        },
      );
    }
  }
)
            )
            ],
          ],
        ),
      ),
    );
  }
}

*/