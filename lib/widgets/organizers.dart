import 'package:efficacy_admin/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Organizers extends StatelessWidget {
  Organizers({Key? key, this.contact}) : super(key: key);
  List<dynamic>? contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Added by",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xff05354C),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                size: 32,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact![0]['name'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color(0xff191C1D).withOpacity(0.7),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Text(
                      contact![0]['email'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color(0xff191C1D).withOpacity(0.5),
                          fontSize: 8.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFFF0B6)),
                child: const Center(
                  child: Icon(
                    Icons.call_outlined,
                    size: 14,
                    color: Color(0xffFECC07),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact![0]['phone'],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color(0xff191C1D).withOpacity(0.7),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          "Moderators",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xff05354C),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 32,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Text(
                  contact![0]['name'],
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color(0xff191C1D).withOpacity(0.7),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
