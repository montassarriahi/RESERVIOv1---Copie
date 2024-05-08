import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatefulWidget {
  final bool isNewImageSelected;
  final bool hasProfileImage;
  final Function getImage;
  final File? imageFile;
  final Map<String, dynamic> userData;
  final Function getProfileImage; 
  
  const ProfileImage({
    required this.isNewImageSelected,
    required this.hasProfileImage,
    required this.getImage,
    required this.imageFile,
    required this.userData,
    required this.getProfileImage, 
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.getImage();
      },
      child: SizedBox(
        height: 119,
        width: 119,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircleAvatar(
              backgroundImage:
                  (widget.isNewImageSelected || !widget.hasProfileImage)
                      ? (widget.imageFile != null
                          ? FileImage(widget.imageFile!)
                          : null)
                      : widget.getProfileImage(widget.userData),
              child: widget.hasProfileImage
                  ? null
                  : Icon(Icons.person, size: 100, color: Colors.white),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: IconButton(
                  onPressed: () {
                    widget.getImage();
                  },
                  icon: SvgPicture.asset("assets/images/cameraIcons.svg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
