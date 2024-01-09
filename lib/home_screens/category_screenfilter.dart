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

  // bool checkedValue = false; // Define the checkedValue variable

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
                        margin: EdgeInsets.only(left: 5,top: 8,bottom: 5),
                        child: Text(
                          'Category',
                          style: TextStyle(fontSize: 16,color: Colors.grey),
                        ),
                      ),
                      ListTileTheme(
  child: Column(
    children: [
      Row(
        children: [
            SizedBox(
              height: 25,
              child: Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox1'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox1'] = newValue!;
                        }
                        );
                      },
                    ),
            ),
      Text('Categories name goes here'),
        ],
      ),
    
     Padding(
       padding: const EdgeInsets.only(left: 36),
       child: Row(
          children: [
              SizedBox(
                height: 25,
                child: Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox2'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox2'] = newValue!;
                          }
                          );
                        },
                      ),
              ),
        Text('Subcategories name goes here'),
          ],
        ),
     ),
      Padding(
        padding: const EdgeInsets.only(left: 36),
        child: Row(
          children: [
              SizedBox(
                height: 25,
                child: Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox3'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox3'] = newValue!;
                          }
                          );
                        },
                      ),
              ),
        Text('Subcategories name goes here'),
          ],
        ),
      ),
      Row(
        children: [
            SizedBox(
              height: 25,
              child: Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox4'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox4'] = newValue!;
                        }
                        );
                      },
                    ),
            ),
      Text('Categories name goes here'),
        ],
      ),Row(
        children: [
            SizedBox(
              height: 25,
              child: Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox5'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox5'] = newValue!;
                        }
                        );
                      },
                    ),
            ),
      Text('Categories name goes here'),
        ],
      ),Row(
        children: [
            SizedBox(
              height: 25,
              child: Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox6'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox6'] = newValue!;
                        }
                        );
                      },
                    ),
            ),
      Text('Categories name goes here'),
        ],
      ),
    ],
  ),
),
                            //CATEGORY END
                       //Button part SIZE

                   Container(
  margin: const EdgeInsets.only(top: 10, left: 8,bottom: 5),
  child: Text(
    'Sizes',
    style: TextStyle(fontSize: 16,color: Colors.grey),
  ),
),
Row(
  children: [
    
     Padding(
      padding: const EdgeInsets.only(left: 10),
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
              side: BorderSide(color: Colors.black), 
              // Adjust the radius and color as needed
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
  margin: const EdgeInsets.only(top: 12, left: 8),
  child: Text(
    'Price',
    style: TextStyle(fontSize: 16,color: Colors.grey),
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
  margin: EdgeInsets.only(bottom: 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From',
            style: TextStyle(fontSize: 16,color: Colors.grey),
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
            style: TextStyle(fontSize: 16,color: Colors.grey),
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
  margin: const EdgeInsets.only(left: 8, top: 10, bottom: 5),
  child: Text(
    'Discount',
    style: TextStyle(fontSize: 16,color: Colors.grey),
  ),
),

SizedBox(
  height: 30,
  child: Row(
    children: [
  
        Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox7'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox7'] = newValue!;
                        }
                        );
                      },
                    ),
        const Text('Above ₹ 500'),
      
      SizedBox(width: 35), 
  
      Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox8'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox8'] = newValue!;
                          }
                          );
                        },
                      ),// 
               const Text('Above ₹ 500'),
    ],
  ),
),
SizedBox(
  height: 30,
  child: Row(
    children: [
  
        Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox9'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox9'] = newValue!;
                        }
                        );
                      },
                    ),
        const Text('Above ₹ 500'),
      
      SizedBox(width: 35), 
      
      Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox10'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox10'] = newValue!;
                          }
                          );
                        },
                      ),// 
               const Text('Above ₹ 500'),
    ],
  ),
),
SizedBox(
  height: 30,
  child: Row(
    children: [
  
        Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox11'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox11'] = newValue!;
                        }
                        );
                      },
                    ),
        const Text('Above ₹ 500'),
      
      SizedBox(width: 35), 
      
      Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox12'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox12'] = newValue!;
                          }
                          );
                        },
                      ),// 
               const Text('Above ₹ 500'),
    ],
  ),
),
SizedBox(
  height: 30,
  child: Row(
    children: [
  
        Checkbox(
                       // The named parameter 'title' isn't defined.
                      value: checkedValues['checkbox13'] ?? false,
                      onChanged: (newValue) 
                      { 
                        setState(()
                        {
              checkedValues['checkbox13'] = newValue!;
                        }
                        );
                      },
                    ),
        const Text('Above ₹ 500'),
      
      SizedBox(width: 35), 
      
      Checkbox(
                         // The named parameter 'title' isn't defined.
                        value: checkedValues['checkbox14'] ?? false,
                        onChanged: (newValue) 
                        { 
                          setState(()
                          {
                checkedValues['checkbox14'] = newValue!;
                          }
                          );
                        },
                      ),// 
               const Text('Above ₹ 500'),
    ],
  ),
),



                     //Discount end

                    //  elevted button//
                   
       Container(
  margin: EdgeInsets.only(top: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      
      SizedBox(
        width: 150,
        height: 43,
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
          onPressed: () 
          {

          },
          child: Text(
            'Clear',
            style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        height: 43,
        width: 150,
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
          onPressed: ()
           {

           },
          child: Text(
            'Apply Filter',
            style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
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
