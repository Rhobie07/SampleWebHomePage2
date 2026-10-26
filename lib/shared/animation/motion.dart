import 'package:flutter/material.dart';

const motionDuration = Duration(milliseconds: 220);

bool reduceMotion(BuildContext context) =>
    MediaQuery.disableAnimationsOf(context);
