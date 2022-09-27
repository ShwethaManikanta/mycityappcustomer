import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/profile_model.dart';
import '../Services/api_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController yourname = TextEditingController();
  TextEditingController email = TextEditingController();
  ImagePicker imagePicker = ImagePicker();

  File? profilepic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Color.fromARGB(255, 88, 26, 22),
                      size: 30,
                    ),
                  ),
                ),
                const Text(
                  'Your Profile',
                  style: TextStyle(
                      color: Color.fromARGB(255, 88, 26, 22),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     imagePicker
                  //         .pickImage(source: ImageSource.gallery)
                  //         .then((value) {
                  //       setState(() {
                  //         profilepic = File(value!.path);
                  //       });
                  //     });
                  //   },
                  //   child: profilepic == null
                  //       ? Container(
                  //           height: 200,
                  //           width: 200,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             color: Colors.black12,
                  //           ),
                  //           child: const Icon(Icons.add_a_photo_outlined),
                  //           padding: const EdgeInsets.all(8.0),
                  //         )
                  //       : Container(
                  //           height: 250,
                  //           width: 250,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             image: DecorationImage(
                  //                 fit: BoxFit.cover,
                  //                 image: FileImage(profilepic!)),
                  //             color: Colors.black12,
                  //           ),
                  //           padding: const EdgeInsets.all(8.0),
                  //         ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        readOnly: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: yourname,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0),
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'YOUR NAME',
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        readOnly: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: email,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0),
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Email Id',
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        ProfileRequesst profileRequesst = ProfileRequesst(
                            filename: profilepic!.path,
                            userid: '1',
                            name: yourname.value.text,
                            email: email.value.text);
                        apiServices.profile(profileRequesst).then((value) {
                          if (value == null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'MainHomePage', (route) => false);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 88, 26, 22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 25.0,
                              spreadRadius: 1.0,
                              offset: const Offset(
                                5.0,
                                10.0,
                              ),
                            )
                          ],
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BezierContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
            angle: -pi / 3.5,
            child: ClipPath(
                clipper: ClipPainter(),
                child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0xfffbb448),
                          Color(0xffe46b10)
                        ]))))));
  }
}

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Top Left corner]
    var secondControlPoint = Offset(0, 0);
    var secondEndPoint = Offset(width * .2, height * .3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    /// [Left Middle]
    var fifthControlPoint = Offset(width * .3, height * .5);
    var fiftEndPoint = Offset(width * .23, height * .6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fiftEndPoint.dx, fiftEndPoint.dy);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
