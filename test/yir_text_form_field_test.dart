import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'; 
import 'package:yir_text_form_field/yir_text_form_field.dart';

void main() {
  test('YirTextFormField creates successfully', () {
    final controller = TextEditingController();
    final field = YirTextFormField(
      controller: controller,
      hint: 'Test hint',
      label: 'Test Label',
    );

    expect(field.controller, controller);
    expect(field.hint, 'Test hint');
    expect(field.label, 'Test Label');
    expect(field.enableGlowPulse, true); // Default value
    expect(field.enableShimmer, true);
    expect(field.enableFloat, true);
    expect(field.enableTapEffect, true);
  });

  test('YirTextFormField animations can be disabled', () {
    final controller = TextEditingController();
    final field = YirTextFormField(
      controller: controller,
      hint: 'Test',
      enableGlowPulse: false,
      enableShimmer: false,
      enableFloat: false,
      enableTapEffect: false,
    );

    expect(field.enableGlowPulse, false);
    expect(field.enableShimmer, false);
    expect(field.enableFloat, false);
    expect(field.enableTapEffect, false);
  });

  test('YirTextFormField blur and animation speed can be customized', () {
    final controller = TextEditingController();
    final field = YirTextFormField(
      controller: controller,
      hint: 'Test',
      blur: 20,
      animationSpeed: 0.5,
    );

    expect(field.blur, 20);
    expect(field.animationSpeed, 0.5);
  });
}