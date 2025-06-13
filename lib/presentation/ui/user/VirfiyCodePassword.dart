import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/ForgetPasswordViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/VerificationViewModel.dart';

class VirfiyCodePassword extends StatefulWidget {
  const VirfiyCodePassword({Key? key}) : super(key: key);

  @override
  _VerificationUiState createState() => _VerificationUiState();
}

class _VerificationUiState extends State<VirfiyCodePassword> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavigationServiceImpl navigationServiceImpl =
        GetIt.I.get<NavigationServiceImpl>();
    return CubitProvider(
      create: (context) => ForgetPasswordViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Stack(
              children: [
                Positioned.fill(
                  top: kIsWeb ? 0 : 15,
                  child: Image.asset(
                    'assets/Rectangle21.png', // Path to your SVG file
                    fit: BoxFit.fitWidth,
                    // To cover the entire AppBar
                  ),
                ),
                AppBar(
                  title: Text(
                    "verification_code".tr,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor:
                      Colors.transparent, // Make AppBar transparent
                  elevation: 0, // Remove shadow
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24),
                Text(
                  "verification_code".tr,
                  style: TextStyle(
                    fontFamily: 'IRANSansXFaNum',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF353842),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          _buildCodeInputField(index, bloc),
                        ],
                      ),
                    ).reversed.toList(),
                  ),
                ),
                SizedBox(height: 12),
                StreamBuilder<int>(
                  stream: bloc.timerStream,
                  initialData: 0,
                  builder: (context, snapshot) {
                    // Check bloc.state.isLoading here
                    return bloc.state.isLoading
                        ? const MyLoader()
                        : Text(
                            "${'code_sent'.tr} ${bloc.myTimer.formatTime()}",
                            style: const TextStyle(
                              fontFamily: 'IRANSansXFaNum',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF505463),
                            ),
                          );
                  },
                ),
                8.dpv,
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Call confirmation logic when the button is pressed
                      bloc.confirmCode();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Center(
                      child: bloc.state.isLoading
                          ? const MyLoader()
                          : Text(
                              "confirm_and_continue".tr,
                              style: TextStyle(
                                fontFamily: 'IRANSansXFaNum',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInputField(int index, ForgetPasswordViewModel bloc) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          focusNode: _focusNodes[index],
          maxLength: 1, // Limit to one digit per field
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            _onCodeChange(value, index, bloc);
          },
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Color(0xFF353842),
          ),
          decoration: InputDecoration(
            counterText: "", // Hide the length counter
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _onCodeChange(String value, int index, ForgetPasswordViewModel bloc) {
    print(index.toString());

    if (value.isNotEmpty && value.length == 1) {
      // Update the specific index in the bloc
      bloc.onCodeChange(value, index); // No need to reverse the index anymore

      // Move to the next field if not the last one
      if (index < _focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(
            _focusNodes[index + 1]); // Increment index to move right
      }
    }
  }
}
