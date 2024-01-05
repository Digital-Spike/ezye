import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({Key? key}) : super(key: key);

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  Map<String, bool> checkedValues = {
    'checkbox1': false,
    'checkbox2': false,
    'checkbox3': false,
    'checkbox4': false,
    'checkbox5': false,
    'checkbox6': false,
    'checkbox7': false,
    'checkbox8': false,
    'checkbox9': false,
    'checkbox10': false,
    'checkbox11': false,
    'checkbox12': false,
    'checkbox13': false,
    'checkbox14': false,

    // Add more checkboxes with unique keys...
  };
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  bool checkedValue = false; // Define the checkedValue variable

  @override
  Widget build(BuildContext context) {
      // Color buttonColor = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            color: const Color(0xffE8E9EE),
          ),
        ),
        leading: const BackButton(color: Colors.black),
        title: const Text('Filter'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),//HOLE CODE WILL ALIGN
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(
                        margin: const EdgeInsets.only(top: 6,left: 8),   // ONLY FOR CATE
                        child: Text(
                          'Category',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ListTileTheme(
  child: Column(
    children: [
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,  //PADDING FOR 1ST 
          title: Text(
            "Categories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox1'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox1'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.only(left: 40), //PADDING FOR 1ST 
          title: Text(
            "Subcategories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox2'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox2'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.only(left: 40), //PADDING FOR 1ST 
          title: Text(
            "Subcategories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox3'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox3'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,        //PADDING FOR 1ST 
          title: Text(
            "Categories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox4'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox4'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,            //PADDING FOR 1ST 
          title: Text(
            "Categories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox5'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox5'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
      SizedBox(
        height: 30,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,                      //PADDING FOR 1ST 
          title: Text(
            "Categories name goes here",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox6'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox6'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ],
  ),
),
                            //CATEGORY END
                       //Button part SIZE

                   Container(
  margin: const EdgeInsets.only(top: 20, left: 8),
  child: Text(
    'Sizes',
    style: TextStyle(fontSize: 20),
  ),
),
Row(
  children: [
    
     Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
            ),
          ),
        ),
        onPressed: () {},
        child: Text('S',style: TextStyle(fontSize: 20),),
       
      ),
    ),
    SizedBox(width: 5),
    Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
            ),
          ),
        ),
        onPressed: () {},
        child: Text('M',style: TextStyle(fontSize: 20),),
       
      ),
    ),
    SizedBox(width: 5),
    Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
            ),
          ),
        ),
        onPressed: () {},
        child: Text('L',style: TextStyle(fontSize: 20),),
       
      ),
    ),
    SizedBox(width: 5),
    Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
            ),
          ),
        ),
        onPressed: () {},
        child: Text('XL',style: TextStyle(fontSize: 20),),
       
      ),
    ),
    SizedBox(width: 5),
  ],
),

                                     //Button part end


                    Container(
  margin: const EdgeInsets.only(top: 8, left: 8),
  child: Text(
    'Price',
    style: TextStyle(fontSize: 20),
  ),
),
RangeSlider(
  values: _currentRangeValues,
  max: 100,
  divisions: 3,
  labels: RangeLabels(
    _currentRangeValues.start.round().toString(),
    _currentRangeValues.end.round().toString(),
  ),
  onChanged: (RangeValues values) {
    setState(() {
      _currentRangeValues = values;
    });
  },
),
Container(
  padding: EdgeInsets.symmetric(horizontal: 10),
  margin: EdgeInsets.only(bottom: 5),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 2),
          SizedBox(
  width: 160,
  child: Container(
  width: 180,
  padding: EdgeInsets.symmetric(horizontal: 10),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), // Border for the container
    borderRadius: BorderRadius.circular(5),
  ),
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.currency_rupee_sharp,
          color: Colors.black,
        ),
      ),
      Container(
        width: 1,
        color: Colors.black, // Color of the vertical line
      ),
      SizedBox(width: 5), // Add some space between the line and text field
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // Hide TextField border
            hintText: 'Enter amount',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13,),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    ],
  ),
)

)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 1),
        SizedBox(
  width: 160,
  child: Container(
  width: 180,
  padding: EdgeInsets.symmetric(horizontal: 10),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), // Border for the container
    borderRadius: BorderRadius.circular(5),
  ),
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.currency_rupee_sharp,
          color: Colors.black,
        ),
      ),
      Container(
        width: 1,
        color: Colors.black, // Color of the vertical line
      ),
      SizedBox(width: 5), // Add some space between the line and text field
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // Hide TextField border
            hintText: 'Enter amount',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    ],
  ),
)

)
        ],
      ),
    ],
  ),
),

                  //price end

                  //Discount start

                 Container(
  margin: const EdgeInsets.only(left: 8, top: 6, bottom: 0),
  child: Text(
    'Discount',
    style: TextStyle(fontSize: 20),
  ),
),

Row(
  children: [
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox7'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox7'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),
    SizedBox(width: 10), // Adjust the width between checkboxes
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox8'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox8'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),   
  ],
),

Row(
  children: [
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox9'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox9'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),
    SizedBox(width: 10), // Adjust the width between checkboxes
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox10'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox10'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),   
  ],
),

Row(
  children: [
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox11'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox11'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),
    SizedBox(width: 10), // Adjust the width between checkboxes
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox12'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox12'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),   
  ],
),

Row(
  children: [
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox13'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox13'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),
    SizedBox(width: 10), // Adjust the width between checkboxes
    Flexible(
      child: SizedBox(
        height: 25,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          dense: true,
          title: Text(
            "ABOVE 500",
            style: TextStyle(fontSize: 13),
          ),
          value: checkedValues['checkbox14'] ?? false,
          onChanged: (newValue) {
            setState(() {
              checkedValues['checkbox14'] = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),   
  ],
),





                     //Discount end

                    //  elevted button//
                   
       Container(
  margin: EdgeInsets.only(top: 40),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      
      SizedBox(
        width: 170,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Clear',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
      SizedBox(
        height: 50,
        width: 170,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black), // Adjust the radius and color as needed
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Apply Filter',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    ],
  ),
),
                            //elevated button end
                      

                  
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
