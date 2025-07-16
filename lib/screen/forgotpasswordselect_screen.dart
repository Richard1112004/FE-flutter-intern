import 'package:begining/provider/pincode_provider.dart';
import 'package:begining/screen/newpassword_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotpasswordselectScreen extends StatelessWidget {
  const ForgotpasswordselectScreen({super.key});
  Widget _buildNumButton(BuildContext context, int number) {
    final provider = Provider.of<PinCodeProvider>(context);
    return TextButton(
      onPressed: () => provider.addDigit(number),
      child: Text(
        number.toString(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pincode = Provider.of<PinCodeProvider>(context, listen: true);
    if (pincode.isCompleted) {
      // Navigate to the next screen when the pin is completed
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NewpasswordScreen(),
          ),
        );
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/login/bubble_03.png', height: 170),
                  SizedBox(width: 148),
                  Image.asset('assets/login/bubble_01.png', height: 170),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OTP',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Enter 4-digits code we sent you on email',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          width: pincode.isPinVisible ? 50 : 16,
                          height: pincode.isPinVisible ? 50 : 16,
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(6.0),
                            color: index < pincode.enteredPin.length
                                ? pincode.isPinVisible
                                      ? Colors.blue
                                      : CupertinoColors.activeBlue
                                : CupertinoColors.activeBlue.withOpacity(0.2),
                          ),
                          child:
                              pincode.isPinVisible &&
                                  index < pincode.enteredPin.length
                              ? Center(
                                  child: Text(
                                    pincode.enteredPin[index],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        IconButton(
                          onPressed: pincode.togglePinVisibility,
                          icon: Icon(
                            pincode.isPinVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: pincode.isPinVisible ? 50.0 : 8.0),
                      ],
                    ),
                    Column(
                      children: [
                        // Digits 1-9
                        for (var i = 0; i < 3; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                3,
                                (index) =>
                                    _buildNumButton(context, 1 + 3 * i + index),
                              ).toList(),
                            ),
                          ),

                        // 0 digit with backspace
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextButton(
                                onPressed: null,
                                child: SizedBox(),
                              ),
                              _buildNumButton(context, 0),
                              TextButton(
                                onPressed: pincode.removeLastDigit,
                                child: const Icon(
                                  Icons.backspace,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Reset button
                        TextButton(
                          onPressed: pincode.resetPin,
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
