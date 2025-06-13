import 'package:flutter/material.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';

class AccordionView extends StatefulWidget {
  final List<AccordionItem> items;

  final Function(int, bool) onExpansionChanged; // Added parameter

  const AccordionView({
    Key? key,
    required this.items,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  _AccordionViewState createState() => _AccordionViewState();
}

class _AccordionViewState extends State<AccordionView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),

        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            widget.onExpansionChanged(index, !isExpanded); // Call the callback
          },
          children: widget.items.asMap().entries.map<ExpansionPanel>((entry) {
            final int index = entry.key;
            final AccordionItem item = entry.value;
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  onTap: () {
            widget.onExpansionChanged(index, !isExpanded); // Call the callback
          } ,
                  title: Text(
                    item.headerValue,
                    style: TextStyle(
                      // Define your text styles here
                      fontWeight: FontWeight.bold, // Example: bold font weight
                      fontSize: 11, // Example: font size 16
                      color: Colors.orange, // Example: blue color
                      // Add more text styles as needed
                    ),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    title: Text(
                      item.expandedValue,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "فرصت یادگیری :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      item.learningOpportunity,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "ابزار :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      item.requiredTools,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  5.dpv,
                ],
              ),
              isExpanded: item.isExpanded, // Use the corresponding value from isExpandedList
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AccordionItem {
  String expandedValue;
  String headerValue;
  String requiredTools;
  String learningOpportunity;
  bool isExpanded;

  AccordionItem({
    required this.expandedValue,
    required this.headerValue,
    required this.requiredTools,
    required this.learningOpportunity,
    this.isExpanded = false,
  });
}
