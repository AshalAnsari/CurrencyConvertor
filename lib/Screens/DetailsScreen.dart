import 'package:currency_convertor/Components/selector.dart';
import 'package:currency_convertor/Components/textInputFeild.dart';
import 'package:currency_convertor/Functions/color.dart';
import 'package:currency_convertor/Functions/myPref.dart';
import 'package:currency_convertor/Functions/mySharedref.dart';
import 'package:currency_convertor/Screens/UserScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];
  List<String> countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia"
  ];
  String? selectedGender;
  String? selectedCountry;
  DateTime? selectedDate;
  String? selectedTime;

  void changeValue(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  void changeCountryValue(String? value) {
    setState(() {
      selectedCountry = value;
    });
  }

  void performChecks() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _nameController.text.isEmpty
            ? Text('Name is missing')
            : _emailController.text.isEmpty
                ? Text('Email is missing')
                : _passwordController.text.isEmpty
                    ? Text('Password is missing')
                    : _passwordController.text.length < 8
                        ? Text('Password should be atleast of 8 characters')
                        : _confirmPassController.text.isEmpty
                            ? Text('Confirm password is missing')
                            : selectedGender == null
                                ? Text('Gender is missing')
                                : selectedCountry == null
                                    ? Text('Country is missing')
                                    : selectedDate == null
                                        ? Text('Date is missing')
                                        : selectedTime == null
                                            ? Text('Time is missing')
                                            : _passwordController.text !=
                                                    _confirmPassController.text
                                                ? Text('Confirm password again')
                                                : Text('Login Successful'),
      ),
    );

    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 8 &&
        _confirmPassController.text.isNotEmpty &&
        selectedGender != null &&
        selectedCountry != null &&
        selectedDate != null &&
        selectedTime != null &&
        _passwordController.text == _confirmPassController.text) {
      MyPref().setLoginData(
          "{Name: ${_nameController.text}, Email: ${_emailController.text}, Password: ${_passwordController.text}, Confirm Password: ${_confirmPassController.text}, Gender: ${selectedGender}, Country: ${selectedCountry}, Date: ${selectedDate}, Time: ${selectedTime}}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserScreen()) // Replace SuccessScreen with your target screen
          );
    }
  }

  void printData() {
    print(
        " Name: ${_nameController.text}\n Email: ${_emailController.text}\n Password: ${_passwordController.text}\n Confirm Password: ${_confirmPassController.text}\n Gender: ${selectedGender}\n Country: ${selectedCountry}\n Date: ${selectedDate}\n Time: ${selectedTime}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Center(child: Text("Details Form")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserScreen()));
              },
              icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: colorController.bgColorup,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.05,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textInputFeild(
                        _nameController, "Enter Your Name", Icons.person),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.20,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textInputFeild(_emailController,
                        "Enter Your Email Address", Icons.email),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.35,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textInputFeild(_passwordController,
                        "Enter Your Password", Icons.password),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.50,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textInputFeild(_confirmPassController,
                        "Confirm Password", Icons.password_outlined),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.65,
                left: MediaQuery.sizeOf(context).width * 0.03,
                right: MediaQuery.sizeOf(context).width * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Select Gender",
                          style: TextStyle(color: Colors.white),
                        ),
                        selectorForCurrency(
                            selectedGender, changeValue, gender),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Select Country",
                          style: TextStyle(color: Colors.white),
                        ),
                        selectorForCurrency(
                            selectedCountry, changeCountryValue, countries),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.775,
                left: 0,
                right: MediaQuery.sizeOf(context).width * 0.65,
                child: Column(
                  children: [
                    if (selectedDate == null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorController.categoryBtnColor,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                        ),
                        onPressed: () async {
                          DateTime? datepicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025));

                          if (datepicked != null) {
                            setState(() {
                              selectedDate = datepicked;
                              MySharedPrefrence()
                                  .set_versioncode(selectedDate.toString());
                            });
                          }
                        },
                        child: Text(
                          "Select Date",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    else
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.05,
                          ),
                          Text(
                            "Date",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = null;
                                });
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    Text(
                      "${selectedDate != null ? selectedDate.toString().split(" ")[0] : ""}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.775,
                left: MediaQuery.sizeOf(context).width * 0.65,
                right: 0,
                child: Column(
                  children: [
                    if (selectedTime == null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorController.categoryBtnColor,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                        ),
                        onPressed: () async {
                          TimeOfDay? timepicked = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (timepicked != null) {
                            String formattedTime =
                                '${timepicked.hour.toString().padLeft(2, '0')}:${timepicked.minute.toString().padLeft(2, '0')}';

                            print(formattedTime);
                            setState(() {
                              selectedTime = formattedTime;
                            });
                          }
                        },
                        child: Text(
                          "Select Time",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    else
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.073,
                          ),
                          Text(
                            "Time",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedTime = null;
                                });
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    Text(
                      "${selectedTime ?? ""}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.875,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      performChecks();
                      // printData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorController.categoryBtnColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width * 0.06,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
