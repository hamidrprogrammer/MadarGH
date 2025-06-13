import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_ios_app/utils.dart';

class Login4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFEFC),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.962, -1),
                          end: Alignment(0.949, 1),
                          colors: <Color>[Color(0xFFF15B67), Color(0xFF9E3840)],
                          stops: <double>[0, 1],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 11, 33.2, 10),
                        child: Text(
                          'ورود به حساب کاربری',
                          style: TextStyle(
                            
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.8,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Text(
                            'نام کاربری خود را وارد کنید.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.1,
                              color: Color(0xFF353842),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                              child: Text(
                                'ایمیل یا شماره موبایل',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1.7,
                                  color: Color(0xFF505463),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'از صفحه کلید انگلیسی استفاده کنید.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 2,
                            color: Color(0xFF5F6286),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 249),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Text(
                            'رمز عبور',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.1,
                              color: Color(0xFF353842),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                              child: Text(
                                'رمز عبور خود را وارد کنید',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1.7,
                                  color: Color(0xFF505463),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'از صفحه کلید انگلیسی استفاده کنید.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 2,
                            color: Color(0xFF5F6286),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF9E3840),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Text(
                          'تایید و ادامه',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'ایجاد حساب کاربری جدید',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 2,
                        color: Color(0xFF9E3840),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -8.5,
              top: 274,
              child: SizedBox(
                height: 24,
                child: Text(
                  'فراموشی رمز عبور',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 2,
                    color: Color(0xFF9E3840),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
